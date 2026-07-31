import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gas_pulse/src/features/gold/data/gold_price_repository.dart';
import 'package:gas_pulse/src/features/gold/domain/gold_price_tick.dart';
import 'package:gas_pulse/src/features/gold/domain/gold_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gold_feed.g.dart';

const _backendHost = String.fromEnvironment('BACKEND_HOST');
const _backendPort = int.fromEnvironment('BACKEND_PORT', defaultValue: 8080);
const _backendScheme = String.fromEnvironment(
  'BACKEND_SCHEME',
  defaultValue: 'ws',
);

@Riverpod(keepAlive: true)
Uri goldEndpoint(Ref ref) {
  final host = _backendHost.isNotEmpty
      ? _backendHost
      : !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2'
      : 'localhost';
  return Uri(
    scheme: _backendScheme,
    host: host,
    port: _backendPort,
    path: '/ws/gold',
  );
}

@Riverpod(keepAlive: true)
GoldPriceRepository goldPriceRepository(Ref ref) {
  final repository = GoldPriceRepository();
  ref.onDispose(repository.close);
  return repository;
}

@Riverpod(keepAlive: true)
class GoldFeed extends _$GoldFeed {
  StreamSubscription<GoldPriceTick>? _subscription;
  Timer? _reconnectTimer;
  int _attempt = 0;

  @override
  GoldState build() {
    ref.onDispose(_dispose);
    Future<void>.microtask(_connect);
    return const GoldState();
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
          ? GoldConnectionStatus.connecting
          : GoldConnectionStatus.reconnecting,
      errorMessage: null,
    );
    final repository = ref.read(goldPriceRepositoryProvider);
    _subscription = repository
        .watch(ref.read(goldEndpointProvider))
        .listen(
          _handleTick,
          onError: (Object error, StackTrace stackTrace) =>
              _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _handleTick(GoldPriceTick tick) {
    _attempt = 0;
    final ticks = [...state.ticks, tick];
    state = state.copyWith(
      connectionStatus: GoldConnectionStatus.live,
      ticks: ticks.length > 60 ? ticks.sublist(ticks.length - 60) : ticks,
      errorMessage: null,
    );
  }

  void _scheduleReconnect() {
    if (!ref.mounted || _reconnectTimer?.isActive == true) return;
    _attempt += 1;
    final seconds = (1 << (_attempt - 1).clamp(0, 4)).clamp(1, 15);
    state = state.copyWith(
      connectionStatus: GoldConnectionStatus.reconnecting,
      errorMessage: '金価格サーバーへ再接続しています',
    );
    _reconnectTimer = Timer(Duration(seconds: seconds), _connect);
  }

  void _dispose() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
  }
}
