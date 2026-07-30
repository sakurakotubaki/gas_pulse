import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_pulse/src/features/market/application/market_feed.dart';
import 'package:gas_pulse/src/features/market/domain/gas_price_tick.dart';
import 'package:gas_pulse/src/features/market/domain/market_state.dart';
import 'package:gas_pulse/src/theme/app_theme.dart';
import 'package:intl/intl.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final market = ref.watch(marketFeedProvider);
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _Atmosphere()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                final horizontal = wide ? 48.0 : 20.0;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(horizontal, 22, horizontal, 36),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 58,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Header(market: market),
                        SizedBox(height: wide ? 56 : 36),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _PricePanel(market: market),
                              ),
                              const SizedBox(width: 34),
                              Expanded(
                                flex: 7,
                                child: _ChartPanel(market: market),
                              ),
                            ],
                          )
                        else ...[
                          _PricePanel(market: market),
                          const SizedBox(height: 24),
                          _ChartPanel(market: market),
                        ],
                        const SizedBox(height: 28),
                        _MarketTape(market: market),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.market});
  final MarketState market;

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 520;
      return Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.ink,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'G',
              style: TextStyle(
                fontFamily: 'serif',
                color: AppColors.paper,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'GAS / PULSE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.2,
                  ),
                ),
                Text(
                  'Natural gas intelligence',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.quiet, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _ConnectionPill(
            status: market.connectionStatus,
            compact: compact,
            onRetry: () => ref.read(marketFeedProvider.notifier).retry(),
          ),
        ],
      );
    },
  );
}

class _PricePanel extends StatelessWidget {
  const _PricePanel({required this.market});
  final MarketState market;

