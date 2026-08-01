import 'package:freezed_annotation/freezed_annotation.dart';

part 'oil_price_tick.freezed.dart';
part 'oil_price_tick.g.dart';

enum OilPriceStatus {
  @JsonValue('UP')
  up,
  @JsonValue('DOWN')
  down,
  @JsonValue('EQUAL')
  equal,
}

@freezed
abstract class OilPriceTick with _$OilPriceTick {
  const OilPriceTick._();

  const factory OilPriceTick({
    required String symbol,
    required double price,
    required int timestamp,
    required OilPriceStatus status,
  }) = _OilPriceTick;

  factory OilPriceTick.fromJson(Map<String, dynamic> json) =>
      _$OilPriceTickFromJson(json);

  DateTime get occurredAt =>
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
}
