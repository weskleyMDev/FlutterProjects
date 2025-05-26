
import 'package:flutter/material.dart';

class MeatAppColors {
  static const Color meatRed = Color(0xFFA03C3B);
  static const Color lightBeige = Color(0xFFF5EBDD);
  static const Color sageGreen = Color(0xFF8A9A5B);
  static const Color mediumBrown = Color(0xFF5C3B28);
  static const Color snowWhite = Color(0xFFFAFAFA);
}

final ThemeData meatAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: MeatAppColors.meatRed,
    onPrimary: MeatAppColors.snowWhite,
    secondary: MeatAppColors.sageGreen,
    onSecondary: MeatAppColors.snowWhite,
    surface: MeatAppColors.snowWhite,
    onSurface: MeatAppColors.mediumBrown,
    error: Colors.red,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: MeatAppColors.meatRed,
    foregroundColor: MeatAppColors.snowWhite,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MeatAppColors.meatRed,
      foregroundColor: MeatAppColors.snowWhite,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: MeatAppColors.mediumBrown, fontSize: 16),
    bodyMedium: TextStyle(color: MeatAppColors.mediumBrown, fontSize: 14),
    titleLarge: TextStyle(
      color: MeatAppColors.meatRed,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
