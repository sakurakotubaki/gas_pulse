import 'package:flutter/material.dart';

abstract final class AppColors {
  static const ink = Color(0xFF071B2D);
  static const inkSoft = Color(0xFF17364A);
  static const canvas = Color(0xFFF2EFE7);
  static const paper = Color(0xFFFAF8F2);
  static const copper = Color(0xFFC17845);
  static const copperLight = Color(0xFFE4AE74);
  static const positive = Color(0xFF20866B);
  static const negative = Color(0xFFC65043);
  static const quiet = Color(0xFF70818B);
  static const line = Color(0xFFD8D5CC);
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.ink,
      secondary: AppColors.copper,
      surface: AppColors.paper,
      error: AppColors.negative,
      onPrimary: AppColors.paper,
      onSecondary: AppColors.ink,
      onSurface: AppColors.ink,
    ),
    scaffoldBackgroundColor: AppColors.canvas,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 58,
        height: .95,
        fontWeight: FontWeight.w600,
        letterSpacing: -2.5,
        color: AppColors.ink,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 32,
        height: 1.05,
        fontWeight: FontWeight.w600,
        letterSpacing: -.8,
        color: AppColors.ink,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.ink,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: AppColors.inkSoft),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        color: AppColors.inkSoft,
      ),
    ),
  );
}
