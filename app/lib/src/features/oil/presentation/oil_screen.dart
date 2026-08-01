import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_pulse/src/features/oil/application/oil_feed.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_position.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_price_tick.dart';
import 'package:gas_pulse/src/features/oil/domain/oil_state.dart';
import 'package:gas_pulse/src/theme/app_theme.dart';
import 'package:intl/intl.dart';

abstract final class _OilColors {
  static const amber = Color(0xFFE3A73F);
  static const amberDark = Color(0xFF9A6413);
  static const panel = Color(0xFF13222B);
}

class OilScreen extends ConsumerWidget {
  const OilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oil = ref.watch(oilFeedProvider);
    final history = ref.watch(oilHistoryProvider);
    final positions = ref.watch(oilPositionsProvider);
    final cacheEnabled = ref.watch(redisCacheEnabledProvider);
    final chartTicks = _mergeTicks(history.value?.ticks ?? const [], oil.ticks);
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _Backdrop()),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                final inset = wide ? 48.0 : 18.0;
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(inset, 20, inset, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(
                        oil: oil,
                        cacheEnabled: cacheEnabled,
                        cacheStatus: history.value?.cacheStatus,
                      ),
                      SizedBox(height: wide ? 42 : 28),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: _PricePanel(oil: oil)),
                            const SizedBox(width: 28),
                            Expanded(
                              flex: 7,
                              child: _ChartPanel(
                                ticks: chartTicks,
                                loading: history.isLoading,
                                error: history.hasError,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _PricePanel(oil: oil),
                        const SizedBox(height: 22),
                        _ChartPanel(
                          ticks: chartTicks,
                          loading: history.isLoading,
                          error: history.hasError,
                        ),
                      ],
                      const SizedBox(height: 24),
                      _TradePanel(price: oil.current?.price),
                      const SizedBox(height: 20),
                      _PositionsPanel(
                        positions: positions,
                        currentPrice: oil.current?.price,
                      ),
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

List<OilPriceTick> _mergeTicks(
  List<OilPriceTick> history,
  List<OilPriceTick> live,
) {
  final byTimestamp = <int, OilPriceTick>{
    for (final tick in history) tick.timestamp: tick,
    for (final tick in live) tick.timestamp: tick,
  };
  final ticks = byTimestamp.values.toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  return ticks.length > 120 ? ticks.sublist(ticks.length - 120) : ticks;
}

class _Header extends ConsumerWidget {
  const _Header({
    required this.oil,
    required this.cacheEnabled,
    required this.cacheStatus,
  });

  final OilState oil;
  final bool cacheEnabled;
  final String? cacheStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 620;
      final identity = const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: AppColors.ink,
            child: Icon(Icons.oil_barrel, color: _OilColors.amber),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OIL / PULSE',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Crude market terminal',
                style: TextStyle(color: AppColors.quiet, fontSize: 11),
              ),
            ],
          ),
        ],
      );
      final controls = Wrap(
        spacing: 10,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _ConnectionPill(
            status: oil.connectionStatus,
            onRetry: () => ref.read(oilFeedProvider.notifier).retry(),
          ),
          Semantics(
            label: 'Redis cache',
            toggled: cacheEnabled,
            child: Container(
              height: 44,
              padding: const EdgeInsets.only(left: 12, right: 3),
              decoration: BoxDecoration(
                color: AppColors.paper,
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'REDIS ${cacheEnabled ? 'ON' : 'OFF'}'
                    '${cacheStatus == null ? '' : ' · $cacheStatus'}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .7,
                    ),
                  ),
                  Switch(
                    value: cacheEnabled,
                    activeThumbColor: _OilColors.amberDark,
                    onChanged: ref
                        .read(redisCacheEnabledProvider.notifier)
                        .setEnabled,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
      return compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [identity, const SizedBox(height: 14), controls],
            )
          : Row(children: [identity, const Spacer(), controls]);
    },
  );
}

class _PricePanel extends StatelessWidget {
  const _PricePanel({required this.oil});
  final OilState oil;

  @override
  Widget build(BuildContext context) {
    final positive = oil.change >= 0;
    final movement = positive ? AppColors.positive : AppColors.negative;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LIVE COMMODITY · OIL/USD',
          style: TextStyle(
            color: _OilColors.amberDark,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Crude in\nmotion.',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 26),
        Text(
          oil.current == null
              ? '\$—.——'
              : '\$${oil.current!.price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 46,
            height: 1,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${positive ? '+' : ''}${oil.change.toStringAsFixed(2)}  '
          '(${positive ? '+' : ''}${oil.changePercent.toStringAsFixed(2)}%)',
          style: TextStyle(color: movement, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColors.line),
            ),
          ),
          child: Row(
            children: [
              _Metric(
                label: 'HIGH',
                value: oil.high?.toStringAsFixed(2) ?? '—',
              ),
              _Metric(label: 'LOW', value: oil.low?.toStringAsFixed(2) ?? '—'),
              _Metric(label: 'TICKS', value: '${oil.ticks.length}'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.quiet, fontSize: 9),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ],
    ),
  );
}

class _ChartPanel extends StatelessWidget {
  const _ChartPanel({
    required this.ticks,
    required this.loading,
    required this.error,
  });
  final List<OilPriceTick> ticks;
  final bool loading;
  final bool error;

