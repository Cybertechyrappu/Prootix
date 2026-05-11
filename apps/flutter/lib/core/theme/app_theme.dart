import 'package:flutter/material.dart';
import 'color_schemes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorSchemes.darkColorScheme,
      scaffoldBackgroundColor: ColorSchemes.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorSchemes.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorSchemes.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: ColorSchemes.textPrimary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorSchemes.surface,
        selectedItemColor: ColorSchemes.primary,
        unselectedItemColor: ColorSchemes.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: ColorSchemes.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSchemes.primary,
          foregroundColor: ColorSchemes.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorSchemes.primary,
          side: const BorderSide(color: ColorSchemes.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorSchemes.primary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorSchemes.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorSchemes.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(color: ColorSchemes.textSecondary),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ColorSchemes.primary,
        linearTrackColor: ColorSchemes.surfaceVariant,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorSchemes.surface,
        contentTextStyle: const TextStyle(color: ColorSchemes.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: const DividerThemeData(
        color: ColorSchemes.surfaceVariant,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: ColorSchemes.textPrimary,
        size: 24,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: ColorSchemes.textPrimary),
        displayMedium: TextStyle(color: ColorSchemes.textPrimary),
        displaySmall: TextStyle(color: ColorSchemes.textPrimary),
        headlineLarge: TextStyle(color: ColorSchemes.textPrimary),
        headlineMedium: TextStyle(color: ColorSchemes.textPrimary),
        headlineSmall: TextStyle(color: ColorSchemes.textPrimary),
        titleLarge: TextStyle(color: ColorSchemes.textPrimary),
        titleMedium: TextStyle(color: ColorSchemes.textPrimary),
        titleSmall: TextStyle(color: ColorSchemes.textPrimary),
        bodyLarge: TextStyle(color: ColorSchemes.textPrimary),
        bodyMedium: TextStyle(color: ColorSchemes.textPrimary),
        bodySmall: TextStyle(color: ColorSchemes.textSecondary),
        labelLarge: TextStyle(color: ColorSchemes.textPrimary),
        labelMedium: TextStyle(color: ColorSchemes.textSecondary),
        labelSmall: TextStyle(color: ColorSchemes.textSecondary),
      ),
    );
  }
}