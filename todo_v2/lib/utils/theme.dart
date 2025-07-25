import 'package:flutter/material.dart';

class MaterialTheme {
  static final lightTheme = ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.light,
  );
  ThemeData light() => _theme(lightTheme);

  static final darkTheme = ColorScheme.fromSeed(
    seedColor: Colors.amber,
    brightness: Brightness.dark,
  );
  ThemeData dark() => _theme(darkTheme);

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
  );
}