  @override
  Widget build(BuildContext context) => Container(
    height: 390,
    padding: const EdgeInsets.fromLTRB(20, 20, 14, 16),
    decoration: BoxDecoration(
      color: _OilColors.panel,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x26071B2D),
          blurRadius: 28,
          offset: Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRICE HISTORY${error ? ' · HISTORY UNAVAILABLE' : ''}',
          style: TextStyle(
            color: error ? AppColors.negative : _OilColors.amber,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: ticks.isEmpty
              ? Center(
                  child: loading
                      ? const CircularProgressIndicator(color: _OilColors.amber)
                      : const Text(
                          'Waiting for oil prices',
                          style: TextStyle(color: AppColors.paper),
                        ),
                )
              : _OilChart(ticks: ticks),
        ),
      ],
    ),
  );
}

class _OilChart extends StatelessWidget {
  const _OilChart({required this.ticks});
  final List<OilPriceTick> ticks;

  @override
  Widget build(BuildContext context) {
    final low = ticks.map((e) => e.price).reduce((a, b) => a < b ? a : b);
    final high = ticks.map((e) => e.price).reduce((a, b) => a > b ? a : b);
    final padding = (high - low).abs() < 1 ? 1.0 : (high - low) * .2;
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (ticks.length - 1).clamp(1, 119).toDouble(),
        minY: low - padding,
        maxY: high + padding,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: padding,
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: Color(0x1FFFFFFF)),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < ticks.length; i++)
                FlSpot(i.toDouble(), ticks[i].price),
            ],
            color: _OilColors.amber,
            barWidth: 2.5,
            isCurved: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x55E3A73F), Color(0x00E3A73F)],
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 500),
    );
  }
}

class _TradePanel extends ConsumerWidget {
  const _TradePanel({required this.price});
  final double? price;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.paper,
      border: Border.all(color: AppColors.line),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'VIRTUAL EXECUTION',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _OrderButton(side: OilPositionSide.sell, price: price),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OrderButton(side: OilPositionSide.buy, price: price),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'DEMO ONLY · 実際の注文は送信されません',
          style: TextStyle(color: AppColors.quiet, fontSize: 10),
        ),
      ],
    ),
  );
}

class _OrderButton extends ConsumerWidget {
  const _OrderButton({required this.side, required this.price});
  final OilPositionSide side;
  final double? price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buy = side == OilPositionSide.buy;
    return FilledButton(
      key: ValueKey('oil-${buy ? 'buy' : 'sell'}'),
      onPressed: price == null
          ? null
          : () {
              ref.read(oilPositionsProvider.notifier).open(side, price!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${buy ? 'BUY' : 'SELL'} @ \$${price!.toStringAsFixed(2)} · デモ建玉を追加しました',
                  ),
                ),
              );
            },
      style: FilledButton.styleFrom(
        backgroundColor: buy ? AppColors.positive : AppColors.negative,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      child: Text(
        buy ? 'BUY' : 'SELL',
        style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
      ),
    );
  }
}

class _PositionsPanel extends ConsumerWidget {
  const _PositionsPanel({required this.positions, required this.currentPrice});
  final List<OilPosition> positions;
  final double? currentPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = currentPrice == null
        ? 0.0
        : positions.fold<double>(
            0,
            (sum, position) => sum + position.profitLoss(currentPrice!),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 520;
            final title = Text(
              'OPEN POSITIONS · ${positions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            );
            final actions = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PnL ${total >= 0 ? '+' : ''}\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: total >= 0 ? AppColors.positive : AppColors.negative,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  key: const ValueKey('oil-close-all'),
                  onPressed: positions.isEmpty
                      ? null
                      : ref.read(oilPositionsProvider.notifier).closeAll,
                  child: const Text('CLOSE ALL'),
                ),
              ],
            );
            return compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, actions],
                  )
                : Row(children: [title, const Spacer(), actions]);
          },
        ),
        const SizedBox(height: 8),
        if (positions.isEmpty)
          const Text(
            '建玉はありません。BUY / SELL でデモ取引を開始できます。',
            style: TextStyle(color: AppColors.quiet, fontSize: 12),
          )
        else
          ...positions.reversed.map((position) {
            final pnl = currentPrice == null
                ? 0.0
                : position.profitLoss(currentPrice!);
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.line)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      position.side.name.toUpperCase(),
                      style: TextStyle(
                        color: position.side == OilPositionSide.buy
                            ? AppColors.positive
                            : AppColors.negative,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$${position.entryPrice.toStringAsFixed(2)} · ${DateFormat('HH:mm:ss').format(position.openedAt)}',
                    ),
                  ),
                  Text(
                    '${pnl >= 0 ? '+' : ''}\$${pnl.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: pnl >= 0 ? AppColors.positive : AppColors.negative,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}

class _ConnectionPill extends StatelessWidget {
  const _ConnectionPill({required this.status, required this.onRetry});
  final OilConnectionStatus status;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final live = status == OilConnectionStatus.live;
    return InkWell(
      onTap: live ? null : onRetry,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: live ? const Color(0x1420866B) : const Color(0x14E3A73F),
          border: Border.all(
            color: live ? AppColors.positive : _OilColors.amberDark,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Text(
          live ? 'LIVE' : 'CONNECTING',
          style: TextStyle(
            color: live ? AppColors.positive : _OilColors.amberDark,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _Backdrop extends StatelessWidget {
  const _Backdrop();

  @override
  Widget build(BuildContext context) => const DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF7E7), AppColors.canvas, Color(0xFFE8E1D3)],
      ),
    ),
    child: SizedBox.expand(),
  );
}
