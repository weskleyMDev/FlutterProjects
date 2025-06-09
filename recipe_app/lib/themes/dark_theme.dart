import 'package:flutter/material.dart';

const Color primaryColorDark = Color(0xff6A0DAD);
const Color accentColorDark = Color(0xff212121);
const Color secondaryColorDark = Color(0xff9B4D96);
const Color tertiaryColorDark = Color(0xff4A148C);
const Color backgroundColorDark = Color(0xff121212);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: "RobotoCondensed",

  primaryColor: primaryColorDark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColorDark,
    secondary: accentColorDark,
    surface: backgroundColorDark,
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: backgroundColorDark,
  cardColor: tertiaryColorDark,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: primaryColorDark,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    displayMedium: TextStyle(
      color: secondaryColorDark,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white60, fontSize: 14),
    labelSmall: TextStyle(color: Colors.grey, fontSize: 12),
  ),

  iconTheme: IconThemeData(color: accentColorDark),

  appBarTheme: AppBarTheme(
    color: tertiaryColorDark,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: secondaryColorDark,
    textTheme: ButtonTextTheme.primary,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: tertiaryColorDark,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColorDark),
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: secondaryColorDark,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);
