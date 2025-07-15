import 'package:flutter/material.dart';

TextTheme createTextTheme({
    required BuildContext context,
    required String displayFont,
    required String bodyFont,
  }) {
    TextTheme baseTextTheme = Theme.of(context).textTheme;
    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontFamily: displayFont,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontFamily: displayFont,
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontFamily: displayFont,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontFamily: displayFont,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontFamily: displayFont,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontFamily: displayFont,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: displayFont),
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: displayFont),
      titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: displayFont),

      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFont),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFont),
      bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFont),
      labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFont),
      labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFont),
      labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFont),
    );
  }