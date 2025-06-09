import 'package:flutter/material.dart';

const Color primaryPurple = Color(0xFF7B1FA2);
const Color secondaryPurple = Color(0xFFCE93D8);
const Color tertiaryPurple = Color(0xFFE1BEE7);

final ColorScheme customLightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: primaryPurple,
  onPrimary: Colors.white,
  secondary: secondaryPurple,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Color(0xFFF8F8F8),
  onSurface: Colors.black,
);

final ColorScheme customDarkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: primaryPurple,
  onPrimary: Colors.black,
  secondary: secondaryPurple,
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.black,
  surface: Color(0xFF121212),
  onSurface: Colors.white,
);

final ThemeData purpleLightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Lato",
  colorScheme: customLightColorScheme,
  scaffoldBackgroundColor: customLightColorScheme.surface,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryPurple,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: customLightColorScheme.primary,
    foregroundColor: customLightColorScheme.onPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: customLightColorScheme.primary,
      foregroundColor: customLightColorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: customLightColorScheme.primary),
    ),
    labelStyle: TextStyle(color: customLightColorScheme.primary),
  ),
);

final ThemeData purpleDarkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Lato",
  colorScheme: customDarkColorScheme,
  scaffoldBackgroundColor: customDarkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: customDarkColorScheme.surface,
    foregroundColor: customDarkColorScheme.onSurface,
    elevation: 2,
    centerTitle: true,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: customDarkColorScheme.primary,
    foregroundColor: customDarkColorScheme.onPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: customDarkColorScheme.primary,
      foregroundColor: customDarkColorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: customDarkColorScheme.primary),
    ),
    labelStyle: TextStyle(color: customDarkColorScheme.primary),
  ),
);
