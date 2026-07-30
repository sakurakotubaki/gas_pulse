import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_snapshot.dart';

part 'stock_feed_state.freezed.dart';

enum StockConnectionStatus { connecting, live, reconnecting, disconnected }

@freezed
abstract class StockFeedState with _$StockFeedState {
  const factory StockFeedState({
    @Default(StockConnectionStatus.connecting)
    StockConnectionStatus connectionStatus,
    StockSnapshot? snapshot,
    String? errorMessage,
  }) = _StockFeedState;
}
