import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_pulse/src/app.dart';
import 'package:gas_pulse/src/features/oil/application/oil_feed.dart';
import 'package:gas_pulse/src/features/oil/data/oil_history_repository.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_position.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_price_tick.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_state.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const _tick = OilPriceTick(
  symbol: 'OIL/USD',
  price: 78.42,
  timestamp: 1785592800000,
  status: OilPriceStatus.up,
);

void main() {
  test('oil position calculates BUY and SELL PnL', () {
    final buy = OilPosition(
      id: 1,
      side: OilPositionSide.buy,
      entryPrice: 78,
      openedAt: DateTime(2026),
    );
    final sell = OilPosition(
      id: 2,
      side: OilPositionSide.sell,
      entryPrice: 80,
      openedAt: DateTime(2026),
    );

    expect(buy.profitLoss(79), 100);
    expect(sell.profitLoss(79), 100);
  });

  test('history repository parses ticks and X-Cache', () async {
    final repository = OilHistoryRepository(
      client: MockClient(
        (_) async => http.Response(
          '[{"symbol":"OIL/USD","price":78.42,'
          '"timestamp":1785592800000,"status":"UP"}]',
          200,
          headers: {'x-cache': 'hit'},
        ),
      ),
    );

    final result = await repository.fetch(Uri.parse('http://localhost/oil'));

    expect(result.cacheStatus, 'HIT');
    expect(result.ticks, [_tick]);
  });

  test('cache toggle adds no_cache to the history request', () async {
    final repository = _RecordingHistoryRepository();
    final container = ProviderContainer(
      overrides: [oilHistoryRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(oilHistoryProvider.future);
    expect(repository.lastEndpoint?.queryParameters, isEmpty);

    container.read(redisCacheEnabledProvider.notifier).setEnabled(false);
    await container.read(oilHistoryProvider.future);
    expect(repository.lastEndpoint?.queryParameters['no_cache'], 'true');
  });

  testWidgets('oil tab trades and closes all positions without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          oilFeedProvider.overrideWith(_FakeOilFeed.new),
          oilHistoryProvider.overrideWith(
            (_) async =>
                const OilHistoryResult(ticks: [_tick], cacheStatus: 'HIT'),
          ),
        ],
        child: const GasPulseApp(),
      ),
    );
    await tester.tap(find.text('OIL'));
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('OIL / PULSE'), findsOneWidget);
    expect(find.textContaining('REDIS ON'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.byKey(const ValueKey('oil-buy')));
    await tester.tap(find.byKey(const ValueKey('oil-buy')));
    await tester.pump();
    expect(find.text('OPEN POSITIONS · 1'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const ValueKey('oil-close-all')));
    await tester.tap(find.byKey(const ValueKey('oil-close-all')));
    await tester.pump();
    expect(find.text('OPEN POSITIONS · 0'), findsOneWidget);
  });
}

class _FakeOilFeed extends OilFeed {
  @override
  OilState build() => const OilState(
    connectionStatus: OilConnectionStatus.live,
    ticks: [_tick],
  );
}

class _RecordingHistoryRepository extends OilHistoryRepository {
  Uri? lastEndpoint;

  @override
  Future<OilHistoryResult> fetch(Uri endpoint) async {
    lastEndpoint = endpoint;
    return const OilHistoryResult(ticks: [_tick], cacheStatus: 'HIT');
  }
}
