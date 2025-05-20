import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_x.dart';
import 'theme_data_x.dart';

bool get _isMobile =>
    !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia);

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});

const _lightBase = Colors.white;
final _darkBaseDesktop = Colors.black.scale(lightness: 0.09);
final _darkBaseMobile = Colors.black.scale(lightness: 0.04);

final _darkBase = _isMobile ? _darkBaseMobile : _darkBaseDesktop;

final _darkMenuBaseDesktop = Colors.black.scale(lightness: 0.07);
final _darkMenuBaseMobile = Colors.black.scale(lightness: 0.08);
final _darkMenuBase = _isMobile ? _darkMenuBaseMobile : _darkMenuBaseDesktop;

const _kContainerRadius = 10.0;
const _kDesktopButtonHeight = 42.0;
const _kMobileButtonHeight = 48.0;
final _kButtonHeight = _isMobile ? _kMobileButtonHeight : _kDesktopButtonHeight;
final _kButtonRadius = _kButtonHeight / 2;
const _kMenuRadius = 8.0;
const _kInputDecorationRadius = 6.0;
const _kDesktopIconSize = 20.0;
const _kMobileIconSize = 24.0;
final _iconSize = _isMobile ? _kMobileIconSize : _kDesktopIconSize;

ThemePair phoenixTheme({
  required Color color,
  double? buttonRadius,
  double? buttonHeight,
}) {
  final darkScheme = _darkScheme(color);
  final lightScheme = _lightScheme(color);

  return (
    lightTheme: _phoenixTheme(
      colorScheme: lightScheme,
      buttonHeight: buttonHeight,
      buttonRadius: buttonRadius,
    ),
    darkTheme: _phoenixTheme(
      colorScheme: darkScheme,
      buttonHeight: buttonHeight,
      buttonRadius: buttonRadius,
    )
  );
}

ThemeData _phoenixTheme({
  required ColorScheme colorScheme,
  double? buttonRadius,
  double? buttonHeight,
}) {
  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(buttonRadius ?? _kButtonRadius),
  );

  final buttonSize =
      Size(buttonHeight ?? _kButtonHeight, buttonHeight ?? _kButtonHeight);

  return ThemeData(
    iconTheme: IconThemeData(
      size: _iconSize,
      color: colorScheme.onSurface,
    ),
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    splashFactory: NoSplash.splashFactory,
    dividerColor: _dividerColor(colorScheme),
    cardColor: _cardColor(colorScheme),
    menuTheme: _menuTheme(colorScheme),
    popupMenuTheme: _popupMenuTheme(colorScheme),
    dialogTheme: _dialogTheme(colorScheme),
    dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
    sliderTheme: _sliderTheme(colorScheme),
    dividerTheme: _dividerTheme(colorScheme),
    progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
    switchTheme: _switchTheme(colorScheme),
    checkboxTheme: _checkBoxTheme(colorScheme),
    floatingActionButtonTheme: _floatingActionButtonTheme(colorScheme),
    elevatedButtonTheme: _elevatedButtonTheme(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    outlinedButtonTheme: _outlinedButtonTheme(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    filledButtonTheme: _filledButtonTheme(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    textButtonTheme: _textButtonThemeData(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    iconButtonTheme: _iconButtonTheme(
      colorScheme: colorScheme,
      buttonSize: buttonSize,
    ),
    navigationRailTheme: _naviRailTheme(colorScheme),
    navigationBarTheme: _naviBarTheme(colorScheme),
    appBarTheme: _appBarTheme(colorScheme),
    snackBarTheme: _snackBarThemeData(colorScheme),
    cardTheme: _cardTheme(colorScheme),
    drawerTheme: _drawerTheme(colorScheme),
    inputDecorationTheme: _inputDecorationTheme(colorScheme),
    listTileTheme: _createListTileTheme(colorScheme),
    chipTheme: _createChipTheme(
      selectedColor: colorScheme.primary,
      colorScheme: colorScheme,
      textStyle: const TextStyle(fontSize: 14, height: 1.08),
    ),
    bottomSheetTheme: _createBottomSheetTheme(colorScheme),
  );
}

BottomSheetThemeData _createBottomSheetTheme(ColorScheme colorScheme) =>
    BottomSheetThemeData(
      elevation: 3,
      modalBackgroundColor: _menuBg(colorScheme),
      backgroundColor: _menuBg(colorScheme),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(_kContainerRadius),
          topLeft: Radius.circular(_kContainerRadius),
        ),
        side: colorScheme.isLight
            ? BorderSide.none
            : BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
      ),
    );

ColorScheme _darkScheme(Color color) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
    surfaceTint: _darkBase,
    inverseSurface: _lightBase,
    onInverseSurface: _darkBase,
    surface: _darkBase,
    // ignore: deprecated_member_use
    background: _darkBase,
    outline: _darkBase.scale(lightness: 0.28),
  );
  return colorScheme.copyWith(
    onSurface: colorScheme.onSurface.scale(
      saturation: -1,
    ),
    onSurfaceVariant: colorScheme.onSurfaceVariant.scale(
      saturation: -1,
    ),
  );
}

