import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_x.dart';
import 'theme_data_x.dart';

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});

const _lightBase = Colors.white;
final _darkBase = Colors.black.scale(lightness: 0.11);
final _darkMenuBase = Colors.black.scale(lightness: 0.1);
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
      // inputDecorationTheme: _inputDecorationTheme(lightScheme),
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
      drawerTheme: _drawerTheme(lightScheme),
    ),
    darkTheme: ThemeData(
      colorScheme: darkScheme,
      scaffoldBackgroundColor: darkScheme.surface,
      splashFactory: NoSplash.splashFactory,
      dividerColor: _dividerColor(darkScheme),
      cardColor: _cardColor(darkScheme),
      // inputDecorationTheme: _inputDecorationTheme(darkScheme),
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
      drawerTheme: _drawerTheme(darkScheme),
    )
  );
}

ColorScheme _darkScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
    surfaceTint: _darkBase,
    surface: _darkBase.scale(lightness: 0.03),
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
  final bgColor = colorScheme.isLight ? _lightBase : _darkMenuBase;
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
  final bgColor = colorScheme.isLight ? _lightBase : _darkMenuBase;
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
  final bgColor = colorScheme.isLight ? _lightBase : _darkMenuBase;

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
    trackOutlineColor: WidgetStateColor.resolveWith(
      (states) => Colors.transparent,
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
    return colorScheme.onPrimary;
  }
}

Color _getSwitchTrackColor(Set<WidgetState> states, ColorScheme colorScheme) {
  final uncheckedColor = colorScheme.onSurface.withOpacity(.25);
  final disabledUncheckedColor = colorScheme.onSurface.withOpacity(.15);
  final disabledCheckedColor = colorScheme.onSurface.withOpacity(.18);

  if (states.contains(WidgetState.disabled)) {
    if (states.contains(WidgetState.selected)) {
      return disabledCheckedColor;
    }
    return disabledUncheckedColor;
  } else {
    if (states.contains(WidgetState.selected)) {
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

// InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
//   final radius = BorderRadius.circular(kButtonRadius);
//   const width = 1.0;
//   const strokeAlign = 0.0;
//   final border = colorScheme.outline;
//   final fill = border.scale(
//     lightness: colorScheme.isLight ? 0.8 : -0.5,
//   );

//   final disabledBorder =
//       border.scale(lightness: colorScheme.isLight ? 0.2 : -0.2);

//   const textStyle = TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.normal,
//   );
//   return InputDecorationTheme(
//     filled: true,
//     fillColor: fill,
//     border: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: width,
//         color: border,
//       ),
//       borderRadius: radius,
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(width: width, color: colorScheme.primary),
//       borderRadius: radius,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide:
//           BorderSide(width: width, color: border, strokeAlign: strokeAlign),
//       borderRadius: radius,
//     ),
//     activeIndicatorBorder:
//         const BorderSide(width: width, strokeAlign: strokeAlign),
//     outlineBorder: const BorderSide(width: width, strokeAlign: strokeAlign),
//     focusedErrorBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: width,
//         color: colorScheme.error,
//         strokeAlign: strokeAlign,
//       ),
//       borderRadius: radius,
//     ),
//     errorBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: width,
//         color: colorScheme.error,
//         strokeAlign: strokeAlign,
//       ),
//       borderRadius: radius,
//     ),
//     disabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: width,
//         color: disabledBorder,
//         strokeAlign: strokeAlign,
//       ),
//       borderRadius: radius,
//     ),
//     iconColor: colorScheme.onSurface,
//     helperStyle: textStyle,
//     hintStyle: textStyle,
//     labelStyle: textStyle,
//     suffixStyle: textStyle.copyWith(
//       color: colorScheme.onSurface.scale(lightness: -0.2),
//     ),
//     prefixStyle: textStyle.copyWith(
//       color: colorScheme.onSurface.scale(lightness: -0.2),
//     ),
//     isDense: !isMobile,
//     contentPadding: isMobile
//         ? null
//         : const EdgeInsets.only(left: 12, right: 12, bottom: 9, top: 10),
//   );
// }

bool get isMobile =>
    !kIsWeb && Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
