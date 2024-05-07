import 'package:flutter/material.dart';

import '../phoenix_theme.dart';

ThemePair phoenixTheme({
  required Color color,
}) {
  return (
    lightTheme: ThemeData(
      colorScheme: _lightScheme(color),
      splashFactory: NoSplash.splashFactory,
    ),
    darkTheme: ThemeData(
      colorScheme: _darkScheme(color),
      splashFactory: NoSplash.splashFactory,
    )
  );
}

ColorScheme _darkScheme(Color color) {
  final darkBase = Colors.black.scale(lightness: 0.2);
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
  ).copyWith(
    surfaceTint: darkBase,
    background: darkBase,
    surface: darkBase.scale(
      lightness: 0.05,
    ),
    outline: darkBase.scale(
      lightness: 0.2,
    ),
  );
}

ColorScheme _lightScheme(Color color) {
  const lightBase = Colors.white;
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.light,
  ).copyWith(
    surfaceTint: lightBase,
    background: lightBase,
    surface: lightBase.scale(
      lightness: -0.05,
    ),
    outline: Colors.white.scale(
      lightness: -0.2,
    ),
  );
}

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});
