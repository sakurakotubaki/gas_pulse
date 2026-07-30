import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_snapshot.freezed.dart';
part 'stock_snapshot.g.dart';

enum StockDirection {
  @JsonValue('UP')
  up,
  @JsonValue('DOWN')
  down,
  @JsonValue('EQUAL')
  equal,
}

@freezed
abstract class StockQuote with _$StockQuote {
  const StockQuote._();

  const factory StockQuote({
    required String symbol,
    required String name,
    required double price,
    required double change,
    required double changePercent,
    required StockDirection direction,
  }) = _StockQuote;

  factory StockQuote.fromJson(Map<String, dynamic> json) =>
      _$StockQuoteFromJson(json);

  bool get isPositive => direction == StockDirection.up;
}

@freezed
abstract class StockSnapshot with _$StockSnapshot {
  const StockSnapshot._();

  const factory StockSnapshot({
    required String market,
    required int timestamp,
    required List<StockQuote> quotes,
  }) = _StockSnapshot;

  factory StockSnapshot.fromJson(Map<String, dynamic> json) =>
      _$StockSnapshotFromJson(json);

  DateTime get occurredAt =>
      DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  int get gainers => quotes.where((quote) => quote.change > 0).length;
  int get losers => quotes.where((quote) => quote.change < 0).length;
  double get averageChange => quotes.isEmpty
      ? 0
      : quotes.fold<double>(0, (sum, quote) => sum + quote.changePercent) /
            quotes.length;
}
