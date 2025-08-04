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

  ThemeData _theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      textTheme: TextTheme().apply(
        bodyColor: Colors.purple,
        displayColor: Colors.purple,
      ),
      inputDecorationTheme: InputDecorationTheme().copyWith(
        labelStyle: TextStyle(color: Colors.purple),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 2.0),
        ),
        prefixIconColor: Colors.purple,
        suffixIconColor: Colors.purple,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
