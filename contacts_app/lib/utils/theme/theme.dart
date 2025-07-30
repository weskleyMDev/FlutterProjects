import 'package:flutter/material.dart';

class CustomTheme {
  static final _lightTheme = ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.light,
  );
  ThemeData light() => _theme(_lightTheme);

  static final _darkTheme = ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.dark,
  );
  ThemeData dark() => _theme(_darkTheme);
  
  static ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
  );
}
