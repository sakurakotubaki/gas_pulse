import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gas_pulse/src/features/market/data/gas_price_repository.dart';
import 'package:gas_pulse/src/features/market/domain/gas_price_tick.dart';
import 'package:gas_pulse/src/features/market/domain/market_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_feed.g.dart';

const _backendHost = String.fromEnvironment('BACKEND_HOST');
const _backendPort = int.fromEnvironment('BACKEND_PORT', defaultValue: 8080);

@Riverpod(keepAlive: true)
Uri gasPriceEndpoint(Ref ref) {
  final host = _backendHost.isNotEmpty
      ? _backendHost
      : !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2'
      : 'localhost';
  return Uri(scheme: 'ws', host: host, port: _backendPort, path: '/ws/price');
}

@Riverpod(keepAlive: true)
GasPriceRepository gasPriceRepository(Ref ref) {
  final repository = GasPriceRepository();
  ref.onDispose(repository.close);
  return repository;
}

@Riverpod(keepAlive: true)
class MarketFeed extends _$MarketFeed {
  StreamSubscription<GasPriceTick>? _subscription;
  Timer? _reconnectTimer;
  int _attempt = 0;

  @override
  MarketState build() {
    ref.onDispose(_dispose);
    Future<void>.microtask(_connect);
    return const MarketState();
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
          ? MarketConnectionStatus.connecting
          : MarketConnectionStatus.reconnecting,
      errorMessage: null,
    );
    final repository = ref.read(gasPriceRepositoryProvider);
    _subscription = repository
        .watch(ref.read(gasPriceEndpointProvider))
        .listen(
          _handleTick,
          onError: (Object error, StackTrace stackTrace) =>
              _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _handleTick(GasPriceTick tick) {
    _attempt = 0;
    final ticks = [...state.ticks, tick];
    state = state.copyWith(
      connectionStatus: MarketConnectionStatus.live,
      ticks: ticks.length > 60 ? ticks.sublist(ticks.length - 60) : ticks,
      errorMessage: null,
    );
  }

  void _scheduleReconnect() {
    if (!ref.mounted || _reconnectTimer?.isActive == true) return;
    _attempt += 1;
    final seconds = (1 << (_attempt - 1).clamp(0, 4)).clamp(1, 15);
    state = state.copyWith(
      connectionStatus: MarketConnectionStatus.reconnecting,
      errorMessage: '価格サーバーへ再接続しています',
    );
    _reconnectTimer = Timer(Duration(seconds: seconds), _connect);
  }

  void _dispose() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
  }
}
