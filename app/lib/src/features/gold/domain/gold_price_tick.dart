import 'package:freezed_annotation/freezed_annotation.dart';

part 'gold_price_tick.freezed.dart';
part 'gold_price_tick.g.dart';

enum GoldPriceStatus {
  @JsonValue('UP')
  up,
  @JsonValue('DOWN')
  down,
  @JsonValue('EQUAL')
  equal,
}

@freezed
abstract class GoldPriceTick with _$GoldPriceTick {
  const GoldPriceTick._();

  const factory GoldPriceTick({
    required String symbol,
    required double price,
    required int timestamp,
    required GoldPriceStatus status,
  }) = _GoldPriceTick;

  factory GoldPriceTick.fromJson(Map<String, dynamic> json) =>
      _$GoldPriceTickFromJson(json);

  DateTime get occurredAt =>
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  bool get isRising => status == GoldPriceStatus.up;
  bool get isFalling => status == GoldPriceStatus.down;
}
