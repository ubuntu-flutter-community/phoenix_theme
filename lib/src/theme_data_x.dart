import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  bool get isLight => colorScheme.isLight;
}

extension ColorSchemeX on ColorScheme {
  bool get isLight => brightness == Brightness.light;
}
