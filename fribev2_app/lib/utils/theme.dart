import 'package:flutter/material.dart';

class MaterialTheme {
  static ColorScheme _lightScheme() => ColorScheme.fromSeed(
    seedColor: Colors.redAccent,
    brightness: Brightness.light,
  );
  ThemeData light() => _theme(_lightScheme());

  static ColorScheme _darkScheme() =>
      ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.dark);
  ThemeData dark() => _theme(_darkScheme());

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onPrimary
      )
    )
  );
}
