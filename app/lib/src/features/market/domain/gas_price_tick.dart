import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas_price_tick.freezed.dart';
part 'gas_price_tick.g.dart';

enum PriceStatus {
  @JsonValue('UP')
  up,
  @JsonValue('DOWN')
  down,
  @JsonValue('EQUAL')
  equal,
}

@freezed
abstract class GasPriceTick with _$GasPriceTick {
  const GasPriceTick._();

  const factory GasPriceTick({
    required String symbol,
    required double price,
    required int timestamp,
    required PriceStatus status,
  }) = _GasPriceTick;

  factory GasPriceTick.fromJson(Map<String, dynamic> json) =>
      _$GasPriceTickFromJson(json);

  DateTime get occurredAt =>
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  bool get isRising => status == PriceStatus.up;
  bool get isFalling => status == PriceStatus.down;
}