ColorScheme _lightScheme(Color color) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.light,
    surface: _lightBase,
    surfaceTint: _lightBase,
    inverseSurface: _darkBase,
    onInverseSurface: _lightBase,
    outline: Colors.white.scale(lightness: -0.3),
  );
  return colorScheme.copyWith(
    onSurface: colorScheme.onSurface.scale(
      saturation: -1,
    ),
    onSurfaceVariant: colorScheme.onSurfaceVariant.scale(
      saturation: -1,
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

DialogThemeData _dialogTheme(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);
  return DialogThemeData(
    backgroundColor: bgColor,
    surfaceTintColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_kContainerRadius),
      side: colorScheme.isLight
          ? BorderSide.none
          : BorderSide(
              color: Colors.white.withValues(alpha: 0.2),
            ),
    ),
  );
}

CardThemeData _cardTheme(ColorScheme colorScheme) {
  return CardThemeData(
    color: _cardColor(colorScheme),
  );
}

Color _cardColor(ColorScheme colorScheme) {
  return colorScheme.surface.scale(
    lightness: _isMobile
        ? (colorScheme.isLight ? -0.06 : 0.08)
        : (colorScheme.isLight ? -0.06 : 0.05),
  );
}

PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);
  return PopupMenuThemeData(
    color: bgColor,
    surfaceTintColor: bgColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_kContainerRadius),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withValues(
          alpha: colorScheme.isLight ? 0.3 : 0.2,
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
          color: colorScheme.onSurface.withValues(
            alpha: colorScheme.isLight ? 0.3 : 0.2,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(_kMenuRadius),
      ),
    ),
    side: WidgetStateBorderSide.resolveWith(
      (states) => BorderSide(
        color: colorScheme.onSurface.withValues(
          alpha: colorScheme.isLight ? 0.3 : 0.2,
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
        colorScheme.primary.withValues(alpha: colorScheme.isLight ? 0.4 : 0.7),
    inactiveTrackColor: colorScheme.primary.withValues(alpha: 0.5),
    trackShape: CustomTrackShape(),
  );
}

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
    isDense: _isMobile ? false : true,
    filled: true,
    fillColor: colorScheme.surface
        .scale(lightness: colorScheme.isLight ? -0.07 : 0.03),
    border: _inputBorder(colorScheme: colorScheme),
    enabledBorder: _inputBorder(
      colorScheme: colorScheme,
    ),
    focusedBorder: _inputBorder(
      colorScheme: colorScheme,
      state: WidgetState.focused,
    ),
  );
}

OutlineInputBorder _inputBorder({
  required ColorScheme colorScheme,
  WidgetState? state,
}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: switch (state) {
        WidgetState.focused => colorScheme.primary,
        WidgetState.hovered => colorScheme.primary,
        _ =>
          colorScheme.outline.scale(lightness: colorScheme.isLight ? 0 : 0.1),
      },
    ),
    borderRadius:
        const BorderRadius.all(Radius.circular(_kInputDecorationRadius)),
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
          colorScheme.onSurface.withValues(alpha: 0.3),
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
      return colorScheme.onSurface.withValues(alpha: 0.5);
    }
    return colorScheme.onSurface.withValues(alpha: 0.5);
  } else {
    return colorScheme.isLight ? colorScheme.primary : colorScheme.primaryFixed;
  }
}

