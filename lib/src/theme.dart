import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_x.dart';
import 'theme_data_x.dart';

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});

const _lightBase = Colors.white;
final _darkBase = Colors.black.scale(lightness: 0.09);
final _darkMenuBase = Colors.black.scale(lightness: 0.07);
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
      scaffoldBackgroundColor: lightScheme.surface,
      splashFactory: NoSplash.splashFactory,
      dividerColor: _dividerColor(lightScheme),
      cardColor: _cardColor(lightScheme),
      menuTheme: _menuTheme(lightScheme),
      popupMenuTheme: _popupMenuTheme(lightScheme),
      dialogTheme: _dialogTheme(lightScheme),
      dialogBackgroundColor: _menuBg(lightScheme),
      dropdownMenuTheme: _dropdownMenuTheme(lightScheme),
      sliderTheme: _sliderTheme(lightScheme),
      dividerTheme: _dividerTheme(lightScheme),
      progressIndicatorTheme: _progressIndicatorTheme(lightScheme),
      switchTheme: _switchTheme(lightScheme),
      checkboxTheme: _checkBoxTheme(lightScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(lightScheme),
      elevatedButtonTheme: _elevatedButtonTheme(lightScheme),
      navigationRailTheme: _naviRailTheme(lightScheme),
      navigationBarTheme: _naviBarTheme(lightScheme),
      appBarTheme: _appBarTheme(lightScheme),
      snackBarTheme: _snackBarThemeData(lightScheme),
      cardTheme: _cardTheme(lightScheme),
      drawerTheme: _drawerTheme(lightScheme),
    ),
    darkTheme: ThemeData(
      colorScheme: darkScheme,
      scaffoldBackgroundColor: darkScheme.surface,
      splashFactory: NoSplash.splashFactory,
      dividerColor: _dividerColor(darkScheme),
      cardColor: _cardColor(darkScheme),
      menuTheme: _menuTheme(darkScheme),
      popupMenuTheme: _popupMenuTheme(darkScheme),
      dialogTheme: _dialogTheme(darkScheme),
      dialogBackgroundColor: _menuBg(darkScheme),
      dropdownMenuTheme: _dropdownMenuTheme(darkScheme),
      sliderTheme: _sliderTheme(darkScheme),
      dividerTheme: _dividerTheme(darkScheme),
      progressIndicatorTheme: _progressIndicatorTheme(darkScheme),
      switchTheme: _switchTheme(darkScheme),
      checkboxTheme: _checkBoxTheme(darkScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(darkScheme),
      elevatedButtonTheme: _elevatedButtonTheme(darkScheme),
      navigationRailTheme: _naviRailTheme(darkScheme),
      navigationBarTheme: _naviBarTheme(darkScheme),
      appBarTheme: _appBarTheme(darkScheme),
      snackBarTheme: _snackBarThemeData(darkScheme),
      cardTheme: _cardTheme(darkScheme),
      drawerTheme: _drawerTheme(darkScheme),
    )
  );
}

ColorScheme _darkScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
    surfaceTint: _darkBase,
    surface: _darkBase,
    // ignore: deprecated_member_use
    background: _darkBase,
    outline: _darkBase.scale(lightness: 0.28),
  );
}

ColorScheme _lightScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.light,
    surface: _lightBase,
    surfaceTint: _lightBase,
    outline: Colors.white.scale(lightness: -0.3),
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
  final bgColor = _menuBg(colorScheme);
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
    lightness: colorScheme.isLight ? -0.06 : 0.05,
  );
}

PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);
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
  final bgColor = _menuBg(colorScheme);

  return MenuStyle(
    surfaceTintColor: WidgetStateColor.resolveWith((states) => bgColor),
    shape: WidgetStateProperty.resolveWith(
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
    side: WidgetStateBorderSide.resolveWith(
      (states) => BorderSide(
        color: colorScheme.onSurface.withOpacity(
          colorScheme.isLight ? 0.3 : 0.2,
        ),
        width: 1,
      ),
    ),
    elevation: WidgetStateProperty.resolveWith((states) => 1),
    backgroundColor: WidgetStateProperty.resolveWith((states) => bgColor),
  );
}

