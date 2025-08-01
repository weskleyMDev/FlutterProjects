import 'package:flutter/material.dart';

class MyTheme {
  static final _lightTheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.light,
  );
  ThemeData light() => _theme(_lightTheme);

  static final _darkTheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
  );
  ThemeData dark() => _theme(_darkTheme);

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
  );
}
