import 'package:flutter/material.dart';
import 'package:product_catalog_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final appBarColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final bodyColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final inputFill = cardColor;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      surface: cardColor,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    final textTheme = TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        height: 1.5,
        color: colorScheme.onSurfaceVariant,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: colorScheme.onSurfaceVariant,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: bodyColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
