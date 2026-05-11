import 'package:flutter/material.dart';

class ColorSchemes {
  static const Color primary = Color(0xFF00D9FF);
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color secondary = Color(0xFF7B2FFF);
  static const Color secondaryDark = Color(0xFF5C1FCC);
  static const Color accent = Color(0xFF00FF88);

  static const Color background = Color(0xFF0A0E14);
  static const Color surface = Color(0xFF12161F);
  static const Color surfaceVariant = Color(0xFF1A1F28);
  static const Color error = Color(0xFFFF4757);

  static const Color onPrimary = Color(0xFF0A0E14);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C4);
  static const Color textDisabled = Color(0xFF606875);

  static const Color neonCyan = Color(0xFF00D9FF);
  static const Color neonPurple = Color(0xFF7B2FFF);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonPink = Color(0xFFFF006E);
  static const Color neonOrange = Color(0xFFFF6B35);

  static const Color terminalBackground = Color(0xFF0D1117);
  static const Color terminalGreen = Color(0xFF00FF41);
  static const Color terminalYellow = Color(0xFFFFD700);
  static const Color terminalBlue = Color(0xFF00BFFF);
  static const Color terminalRed = Color(0xFFFF6B6B);

  static ColorScheme get darkColorScheme => const ColorScheme.dark(
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryDark,
    onPrimaryContainer: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryDark,
    onSecondaryContainer: onSecondary,
    tertiary: accent,
    onTertiary: onPrimary,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: textSecondary,
    error: error,
    onError: onError,
    outline: textDisabled,
  );
}