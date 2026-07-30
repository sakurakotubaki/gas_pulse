import 'package:flutter/material.dart';
import 'package:gas_pulse/src/navigation/app_shell.dart';
import 'package:gas_pulse/src/theme/app_theme.dart';

class GasPulseApp extends StatelessWidget {
  const GasPulseApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Gas Pulse',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const AppShell(),
  );
}