Color _menuBg(ColorScheme colorScheme) =>
    colorScheme.isLight ? _lightBase : _darkMenuBase;

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
    overlayShape: const RoundSliderOverlayShape(
      overlayRadius: 13,
    ),
    overlayColor:
        colorScheme.primary.withOpacity(colorScheme.isLight ? 0.4 : 0.7),
    inactiveTrackColor: colorScheme.primary.withOpacity(0.5),
    trackShape: CustomTrackShape(),
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: 0,
    );
  }
}

SwitchThemeData _switchTheme(ColorScheme colorScheme) {
  return SwitchThemeData(
    trackOutlineColor: WidgetStateColor.resolveWith(
      (states) => switch (states.toList()) {
        [WidgetState.disabled] ||
        [WidgetState.disabled, WidgetState.selected] =>
          colorScheme.onSurface.withOpacity(0.3),
        _ => colorScheme.primary,
      },
    ),
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => _getSwitchThumbColor(states, colorScheme),
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => _getSwitchTrackColor(states, colorScheme),
    ),
  );
}

Color _getSwitchThumbColor(Set<WidgetState> states, ColorScheme colorScheme) {
  if (states.contains(WidgetState.disabled)) {
    if (states.contains(WidgetState.selected)) {
      return colorScheme.onSurface.withOpacity(0.5);
    }
    return colorScheme.onSurface.withOpacity(0.5);
  } else {
    return colorScheme.isLight ? colorScheme.primary : colorScheme.primaryFixed;
  }
}

Color _getSwitchTrackColor(Set<WidgetState> states, ColorScheme colorScheme) {
  return switch (states.toList()) {
    [WidgetState.disabled] ||
    [WidgetState.disabled, WidgetState.selected] =>
      colorScheme.onSurface.withOpacity(0.3),
    [WidgetState.hovered] => Colors.transparent,
    [] => colorScheme.surface,
    _ => colorScheme.primaryContainer,
  };
}

CheckboxThemeData _checkBoxTheme(ColorScheme colorScheme) {
  return CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  );
}

ProgressIndicatorThemeData _progressIndicatorTheme(ColorScheme colorScheme) {
  return ProgressIndicatorThemeData(
    circularTrackColor: colorScheme.primary.withOpacity(0.4),
    linearTrackColor: colorScheme.primary.withOpacity(0.4),
  );
}

FloatingActionButtonThemeData _floatingActionButtonTheme(
  ColorScheme colorScheme,
) {
  const elevation = 1.0;
  return FloatingActionButtonThemeData(
    elevation: elevation,
    focusElevation: elevation,
    hoverElevation: elevation,
    disabledElevation: elevation,
    highlightElevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.isLight
          ? colorScheme.primaryFixed
          : colorScheme.primaryContainer,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}

NavigationRailThemeData _naviRailTheme(ColorScheme colorScheme) {
  return NavigationRailThemeData(
    indicatorColor: _indicatorColor(colorScheme),
  );
}

NavigationBarThemeData _naviBarTheme(ColorScheme colorScheme) {
  return NavigationBarThemeData(
    indicatorColor: _indicatorColor(colorScheme),
    backgroundColor: colorScheme.surface,
  );
}

Color _indicatorColor(ColorScheme colorScheme) =>
    _dividerColor(colorScheme).withOpacity(0.8);

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    surfaceTintColor: colorScheme.surface,
  );
}

DrawerThemeData _drawerTheme(ColorScheme colorScheme) {
  return DrawerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(kContainerRadius),
        bottomEnd: Radius.circular(kContainerRadius),
      ),
      side: colorScheme.isLight
          ? BorderSide.none
          : BorderSide(
              color: _dividerColor(colorScheme),
            ),
    ),
    backgroundColor: colorScheme.surface,
  );
}

SnackBarThemeData _snackBarThemeData(ColorScheme colorScheme) {
  return SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    actionTextColor: colorScheme.primary.scale(
      saturation: 0.5,
      lightness: (colorScheme.isLight ? 0.2 : -0.5),
    ),
  );
}

bool get isMobile =>
    !kIsWeb && Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
