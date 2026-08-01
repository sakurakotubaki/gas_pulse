import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_price_tick.dart';

part 'oil_state.freezed.dart';

enum OilConnectionStatus { connecting, live, reconnecting, disconnected }

@freezed
abstract class OilState with _$OilState {
  const OilState._();

  const factory OilState({
    @Default(OilConnectionStatus.connecting)
    OilConnectionStatus connectionStatus,
    @Default(<OilPriceTick>[]) List<OilPriceTick> ticks,
    String? errorMessage,
  }) = _OilState;

  OilPriceTick? get current => ticks.lastOrNull;
  OilPriceTick? get opening => ticks.firstOrNull;
  double? get high => ticks.isEmpty
      ? null
      : ticks.map((tick) => tick.price).reduce((a, b) => a > b ? a : b);
  double? get low => ticks.isEmpty
      ? null
      : ticks.map((tick) => tick.price).reduce((a, b) => a < b ? a : b);
  double get change =>
      current == null || opening == null ? 0 : current!.price - opening!.price;
  double get changePercent => opening == null || opening!.price == 0
      ? 0
      : change / opening!.price * 100;
}
