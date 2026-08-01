// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_price_tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoldPriceTick _$GoldPriceTickFromJson(Map<String, dynamic> json) =>
    _GoldPriceTick(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      timestamp: (json['timestamp'] as num).toInt(),
      status: $enumDecode(_$GoldPriceStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$GoldPriceTickToJson(_GoldPriceTick instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'timestamp': instance.timestamp,
      'status': _$GoldPriceStatusEnumMap[instance.status]!,
    };

const _$GoldPriceStatusEnumMap = {
  GoldPriceStatus.up: 'UP',
  GoldPriceStatus.down: 'DOWN',
  GoldPriceStatus.equal: 'EQUAL',
};
