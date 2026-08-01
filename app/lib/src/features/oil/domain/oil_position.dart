enum OilPositionSide { buy, sell }

class OilPosition {
  const OilPosition({
    required this.id,
    required this.side,
    required this.entryPrice,
    required this.openedAt,
    this.size = 100,
  });

  final int id;
  final OilPositionSide side;
  final double entryPrice;
  final DateTime openedAt;
  final double size;

  double profitLoss(double currentPrice) => switch (side) {
    OilPositionSide.buy => (currentPrice - entryPrice) * size,
    OilPositionSide.sell => (entryPrice - currentPrice) * size,
  };
}
