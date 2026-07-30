import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gas_pulse/src/features/stocks/data/stock_repository.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_feed_state.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stock_feed.g.dart';

const _backendHost = String.fromEnvironment('BACKEND_HOST');
const _backendPort = int.fromEnvironment('BACKEND_PORT', defaultValue: 8080);
const _backendScheme = String.fromEnvironment(
  'BACKEND_SCHEME',
  defaultValue: 'ws',
);

@Riverpod(keepAlive: true)
Uri stockEndpoint(Ref ref) {
  final host = _backendHost.isNotEmpty
      ? _backendHost
      : !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2'
      : 'localhost';
  return Uri(
    scheme: _backendScheme,
    host: host,
    port: _backendPort,
    path: '/ws/stocks',
  );
}

@Riverpod(keepAlive: true)
StockRepository stockRepository(Ref ref) {
  final repository = StockRepository();
  ref.onDispose(repository.close);
  return repository;
}

@Riverpod(keepAlive: true)
class StockFeed extends _$StockFeed {
  StreamSubscription<StockSnapshot>? _subscription;
  Timer? _reconnectTimer;
  int _attempt = 0;

  @override
  StockFeedState build() {
    ref.onDispose(_dispose);
    Future<void>.microtask(_connect);
    return const StockFeedState();
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
          ? StockConnectionStatus.connecting
          : StockConnectionStatus.reconnecting,
      errorMessage: null,
    );
    _subscription = ref
        .read(stockRepositoryProvider)
        .watch(ref.read(stockEndpointProvider))
        .listen(
          _handleSnapshot,
          onError: (Object error, StackTrace stackTrace) =>
              _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _handleSnapshot(StockSnapshot snapshot) {
    _attempt = 0;
    state = state.copyWith(
      connectionStatus: StockConnectionStatus.live,
      snapshot: snapshot,
      errorMessage: null,
    );
  }

  void _scheduleReconnect() {
    if (!ref.mounted || _reconnectTimer?.isActive == true) return;
    _attempt += 1;
    final seconds = (1 << (_attempt - 1).clamp(0, 4)).clamp(1, 15);
    state = state.copyWith(
      connectionStatus: StockConnectionStatus.reconnecting,
      errorMessage: '株価サーバーへ再接続しています',
    );
    _reconnectTimer = Timer(Duration(seconds: seconds), _connect);
  }

  void _dispose() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
  }
}
