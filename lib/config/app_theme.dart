import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color primary = Color(0xFF1CB6C3);
  static const Color accent = Color(0xFFD8FF57);
  static const Color gold = Color(0xFFFFC94A);

  static ThemeData light() => _buildTheme(Brightness.light);

  static ThemeData dark() => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final baseScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    );
    final colorScheme = baseScheme.copyWith(
      primary: primary,
      secondary: accent,
      tertiary: gold,
      surface: isDark ? const Color(0xFF101C2A) : Colors.white,
      surfaceContainerHighest: isDark
          ? const Color(0xFF16273A)
          : const Color(0xFFF2F7FB),
      onSurface: isDark ? const Color(0xFFF4F8FB) : const Color(0xFF112136),
      onSurfaceVariant: isDark
          ? const Color(0xFFACC0D0)
          : const Color(0xFF6F8092),
      outline: isDark ? const Color(0xFF284053) : const Color(0xFFD8E1EA),
      outlineVariant: isDark ? const Color(0xFF1B3042) : const Color(0xFFE8EEF4),
    );

    final primaryTextColor = colorScheme.onSurface;
    final secondaryTextColor = colorScheme.onSurfaceVariant;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF091320)
          : const Color(0xFFF4F7FB),
      fontFamily: 'sans-serif',
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          height: 1.04,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          height: 1.08,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          height: 1.15,
          fontWeight: FontWeight.w800,
          color: primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          height: 1.45,
          fontWeight: FontWeight.w500,
          color: primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          height: 1.45,
          fontWeight: FontWeight.w500,
          color: secondaryTextColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: primaryTextColor,
      ),
      dividerColor: colorScheme.outlineVariant,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          backgroundColor: const WidgetStatePropertyAll(primary),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(color: colorScheme.outline),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(primaryTextColor),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF142333) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        hintStyle: TextStyle(color: secondaryTextColor),
        labelStyle: TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: primary, width: 1.6),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primary.withValues(alpha: 0.48)
              : colorScheme.outlineVariant,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primary
              : isDark
              ? const Color(0xFFCFD8E1)
              : const Color(0xFF7E8C9C),
        ),
      ),
    );
  }
}
