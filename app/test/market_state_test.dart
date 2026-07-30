import 'package:flutter_test/flutter_test.dart';
import 'package:gas_pulse/src/features/market/domain/gas_price_tick.dart';
import 'package:gas_pulse/src/features/market/domain/market_state.dart';

void main() {
  test('parses backend tick status and exposes computed date', () {
    final tick = GasPriceTick.fromJson({
      'symbol': 'NGAS/USD',
      'price': 2.853,
      'timestamp': 1718293847123,
      'status': 'UP',
    });

    expect(tick.status, PriceStatus.up);
    expect(tick.isRising, isTrue);
    expect(tick.occurredAt.millisecondsSinceEpoch, 1718293847123);
  });

  test('calculates session statistics from ticks', () {
    final state = MarketState(
      connectionStatus: MarketConnectionStatus.live,
      ticks: [
        _tick(price: 2.8, status: PriceStatus.equal),
        _tick(price: 2.9, status: PriceStatus.up),
        _tick(price: 2.7, status: PriceStatus.down),
      ],
    );

    expect(state.current?.price, 2.7);
    expect(state.sessionHigh, 2.9);
    expect(state.sessionLow, 2.7);
    expect(state.absoluteChange, closeTo(-.1, .00001));
    expect(state.percentageChange, closeTo(-3.5714, .0001));
  });
}

GasPriceTick _tick({required double price, required PriceStatus status}) =>
    GasPriceTick(
      symbol: 'NGAS/USD',
      price: price,
      timestamp: 1718293847123,
      status: status,
    );
