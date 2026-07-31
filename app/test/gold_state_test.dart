import 'package:flutter_test/flutter_test.dart';
import 'package:gas_pulse/src/features/gold/domain/gold_price_tick.dart';
import 'package:gas_pulse/src/features/gold/domain/gold_state.dart';

void main() {
  test('parses backend tick status and exposes computed date', () {
    final tick = GoldPriceTick.fromJson({
      'symbol': 'XAU/USD',
      'price': 2650.42,
      'timestamp': 1718293847123,
      'status': 'UP',
    });

    expect(tick.status, GoldPriceStatus.up);
    expect(tick.isRising, isTrue);
    expect(tick.occurredAt.millisecondsSinceEpoch, 1718293847123);
  });

  test('calculates session statistics from ticks', () {
    final state = GoldState(
      connectionStatus: GoldConnectionStatus.live,
      ticks: [
        _tick(price: 2650.00, status: GoldPriceStatus.equal),
        _tick(price: 2655.50, status: GoldPriceStatus.up),
        _tick(price: 2648.25, status: GoldPriceStatus.down),
      ],
    );

    expect(state.current?.price, 2648.25);
    expect(state.sessionHigh, 2655.50);
    expect(state.sessionLow, 2648.25);
    expect(state.absoluteChange, closeTo(-1.75, .00001));
    expect(state.percentageChange, closeTo(-0.0660, .0001));
  });
}

GoldPriceTick _tick({required double price, required GoldPriceStatus status}) =>
    GoldPriceTick(
      symbol: 'XAU/USD',
      price: price,
      timestamp: 1718293847123,
      status: status,
    );
