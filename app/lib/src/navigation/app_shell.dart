import 'package:flutter/material.dart';
import 'package:gas_pulse/src/features/gold/presentation/gold_screen.dart';
import 'package:gas_pulse/src/features/market/presentation/market_screen.dart';
import 'package:gas_pulse/src/features/stocks/presentation/stock_screen.dart';
import 'package:gas_pulse/src/theme/app_theme.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  var _index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(
      index: _index,
      children: const [MarketScreen(), StockScreen(), GoldScreen()],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (index) => setState(() => _index = index),
      backgroundColor: AppColors.paper,
      indicatorColor: const Color(0x1FC17845),
      height: 70,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.local_fire_department_outlined),
          selectedIcon: Icon(Icons.local_fire_department),
          label: 'ENERGY',
        ),
        NavigationDestination(
          icon: Icon(Icons.candlestick_chart_outlined),
          selectedIcon: Icon(Icons.candlestick_chart),
          label: 'TSE DEMO',
        ),
        NavigationDestination(
          icon: Icon(Icons.monetization_on_outlined),
          selectedIcon: Icon(Icons.monetization_on),
          label: 'GOLD',
        ),
      ],
    ),
  );
}
