import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_pulse/src/features/stocks/application/stock_feed.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_feed_state.dart';
import 'package:gas_pulse/src/features/stocks/domain/stock_snapshot.dart';
import 'package:intl/intl.dart';

const _midnight = Color(0xFF16151D);
const _aubergine = Color(0xFF32202D);
const _cream = Color(0xFFF4EBDD);
const _brass = Color(0xFFD5A65B);
const _mint = Color(0xFF75C6A6);
const _coral = Color(0xFFE87968);
const _muted = Color(0xFF978E95);

class StockScreen extends ConsumerWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(stockFeedProvider);
    final snapshot = feed.snapshot;
    return Scaffold(
      backgroundColor: _midnight,
      body: Stack(
        children: [
          const Positioned.fill(child: _StockBackdrop()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 920;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    wide ? 46 : 18,
                    22,
                    wide ? 46 : 18,
                    34,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _StockHeader(feed: feed),
                      SizedBox(height: wide ? 42 : 30),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: _BarPanel(snapshot: snapshot),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              flex: 4,
                              child: _ExecutionPanel(snapshot: snapshot),
                            ),
                          ],
                        )
                      else ...[
                        _BarPanel(snapshot: snapshot),
                        const SizedBox(height: 20),
                        _ExecutionPanel(snapshot: snapshot),
                      ],
                      const SizedBox(height: 28),
                      _QuoteBoard(snapshot: snapshot),
                    ],
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

class _StockHeader extends ConsumerWidget {
  const _StockHeader({required this.feed});
  final StockFeedState feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = feed.snapshot;
    final live = feed.connectionStatus == StockConnectionStatus.live;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        final badge = _StockConnectionBadge(
          live: live,
          compact: compact,
          onTap: live
              ? null
              : () => ref.read(stockFeedProvider.notifier).retry(),
        );
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _StockIdentityMark(),
                  const SizedBox(width: 13),
                  const Expanded(child: _StockIdentityText()),
                  const SizedBox(width: 10),
                  badge,
                ],
              ),
              if (snapshot != null)
                Padding(
                  padding: const EdgeInsets.only(left: 55, top: 8),
                  child: Text(
                    'UPDATED ${DateFormat('HH:mm:ss').format(snapshot.occurredAt)}',
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 9,
                      letterSpacing: .8,
                    ),
                  ),
                ),
            ],
          );
        }
        return Row(
          children: [
            const _StockIdentityMark(),
            const SizedBox(width: 13),
            const _StockIdentityText(),
            const Spacer(),
            badge,
            if (snapshot != null) ...[
              const SizedBox(width: 12),
              Text(
                DateFormat('HH:mm:ss').format(snapshot.occurredAt),
                style: const TextStyle(color: _muted, fontSize: 11),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _StockIdentityMark extends StatelessWidget {
  const _StockIdentityMark();

  @override
  Widget build(BuildContext context) => Container(
    width: 42,
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0x55D5A65B)),
      shape: BoxShape.circle,
    ),
    child: const Text(
      '東',
      style: TextStyle(
        color: _brass,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _StockIdentityText extends StatelessWidget {
  const _StockIdentityText();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TOKYO / VIRTUAL',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _cream,
          fontWeight: FontWeight.w800,
          fontSize: 13,
          letterSpacing: 1.8,
        ),
      ),
      Text(
        'Simulated equity terminal',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: _muted, fontSize: 11),
      ),
    ],
  );
}

class _StockConnectionBadge extends StatelessWidget {
  const _StockConnectionBadge({
    required this.live,
    required this.compact,
    required this.onTap,
  });

