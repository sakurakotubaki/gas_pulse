import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_pulse/src/app.dart';
import 'package:gas_pulse/src/features/stocks/application/stock_feed.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_feed_state.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_snapshot.dart';

void main() {
  testWidgets('shows the market dashboard while connecting', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GasPulseApp()));
    await tester.pump();

    expect(find.text('GAS / PULSE'), findsOneWidget);
    expect(find.text('Energy in\nmotion.'), findsOneWidget);
    expect(find.text('CONNECTING'), findsOneWidget);

    await tester.tap(find.text('TSE DEMO'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('TOKYO / VIRTUAL'), findsOneWidget);
    expect(find.text('Tokyo momentum'), findsOneWidget);
  });

  testWidgets('stock header does not overflow at iPhone width', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [stockFeedProvider.overrideWith(_FakeStockFeed.new)],
        child: const GasPulseApp(),
      ),
    );
    await tester.tap(find.text('TSE DEMO'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('TOKYO / VIRTUAL'), findsOneWidget);
    expect(find.text('LIVE'), findsOneWidget);
    expect(find.textContaining('UPDATED'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FakeStockFeed extends StockFeed {
  @override
  StockFeedState build() => StockFeedState(
    connectionStatus: StockConnectionStatus.live,
    snapshot: StockSnapshot(
      market: 'TSE-DEMO',
      timestamp: DateTime(2026, 7, 30, 23, 3).millisecondsSinceEpoch,
      quotes: const [
        StockQuote(
          symbol: '7203',
          name: 'TOYOTA',
          price: 2850,
          change: 12,
          changePercent: .42,
          direction: StockDirection.up,
        ),
      ],
    ),
  );
}
