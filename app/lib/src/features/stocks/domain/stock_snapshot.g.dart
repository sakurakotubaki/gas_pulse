// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockQuote _$StockQuoteFromJson(Map<String, dynamic> json) => _StockQuote(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  change: (json['change'] as num).toDouble(),
  changePercent: (json['changePercent'] as num).toDouble(),
  direction: $enumDecode(_$StockDirectionEnumMap, json['direction']),
);

Map<String, dynamic> _$StockQuoteToJson(_StockQuote instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'price': instance.price,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'direction': _$StockDirectionEnumMap[instance.direction]!,
    };

const _$StockDirectionEnumMap = {
  StockDirection.up: 'UP',
  StockDirection.down: 'DOWN',
  StockDirection.equal: 'EQUAL',
};

_StockSnapshot _$StockSnapshotFromJson(Map<String, dynamic> json) =>
    _StockSnapshot(
      market: json['market'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      quotes: (json['quotes'] as List<dynamic>)
          .map((e) => StockQuote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockSnapshotToJson(_StockSnapshot instance) =>
    <String, dynamic>{
      'market': instance.market,
      'timestamp': instance.timestamp,
      'quotes': instance.quotes,
    };
