// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_price_tick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GasPriceTick _$GasPriceTickFromJson(Map<String, dynamic> json) =>
    _GasPriceTick(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      timestamp: (json['timestamp'] as num).toInt(),
      status: $enumDecode(_$PriceStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$GasPriceTickToJson(_GasPriceTick instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'timestamp': instance.timestamp,
      'status': _$PriceStatusEnumMap[instance.status]!,
    };

const _$PriceStatusEnumMap = {
  PriceStatus.up: 'UP',
  PriceStatus.down: 'DOWN',
  PriceStatus.equal: 'EQUAL',
};
