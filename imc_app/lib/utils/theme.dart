import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;
  const MaterialTheme({required this.textTheme});

  static ColorScheme lightScheme() => ColorScheme.fromSeed(
    seedColor: Color(0xffaf36bf),
    brightness: Brightness.light,
  );
  ThemeData light() => _theme(lightScheme());

  static ColorScheme darkScheme() => ColorScheme.fromSeed(
    seedColor: Color(0xff5d29a6),
    brightness: Brightness.dark,
  );
  ThemeData dark() => _theme(darkScheme());  

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
  );
}
