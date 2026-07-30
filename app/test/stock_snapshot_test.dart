import 'package:flutter_test/flutter_test.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_snapshot.dart';

void main() {
  test('parses virtual TSE snapshot and calculates market breadth', () {
    final snapshot = StockSnapshot.fromJson({
      'market': 'TSE-DEMO',
      'timestamp': 1718293847123,
      'quotes': [
        {
          'symbol': '7203',
          'name': 'TOYOTA',
          'price': 2878.5,
          'change': 28.5,
          'changePercent': 1.0,
          'direction': 'UP',
        },
        {
          'symbol': '6758',
          'name': 'SONY GROUP',
          'price': 3385.8,
          'change': -34.2,
          'changePercent': -1.0,
          'direction': 'DOWN',
        },
      ],
    });

    expect(snapshot.market, 'TSE-DEMO');
    expect(snapshot.gainers, 1);
    expect(snapshot.losers, 1);
    expect(snapshot.averageChange, 0);
    expect(snapshot.quotes.first.isPositive, isTrue);
  });
}
