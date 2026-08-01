import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gas_pulse/src/features/oil/data/oil_history_repository.dart';
import 'package:gas_pulse/src/features/oil/data/oil_price_repository.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_position.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_price_tick.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'oil_feed.g.dart';

const _backendHost = String.fromEnvironment('BACKEND_HOST');
const _backendPort = int.fromEnvironment('BACKEND_PORT', defaultValue: 8080);
const _backendScheme = String.fromEnvironment(
  'BACKEND_SCHEME',
  defaultValue: 'ws',
);

String _host() => _backendHost.isNotEmpty
    ? _backendHost
    : !kIsWeb && defaultTargetPlatform == TargetPlatform.android
    ? '10.0.2.2'
    : 'localhost';

@Riverpod(keepAlive: true)
Uri oilEndpoint(Ref ref) => Uri(
  scheme: _backendScheme,
  host: _host(),
  port: _backendPort,
  path: '/ws/oil',
);

@Riverpod(keepAlive: true)
class RedisCacheEnabled extends _$RedisCacheEnabled {
  @override
  bool build() => true;

  void setEnabled(bool enabled) => state = enabled;
}

@Riverpod(keepAlive: true)
OilPriceRepository oilPriceRepository(Ref ref) {
  final repository = OilPriceRepository();
  ref.onDispose(repository.close);
  return repository;
}

@Riverpod(keepAlive: true)
OilHistoryRepository oilHistoryRepository(Ref ref) {
  final repository = OilHistoryRepository();
  ref.onDispose(repository.close);
  return repository;
}

@riverpod
Future<OilHistoryResult> oilHistory(Ref ref) {
  final cacheEnabled = ref.watch(redisCacheEnabledProvider);
  final scheme = _backendScheme == 'wss' ? 'https' : 'http';
  return ref
      .read(oilHistoryRepositoryProvider)
      .fetch(
        Uri(
          scheme: scheme,
          host: _host(),
          port: _backendPort,
          path: '/api/oil/history',
          queryParameters: cacheEnabled ? null : const {'no_cache': 'true'},
        ),
      );
}

@Riverpod(keepAlive: true)
class OilFeed extends _$OilFeed {
  StreamSubscription<OilPriceTick>? _subscription;
  Timer? _reconnectTimer;
  int _attempt = 0;

  @override
  OilState build() {
    ref.onDispose(_dispose);
    Future<void>.microtask(_connect);
    return const OilState();
  }

  Future<void> retry() async {
    _attempt = 0;
    await _connect();
  }

  Future<void> _connect() async {
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
    if (!ref.mounted) return;
    state = state.copyWith(
      connectionStatus: _attempt == 0
          ? OilConnectionStatus.connecting
          : OilConnectionStatus.reconnecting,
      errorMessage: null,
    );
    _subscription = ref
        .read(oilPriceRepositoryProvider)
        .watch(ref.read(oilEndpointProvider))
        .listen(
          _handleTick,
          onError: (Object _, StackTrace _) => _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _handleTick(OilPriceTick tick) {
    _attempt = 0;
    final ticks = [...state.ticks, tick];
    state = state.copyWith(
      connectionStatus: OilConnectionStatus.live,
      ticks: ticks.length > 120 ? ticks.sublist(ticks.length - 120) : ticks,
      errorMessage: null,
    );
  }

  void _scheduleReconnect() {
    if (!ref.mounted || _reconnectTimer?.isActive == true) return;
    _attempt += 1;
    final seconds = (1 << (_attempt - 1).clamp(0, 4)).clamp(1, 15);
    state = state.copyWith(
      connectionStatus: OilConnectionStatus.reconnecting,
      errorMessage: '石油価格サーバーへ再接続しています',
    );
    _reconnectTimer = Timer(Duration(seconds: seconds), _connect);
  }

  void _dispose() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
  }
}

@Riverpod(keepAlive: true)
class OilPositions extends _$OilPositions {
  int _nextId = 1;

  @override
  List<OilPosition> build() => const [];

  void open(OilPositionSide side, double price) {
    state = [
      ...state,
      OilPosition(
        id: _nextId++,
        side: side,
        entryPrice: price,
        openedAt: DateTime.now(),
      ),
    ];
  }

  void closeAll() => state = const [];
}