Color _getSwitchTrackColor(Set<WidgetState> states, ColorScheme colorScheme) {
  return switch (states.toList()) {
    [WidgetState.disabled] ||
    [WidgetState.disabled, WidgetState.selected] =>
      colorScheme.onSurface.withValues(alpha: 0.3),
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
    circularTrackColor: colorScheme.primary.withValues(alpha: 0.4),
    linearTrackColor: colorScheme.primary.withValues(alpha: 0.4),
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

ElevatedButtonThemeData _elevatedButtonTheme({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: buttonShape,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.primary.contrastColor,
      minimumSize: buttonSize,
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonTheme({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
      backgroundColor: colorScheme.primary.withValues(alpha: 0.03),
      side: BorderSide(
        color: colorScheme.primary.withValues(alpha: 0.4),
      ),
    ),
  );
}

FilledButtonThemeData _filledButtonTheme({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
    ),
  );
}

TextButtonThemeData _textButtonThemeData({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
    ),
  );
}

IconButtonThemeData _iconButtonTheme({
  required ColorScheme colorScheme,
  required Size buttonSize,
}) {
  return IconButtonThemeData(
    style: IconButton.styleFrom(
      minimumSize: buttonSize,
      padding:
          buttonSize.height < _kMobileButtonHeight ? EdgeInsets.zero : null,
      visualDensity: buttonSize.height < _kMobileButtonHeight
          ? VisualDensity.compact
          : null,
    ).copyWith(
      iconSize: WidgetStatePropertyAll(_iconSize),
      iconColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.disabled)
            ? colorScheme.onSurface.withValues(alpha: 0.7)
            : colorScheme.onSurface,
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? colorScheme.onSurface.withValues(alpha: 0.1)
            : Colors.transparent,
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
    _dividerColor(colorScheme).withValues(alpha: 0.8);

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
        topEnd: Radius.circular(_kContainerRadius),
        bottomEnd: Radius.circular(_kContainerRadius),
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
    backgroundColor: colorScheme.inverseSurface,
    behavior: SnackBarBehavior.floating,
    actionTextColor: colorScheme.primary.scale(
      saturation: 0.5,
      lightness: (colorScheme.isLight ? 0.2 : -0.5),
    ),
  );
}

ListTileThemeData _createListTileTheme(ColorScheme colorScheme) {
  final isHighContrast =
      [Colors.black, Colors.white].contains(colorScheme.primary);

  return ListTileThemeData(
    selectedColor:
        isHighContrast ? colorScheme.onInverseSurface : colorScheme.onSurface,
    iconColor: colorScheme.onSurface.withValues(alpha: 0.8),
    selectedTileColor: isHighContrast
        ? colorScheme.inverseSurface
        : colorScheme.onSurface.withValues(
            alpha: colorScheme.brightness == Brightness.dark ? 0.035 : 0.04,
          ),
    minVerticalPadding: 6,
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      side: BorderSide.none,
    ),
  );
}

ChipThemeData _createChipTheme({
  required Color selectedColor,
  required ColorScheme colorScheme,
  required TextStyle? textStyle,
}) {
  final isHC = colorScheme.primary == Colors.black ||
      colorScheme.primary == Colors.white;
  final selectedBackgroundColor =
      isHC ? colorScheme.inverseSurface : selectedColor;
  final selectedForeGroundColor =
      isHC ? colorScheme.onInverseSurface : colorScheme.onSurface;

  return ChipThemeData(
    selectedColor: selectedBackgroundColor.withValues(alpha: isHC ? 1 : 0.4),
    labelStyle: textStyle?.copyWith(color: colorScheme.onSurface),
    checkmarkColor: selectedForeGroundColor,
    secondaryLabelStyle: textStyle?.copyWith(
      color: selectedForeGroundColor,
      fontWeight: isHC ? FontWeight.bold : FontWeight.normal,
    ),
    side: WidgetStateBorderSide.resolveWith(
      (s) => BorderSide(
        color: s.contains(WidgetState.selected)
            ? selectedBackgroundColor.withValues(alpha: isHC ? 1 : 0.1)
            : (isHC ? colorScheme.outlineVariant : colorScheme.outline)
                .withValues(
                alpha:
                    s.contains(WidgetState.disabled) ? (isHC ? 0.3 : 0.7) : 1,
              ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  );
}
