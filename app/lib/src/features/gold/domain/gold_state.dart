import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gas_pulse/src/features/gold/domain/gold_price_tick.dart';

part 'gold_state.freezed.dart';

enum GoldConnectionStatus { connecting, live, reconnecting, disconnected }

@freezed
abstract class GoldState with _$GoldState {
  const GoldState._();

  const factory GoldState({
    @Default(GoldConnectionStatus.connecting)
    GoldConnectionStatus connectionStatus,
    @Default(<GoldPriceTick>[]) List<GoldPriceTick> ticks,
    String? errorMessage,
  }) = _GoldState;

  GoldPriceTick? get current => ticks.lastOrNull;
  GoldPriceTick? get opening => ticks.firstOrNull;
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
