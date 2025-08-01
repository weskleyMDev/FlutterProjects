import 'package:flutter/material.dart';

class CustomTheme {
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.purpleAccent,
    brightness: Brightness.light,
  );
  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.purpleAccent,
    brightness: Brightness.dark,
  );

  ThemeData light() => _theme(_lightColorScheme);
  ThemeData dark() => _theme(_darkColorScheme);

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
  );
}