  final bool live;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(100),
    child: Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: live ? _mint : _brass),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: live ? _mint : _brass,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            live
                ? compact
                      ? 'LIVE'
                      : 'MARKET LIVE'
                : compact
                ? 'SYNC'
                : 'CONNECTING',
            style: TextStyle(
              color: live ? _mint : _brass,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

class _BarPanel extends StatelessWidget {
  const _BarPanel({required this.snapshot});
  final StockSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final average = snapshot?.averageChange ?? 0;
    return Container(
      height: 470,
      padding: const EdgeInsets.fromLTRB(24, 26, 18, 20),
      decoration: BoxDecoration(
        color: const Color(0xE6282029),
        border: Border.all(color: const Color(0x22F4EBDD)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MARKET BREADTH',
                      style: TextStyle(
                        color: _brass,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.7,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Tokyo momentum',
                      style: TextStyle(
                        fontFamily: 'serif',
                        color: _cream,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${average >= 0 ? '+' : ''}${average.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: average >= 0 ? _mint : _coral,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Text(
                    'BASKET AVG.',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: snapshot == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: _brass,
                      strokeWidth: 1.5,
                    ),
                  )
                : _StockBarChart(quotes: snapshot!.quotes),
          ),
        ],
      ),
    );
  }
}

class _StockBarChart extends StatelessWidget {
  const _StockBarChart({required this.quotes});
  final List<StockQuote> quotes;

  @override
  Widget build(BuildContext context) {
    final extent = quotes.fold<double>(
      1,
      (value, quote) => math.max(value, quote.changePercent.abs() * 1.25),
    );
    return BarChart(
      BarChartData(
        minY: -extent,
        maxY: extent,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: extent / 2,
          getDrawingHorizontalLine: (value) => FlLine(
            color: value == 0
                ? const Color(0x55F4EBDD)
                : const Color(0x16F4EBDD),
            strokeWidth: value == 0 ? 1.2 : 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 34,
              interval: extent / 2,
              getTitlesWidget: (value, meta) => Text(
                '${value.toStringAsFixed(1)}%',
                style: const TextStyle(color: _muted, fontSize: 9),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= quotes.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    quotes[index].symbol,
                    style: const TextStyle(
                      color: _cream,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => _cream,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final quote = quotes[group.x];
              return BarTooltipItem(
                '${quote.name}\n${quote.changePercent >= 0 ? '+' : ''}${quote.changePercent.toStringAsFixed(2)}%',
                const TextStyle(
                  color: _midnight,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
        barGroups: [
          for (var index = 0; index < quotes.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: quotes[index].changePercent,
                  width: 22,
                  borderRadius: BorderRadius.vertical(
                    top: quotes[index].changePercent >= 0
                        ? const Radius.circular(3)
                        : Radius.zero,
                    bottom: quotes[index].changePercent < 0
                        ? const Radius.circular(3)
                        : Radius.zero,
                  ),
                  color: quotes[index].changePercent >= 0 ? _mint : _coral,
                ),
              ],
            ),
        ],
      ),
      duration: const Duration(milliseconds: 680),
      curve: Curves.easeOutQuart,
    );
  }
}

class _ExecutionPanel extends StatelessWidget {
  const _ExecutionPanel({required this.snapshot});
  final StockSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final quote = snapshot?.quotes.firstOrNull;
    return Container(
      height: 470,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_aubergine, Color(0xFF1D1A23)],
        ),
        border: Border.all(color: const Color(0x24D5A65B)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VIRTUAL EXECUTION',
            style: TextStyle(
              color: _brass,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
            ),
          ),
          const Spacer(),
          Text(
            quote?.symbol ?? '—',
            style: const TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            quote?.name ?? 'Waiting for quote',
            style: const TextStyle(
              color: _cream,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            quote == null
                ? '¥ —'
                : '¥ ${NumberFormat('#,##0.00').format(quote.price)}',
            style: const TextStyle(
              fontFamily: 'serif',
              color: _cream,
              fontSize: 38,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            quote == null
                ? 'DEMO QUOTE'
                : '${quote.change >= 0 ? '+' : ''}${quote.change.toStringAsFixed(2)}  /  ${quote.changePercent.toStringAsFixed(2)}%',
            style: TextStyle(
              color: quote?.isPositive == false ? _coral : _mint,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const _RiskLine(label: 'LEVERAGE', value: 'x 5.0'),
          const SizedBox(height: 11),
          const _RiskLine(label: 'LOT SIZE', value: '100'),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _OrderButton(
                  label: 'SELL',
                  color: _coral,
                  enabled: quote != null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _OrderButton(
                  label: 'BUY',
                  color: _mint,
                  enabled: quote != null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'DEMO ONLY · 注文は送信されません',
            style: TextStyle(color: _muted, fontSize: 9, letterSpacing: .6),
          ),
        ],
      ),
    );
  }
}

class _OrderButton extends StatelessWidget {
  const _OrderButton({
    required this.label,
    required this.color,
    required this.enabled,
  });
  final String label;
  final Color color;
  final bool enabled;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: enabled
        ? () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$labelはデモ表示です。実際の注文は送信されません。'),
              behavior: SnackBarBehavior.floating,
            ),
          )
        : null,
    style: FilledButton.styleFrom(
      backgroundColor: color,
      foregroundColor: _midnight,
      disabledBackgroundColor: const Color(0x22756D75),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4),
    ),
  );
}

class _RiskLine extends StatelessWidget {
  const _RiskLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        label,
        style: const TextStyle(color: _muted, fontSize: 9, letterSpacing: 1),
      ),
      const Spacer(),
      Text(
        value,
        style: const TextStyle(
          color: _cream,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _QuoteBoard extends StatelessWidget {
  const _QuoteBoard({required this.snapshot});
  final StockSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final quotes = snapshot?.quotes ?? const <StockQuote>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'LIVE QUOTE BOARD',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _cream,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${snapshot?.gainers ?? 0} UP  ·  ${snapshot?.losers ?? 0} DOWN',
              style: const TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...quotes.map(
          (quote) => Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x1CF4EBDD))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 56,
                  child: Text(
                    quote.symbol,
                    style: const TextStyle(
                      color: _brass,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    quote.name,
                    style: const TextStyle(color: _cream, fontSize: 12),
                  ),
                ),
                Text(
                  '¥${NumberFormat('#,##0.00').format(quote.price)}',
                  style: const TextStyle(
                    color: _cream,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 64,
                  child: Text(
                    '${quote.changePercent >= 0 ? '+' : ''}${quote.changePercent.toStringAsFixed(2)}%',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: quote.changePercent >= 0 ? _mint : _coral,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StockBackdrop extends StatelessWidget {
  const _StockBackdrop();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(1.1, -1),
        radius: 1.4,
        colors: [Color(0xFF4B293A), _midnight],
      ),
    ),
    child: CustomPaint(painter: _GridPainter(), child: const SizedBox.expand()),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0CF4EBDD)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 64) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += 64) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
