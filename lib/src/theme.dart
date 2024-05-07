import 'package:flutter/material.dart';

import 'color_x.dart';
import 'theme_data_x.dart';

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});

const lightBase = Colors.white;
final darkBase = Colors.black.scale(lightness: 0.11);
final darkMenuBase = Colors.black.scale(lightness: 0.1);
const kContainerRadius = 10.0;
const kButtonRadius = 6.0;
const kMenuRadius = 8.0;

ThemePair phoenixTheme({
  required Color color,
}) {
  final darkScheme = _darkScheme(color);
  final lightScheme = _lightScheme(color);

  return (
    lightTheme: ThemeData(
      colorScheme: lightScheme,
      splashFactory: NoSplash.splashFactory,
      dividerColor: _dividerColor(lightScheme),
      cardColor: _cardColor(lightScheme),
    ).copyWith(
      menuTheme: _menuTheme(lightScheme),
      popupMenuTheme: _popupMenuTheme(lightScheme),
      dialogTheme: _dialogTheme(lightScheme),
      dropdownMenuTheme: _dropdownMenuTheme(lightScheme),
      sliderTheme: _sliderTheme(lightScheme),
      dividerTheme: _dividerTheme(lightScheme),
      progressIndicatorTheme: _progressIndicatorTheme(lightScheme),
      switchTheme: _switchTheme(lightScheme),
      navigationRailTheme: _naviRailTheme(lightScheme),
      navigationBarTheme: _naviBarTheme(lightScheme),
      appBarTheme: _appBarTheme(lightScheme),
      snackBarTheme: _snackBarThemeData(lightScheme),
      cardTheme: _cardTheme(lightScheme),
    ),
    darkTheme: ThemeData(
      colorScheme: darkScheme,
      splashFactory: NoSplash.splashFactory,
      dividerColor: _dividerColor(darkScheme),
      cardColor: _cardColor(darkScheme),
    ).copyWith(
      menuTheme: _menuTheme(darkScheme),
      popupMenuTheme: _popupMenuTheme(darkScheme),
      dialogTheme: _dialogTheme(darkScheme),
      dropdownMenuTheme: _dropdownMenuTheme(darkScheme),
      sliderTheme: _sliderTheme(darkScheme),
      dividerTheme: _dividerTheme(darkScheme),
      progressIndicatorTheme: _progressIndicatorTheme(darkScheme),
      switchTheme: _switchTheme(darkScheme),
      navigationRailTheme: _naviRailTheme(darkScheme),
      navigationBarTheme: _naviBarTheme(darkScheme),
      appBarTheme: _appBarTheme(darkScheme),
      snackBarTheme: _snackBarThemeData(darkScheme),
      cardTheme: _cardTheme(darkScheme),
    )
  );
}

ColorScheme _darkScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
  ).copyWith(
    surfaceTint: darkBase,
    background: darkBase,
    surface: darkBase.scale(
      lightness: 0.03,
    ),
    outline: darkBase.scale(
      lightness: 0.28,
    ),
  );
}

ColorScheme _lightScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.light,
  ).copyWith(
    surfaceTint: lightBase,
    background: lightBase,
    surface: lightBase.scale(
      lightness: -0.04,
    ),
    outline: Colors.white.scale(
      lightness: -0.3,
    ),
  );
}

DividerThemeData _dividerTheme(ColorScheme colorScheme) => DividerThemeData(
      color: _dividerColor(colorScheme),
      space: 1.0,
      thickness: 1.0,
    );

Color _dividerColor(ColorScheme colorScheme) {
  return colorScheme.outline.scale(lightness: colorScheme.isLight ? 0.3 : -0.4);
}

DialogTheme _dialogTheme(ColorScheme colorScheme) {
  final bgColor = colorScheme.isLight ? lightBase : darkMenuBase;
  return DialogTheme(
    backgroundColor: bgColor,
    surfaceTintColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kContainerRadius),
      side: colorScheme.isLight
          ? BorderSide.none
          : BorderSide(
              color: Colors.white.withOpacity(0.2),
            ),
    ),
  );
}

CardTheme _cardTheme(ColorScheme colorScheme) {
  return CardTheme(
    color: _cardColor(colorScheme),
  );
}

Color _cardColor(ColorScheme colorScheme) {
  return colorScheme.surface.scale(
    lightness: colorScheme.isLight ? -0.04 : 0.02,
  );
}

PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
  final bgColor = colorScheme.isLight ? lightBase : darkMenuBase;
  return PopupMenuThemeData(
    color: bgColor,
    surfaceTintColor: bgColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kContainerRadius),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withOpacity(
          colorScheme.isLight ? 0.3 : 0.2,
        ),
        width: 1,
      ),
    ),
  );
}

