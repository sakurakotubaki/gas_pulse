// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oil_price_tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OilPriceTick _$OilPriceTickFromJson(Map<String, dynamic> json) =>
    _OilPriceTick(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      timestamp: (json['timestamp'] as num).toInt(),
      status: $enumDecode(_$OilPriceStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$OilPriceTickToJson(_OilPriceTick instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'timestamp': instance.timestamp,
      'status': _$OilPriceStatusEnumMap[instance.status]!,
    };

const _$OilPriceStatusEnumMap = {
  OilPriceStatus.up: 'UP',
  OilPriceStatus.down: 'DOWN',
  OilPriceStatus.equal: 'EQUAL',
};