  @override
  Widget build(BuildContext context) {
    final current = market.current;
    final positive = market.absoluteChange >= 0;
    final movementColor = positive ? AppColors.positive : AppColors.negative;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LIVE COMMODITY · NGAS/USD',
          style: TextStyle(
            color: AppColors.copper,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Energy in\nmotion.',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 30),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 420),
          switchInCurve: Curves.easeOutQuart,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, .12),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: Text(
            current == null ? '—.———' : '\$${current.price.toStringAsFixed(3)}',
            key: ValueKey(current?.timestamp),
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 46,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(
              positive ? Icons.north_east_rounded : Icons.south_east_rounded,
              color: movementColor,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              '${positive ? '+' : ''}${market.absoluteChange.toStringAsFixed(3)}'
              '  (${positive ? '+' : ''}${market.percentageChange.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: movementColor,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'SESSION',
              style: TextStyle(
                color: AppColors.quiet,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.line),
              bottom: BorderSide(color: AppColors.line),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'HIGH',
                  value: market.sessionHigh?.toStringAsFixed(3) ?? '—',
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'LOW',
                  value: market.sessionLow?.toStringAsFixed(3) ?? '—',
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'TICKS',
                  value: market.ticks.length.toString().padLeft(2, '0'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChartPanel extends StatelessWidget {
  const _ChartPanel({required this.market});
  final MarketState market;

  @override
  Widget build(BuildContext context) => Container(
    height: 430,
    padding: const EdgeInsets.fromLTRB(22, 22, 16, 18),
    decoration: BoxDecoration(
      color: AppColors.ink,
      borderRadius: BorderRadius.circular(4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x26071B2D),
          blurRadius: 34,
          offset: Offset(0, 18),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE VELOCITY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.copperLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Live one-minute feed',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xFF9BAAB2), fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              market.current == null
                  ? 'Waiting for market'
                  : DateFormat('HH:mm:ss').format(market.current!.occurredAt),
              style: const TextStyle(
                color: AppColors.paper,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Expanded(
          child: market.ticks.isEmpty
              ? const _ChartEmptyState()
              : _PriceChart(ticks: market.ticks),
        ),
      ],
    ),
  );
}

class _PriceChart extends StatelessWidget {
  const _PriceChart({required this.ticks});
  final List<GasPriceTick> ticks;

  @override
  Widget build(BuildContext context) {
    final prices = ticks.map((tick) => tick.price).toList();
    final low = prices.reduce((a, b) => a < b ? a : b);
    final high = prices.reduce((a, b) => a > b ? a : b);
    final spread = (high - low).abs();
    final padding = spread < .02 ? .02 : spread * .22;
    final points = [
      for (var i = 0; i < ticks.length; i++)
        FlSpot(i.toDouble(), ticks[i].price),
    ];

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (ticks.length - 1).clamp(1, 59).toDouble(),
        minY: low - padding,
        maxY: high + padding,
        clipData: const FlClipData.all(),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: padding,
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: Color(0x1FFFFFFF), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: padding,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(3),
                style: const TextStyle(color: Color(0xFF82949F), fontSize: 9),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: ticks.length <= 6 ? 1 : ticks.length / 4,
              getTitlesWidget: (value, meta) {
                final index = value.round().clamp(0, ticks.length - 1);
                return Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Text(
                    DateFormat('HH:mm').format(ticks[index].occurredAt),
                    style: const TextStyle(
                      color: Color(0xFF82949F),
                      fontSize: 9,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => AppColors.paper,
            getTooltipItems: (spots) => spots
                .map(
                  (spot) => LineTooltipItem(
                    '\$${spot.y.toStringAsFixed(3)}',
                    const TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: points,
            isCurved: true,
            curveSmoothness: .24,
            color: AppColors.copperLight,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: ticks.length == 1,
              getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                radius: 4,
                color: AppColors.copperLight,
                strokeColor: AppColors.paper,
                strokeWidth: 2,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x5CE4AE74), Color(0x00E4AE74)],
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutQuart,
    );
  }
}

class _MarketTape extends StatelessWidget {
  const _MarketTape({required this.market});
  final MarketState market;

  @override
  Widget build(BuildContext context) {
    final latest = market.current;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Wrap(
        spacing: 28,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'MARKET NOTE',
            style: TextStyle(
              color: AppColors.copper,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
              fontSize: 10,
            ),
          ),
          Text(
            latest == null
                ? 'バックエンドから最初の価格を待っています'
                : '価格はバックエンドの1分バッチに同期して更新されます',
            style: const TextStyle(color: AppColors.inkSoft, fontSize: 12),
          ),
          if (latest != null)
            Text(
              'LAST · ${DateFormat('yyyy.MM.dd  HH:mm:ss').format(latest.occurredAt)}',
              style: const TextStyle(
                color: AppColors.quiet,
                fontSize: 10,
                letterSpacing: .6,
              ),
            ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.quiet,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        value,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _ConnectionPill extends StatelessWidget {
  const _ConnectionPill({
    required this.status,
    required this.compact,
    required this.onRetry,
  });
  final MarketConnectionStatus status;
  final bool compact;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final live = status == MarketConnectionStatus.live;
    final label = switch ((status, compact)) {
      (MarketConnectionStatus.connecting, true) => 'SYNC',
      (MarketConnectionStatus.reconnecting, true) => 'SYNC',
      (MarketConnectionStatus.disconnected, true) => 'OFF',
      (MarketConnectionStatus.live, _) => 'LIVE',
      (MarketConnectionStatus.connecting, false) => 'CONNECTING',
      (MarketConnectionStatus.reconnecting, false) => 'RECONNECTING',
      (MarketConnectionStatus.disconnected, false) => 'OFFLINE',
    };
    return Semantics(
      button: !live,
      label: 'Market connection: $label',
      child: InkWell(
        onTap: live ? null : onRetry,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 13),
          decoration: BoxDecoration(
            color: live ? const Color(0x1420866B) : const Color(0x12C17845),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: live ? const Color(0x4020866B) : const Color(0x40C17845),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(active: live),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: live ? AppColors.positive : AppColors.copper,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot({required this.active});
  final bool active;

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _PulseDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.active) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.active ? AppColors.positive : AppColors.copper;
    return FadeTransition(
      opacity: Tween(begin: .42, end: 1.0).animate(_controller),
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _ChartEmptyState extends StatelessWidget {
  const _ChartEmptyState();

  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            color: AppColors.copperLight,
            strokeWidth: 1.5,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Opening market channel…',
          style: TextStyle(color: Color(0xFF9BAAB2), fontSize: 12),
        ),
      ],
    ),
  );
}

class _Atmosphere extends StatelessWidget {
  const _Atmosphere();

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _AtmospherePainter(),
    child: const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, .5, 1],
          colors: [Color(0xFFF8F3E8), AppColors.canvas, Color(0xFFE8EEE9)],
        ),
      ),
      child: SizedBox.expand(),
    ),
  );
}

class _AtmospherePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0x18C17845);
    for (var i = 0; i < 5; i++) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width * .82, size.height * .12),
          radius: 110 + i * 42,
        ),
        .4,
        2.65,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