MenuStyle _menuStyle(ColorScheme colorScheme) {
  final bgColor = colorScheme.isLight ? lightBase : darkMenuBase;

  return MenuStyle(
    surfaceTintColor: MaterialStateColor.resolveWith((states) => bgColor),
    shape: MaterialStateProperty.resolveWith(
      (states) => RoundedRectangleBorder(
        side: BorderSide(
          color: colorScheme.onSurface.withOpacity(
            colorScheme.isLight ? 0.3 : 0.2,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(kMenuRadius),
      ),
    ),
    side: MaterialStateBorderSide.resolveWith(
      (states) => BorderSide(
        color: colorScheme.onSurface.withOpacity(
          colorScheme.isLight ? 0.3 : 0.2,
        ),
        width: 1,
      ),
    ),
    elevation: MaterialStateProperty.resolveWith((states) => 1),
    backgroundColor: MaterialStateProperty.resolveWith((states) => bgColor),
  );
}

MenuThemeData _menuTheme(ColorScheme colorScheme) {
  return MenuThemeData(
    style: _menuStyle(colorScheme),
  );
}

DropdownMenuThemeData _dropdownMenuTheme(ColorScheme colorScheme) {
  return DropdownMenuThemeData(
    menuStyle: _menuStyle(colorScheme),
  );
}

SliderThemeData _sliderTheme(ColorScheme colorScheme) {
  return SliderThemeData(
    thumbColor: Colors.white,
    overlayShape: const RoundSliderOverlayShape(
      overlayRadius: 13,
    ),
    overlayColor:
        colorScheme.primary.withOpacity(colorScheme.isLight ? 0.4 : 0.7),
    thumbShape: const RoundSliderThumbShape(elevation: 3.0),
    inactiveTrackColor: colorScheme.onSurface.withOpacity(0.3),
  );
}

SwitchThemeData _switchTheme(ColorScheme colorScheme) {
  return SwitchThemeData(
    trackOutlineColor: MaterialStateColor.resolveWith(
      (states) => Colors.transparent,
    ),
    thumbColor: MaterialStateProperty.resolveWith(
      (states) => _getSwitchThumbColor(states, colorScheme),
    ),
    trackColor: MaterialStateProperty.resolveWith(
      (states) => _getSwitchTrackColor(states, colorScheme),
    ),
  );
}

Color _getSwitchThumbColor(Set<MaterialState> states, ColorScheme colorScheme) {
  if (states.contains(MaterialState.disabled)) {
    if (states.contains(MaterialState.selected)) {
      return colorScheme.onSurface.withOpacity(0.5);
    }
    return colorScheme.onSurface.withOpacity(0.5);
  } else {
    return colorScheme.onPrimary;
  }
}

Color _getSwitchTrackColor(Set<MaterialState> states, ColorScheme colorScheme) {
  final uncheckedColor = colorScheme.onSurface.withOpacity(.25);
  final disabledUncheckedColor = colorScheme.onSurface.withOpacity(.15);
  final disabledCheckedColor = colorScheme.onSurface.withOpacity(.18);

  if (states.contains(MaterialState.disabled)) {
    if (states.contains(MaterialState.selected)) {
      return disabledCheckedColor;
    }
    return disabledUncheckedColor;
  } else {
    if (states.contains(MaterialState.selected)) {
      return colorScheme.primary;
    } else {
      return uncheckedColor;
    }
  }
}

ProgressIndicatorThemeData _progressIndicatorTheme(ColorScheme colorScheme) {
  return ProgressIndicatorThemeData(
    circularTrackColor: colorScheme.primary.withOpacity(0.4),
    linearTrackColor: colorScheme.primary.withOpacity(0.4),
  );
}

NavigationRailThemeData _naviRailTheme(ColorScheme colorScheme) {
  return NavigationRailThemeData(
    indicatorColor: _indicatorColor(colorScheme),
  );
}

NavigationBarThemeData _naviBarTheme(ColorScheme colorScheme) {
  return NavigationBarThemeData(indicatorColor: _indicatorColor(colorScheme));
}

Color _indicatorColor(ColorScheme colorScheme) =>
    _dividerColor(colorScheme).withOpacity(0.8);

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.background,
  );
}

SnackBarThemeData _snackBarThemeData(ColorScheme scheme) {
  return SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    actionTextColor: scheme.primary.scale(
      saturation: 0.5,
      lightness: (scheme.isLight ? 0.2 : -0.5),
    ),
  );
}
