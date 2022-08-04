import 'package:flutter/material.dart';
import 'theme_export.dart';

class CustomTheme {
  static const _buttonFontSize = 16.0;
  static const _padding12 = 12.0;
  static const _borderRadius8 = 8.0;

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.indigo,
      ),
      scaffoldBackgroundColor: Palette.black,
      appBarTheme: const AppBarTheme(
        color: Palette.black,
      ),
      textTheme: theme.primaryTextTheme
          .copyWith(
            button: theme.primaryTextTheme.button?.copyWith(
              color: Colors.white,
              fontSize: _buttonFontSize,
            ),
          )
          .apply(displayColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Palette.indigo500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(
              horizontal: _padding12, vertical: _padding12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius8),
          ),
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    final theme = ThemeData.light();
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.indigo,
      ),
      scaffoldBackgroundColor: Palette.white,
      appBarTheme: const AppBarTheme(
        foregroundColor: Palette.white,
        color: Palette.indigo500,
      ),
      textTheme: theme.primaryTextTheme
          .copyWith(
            button: theme.primaryTextTheme.button?.copyWith(
              color: Colors.white,
              fontSize: _buttonFontSize,
            ),
          )
          .apply(displayColor: Colors.black, bodyColor: Colors.black),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Palette.indigo500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(
              horizontal: _padding12, vertical: _padding12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius8),
          ),
        ),
      ),
    );
  }
}
