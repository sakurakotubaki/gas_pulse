import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gas_pulse/src/features/market/domain/gas_price_tick.dart';

part 'market_state.freezed.dart';

enum MarketConnectionStatus { connecting, live, reconnecting, disconnected }

@freezed
abstract class MarketState with _$MarketState {
  const MarketState._();

  const factory MarketState({
    @Default(MarketConnectionStatus.connecting)
    MarketConnectionStatus connectionStatus,
    @Default(<GasPriceTick>[]) List<GasPriceTick> ticks,
    String? errorMessage,
  }) = _MarketState;

  GasPriceTick? get current => ticks.lastOrNull;
  GasPriceTick? get opening => ticks.firstOrNull;
  double? get sessionHigh =>
      ticks.isEmpty ? null : ticks.map((e) => e.price).reduce(_max);
  double? get sessionLow =>
      ticks.isEmpty ? null : ticks.map((e) => e.price).reduce(_min);

  double get absoluteChange {
    if (opening == null || current == null) return 0;
    return current!.price - opening!.price;
  }

  double get percentageChange => opening == null || opening!.price == 0
      ? 0
      : absoluteChange / opening!.price * 100;
}

double _max(double a, double b) => a > b ? a : b;
double _min(double a, double b) => a < b ? a : b;
