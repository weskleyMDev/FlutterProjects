import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3d6838),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbdf0b3),
      onPrimaryContainer: Color(0xff255023),
      secondary: Color(0xff53634e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd6e8ce),
      onSecondaryContainer: Color(0xff3c4b38),
      tertiary: Color(0xff38656a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf0),
      onTertiaryContainer: Color(0xff1e4d52),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff42493f),
      outline: Color(0xff73796f),
      outlineVariant: Color(0xffc2c8bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa2d399),
      primaryFixed: Color(0xffbdf0b3),
      onPrimaryFixed: Color(0xff002203),
      primaryFixedDim: Color(0xffa2d399),
      onPrimaryFixedVariant: Color(0xff255023),
      secondaryFixed: Color(0xffd6e8ce),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff3c4b38),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff1e4d52),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4da),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff133f14),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4b7846),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b3a28),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff61725c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff073c41),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff477479),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff0e120d),
      onSurfaceVariant: Color(0xff32382f),
      outline: Color(0xff4e544b),
      outlineVariant: Color(0xff696f65),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa2d399),
      primaryFixed: Color(0xff4b7846),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff335e30),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff61725c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff495945),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff477479),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2e5c60),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c8bf),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffe6e9e0),
      surfaceContainerHigh: Color(0xffdbded5),
      surfaceContainerHighest: Color(0xffcfd3ca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff07340a),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff275225),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff21301f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3e4d3a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003236),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff215054),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282e26),
      outlineVariant: Color(0xff454b42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa2d399),
      primaryFixed: Color(0xff275225),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0f3b10),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3e4d3a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff283625),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff215054),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff02393d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6bab1),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff2e8),
      surfaceContainer: Color(0xffe0e4da),
      surfaceContainerHigh: Color(0xffd2d6cd),
      surfaceContainerHighest: Color(0xffc4c8bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa2d399),
      surfaceTint: Color(0xffa2d399),
      onPrimary: Color(0xff0c390e),
      primaryContainer: Color(0xff255023),
      onPrimaryContainer: Color(0xffbdf0b3),
      secondary: Color(0xffbaccb3),
      onSecondary: Color(0xff253423),
      secondaryContainer: Color(0xff3c4b38),
      onSecondaryContainer: Color(0xffd6e8ce),
      tertiary: Color(0xffa0cfd3),
      onTertiary: Color(0xff00363b),
      tertiaryContainer: Color(0xff1e4d52),
      onTertiaryContainer: Color(0xffbcebf0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10140f),
      onSurface: Color(0xffe0e4da),
      onSurfaceVariant: Color(0xffc2c8bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff42493f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff3d6838),
      primaryFixed: Color(0xffbdf0b3),
      onPrimaryFixed: Color(0xff002203),
      primaryFixedDim: Color(0xffa2d399),
      onPrimaryFixedVariant: Color(0xff255023),
      secondaryFixed: Color(0xffd6e8ce),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff3c4b38),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff1e4d52),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb7eaad),
      surfaceTint: Color(0xffa2d399),
      onPrimary: Color(0xff002d05),
      primaryContainer: Color(0xff6e9c67),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd0e2c8),
      onSecondary: Color(0xff1b2919),
      secondaryContainer: Color(0xff85957f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb6e5ea),
      onTertiary: Color(0xff002b2e),
      tertiaryContainer: Color(0xff6b989d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8ded2),
      outline: Color(0xffaeb4a8),
      outlineVariant: Color(0xff8c9287),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff265124),
      primaryFixed: Color(0xffbdf0b3),
      onPrimaryFixed: Color(0xff001601),
      primaryFixedDim: Color(0xffa2d399),
      onPrimaryFixedVariant: Color(0xff133f14),
      secondaryFixed: Color(0xffd6e8ce),
      onSecondaryFixed: Color(0xff071406),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff2b3a28),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff001416),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff073c41),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff41463f),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1b1f19),
      surfaceContainer: Color(0xff252923),
      surfaceContainerHigh: Color(0xff30342e),
      surfaceContainerHighest: Color(0xff3b3f38),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcafebf),
      surfaceTint: Color(0xffa2d399),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9ecf95),
      onPrimaryContainer: Color(0xff000f01),
      secondary: Color(0xffe3f5db),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb6c8af),
      onSecondaryContainer: Color(0xff030e03),
      tertiary: Color(0xffc9f8fd),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9dcbcf),
      onTertiaryContainer: Color(0xff000e0f),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf2e5),
      outlineVariant: Color(0xffbec5b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff265124),
      primaryFixed: Color(0xffbdf0b3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa2d399),
      onPrimaryFixedVariant: Color(0xff001601),
      secondaryFixed: Color(0xffd6e8ce),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff071406),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff001416),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff4d514a),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d211b),
      surfaceContainer: Color(0xff2d322b),
      surfaceContainerHigh: Color(0xff383d36),
      surfaceContainerHighest: Color(0xff444841),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    appBarTheme: AppBarTheme().copyWith(
      centerTitle: true,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
