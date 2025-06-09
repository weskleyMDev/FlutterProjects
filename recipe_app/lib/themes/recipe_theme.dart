import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6D9F50);
const Color accentColor = Color(0xFFFEA5B3);
const Color secondaryColor = Color(0xFFB2D8B2);
const Color tertiaryColor = Color(0xFFFFB74D);
const Color backgroundColor = Color(0xFFF3F3F3);

final ThemeData recipeAppTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: accentColor,
    surface: backgroundColor,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: backgroundColor,
  cardColor: Colors.white,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    displayMedium: TextStyle(
      color: secondaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    labelSmall: TextStyle(color: Colors.grey, fontSize: 12),
  ),

  iconTheme: IconThemeData(color: accentColor),

  appBarTheme: AppBarTheme(
    color: primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: tertiaryColor,
    textTheme: ButtonTextTheme.primary,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: tertiaryColor,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);
