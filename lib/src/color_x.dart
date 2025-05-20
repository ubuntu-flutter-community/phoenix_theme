import 'package:flutter/material.dart';

extension ColorX on Color {
  /// Scale color attributes relatively to current ones.
  /// [alpha], [hue], [saturation] and [lightness] values must be clamped between -1.0 and 1.0
  Color scale({
    double alpha = 0.0,
    double hue = 0.0,
    double saturation = 0.0,
    double lightness = 0.0,
  }) {
    assert(alpha >= -1.0 && alpha <= 1.0);
    assert(hue >= -1.0 && hue <= 1.0);
    assert(saturation >= -1.0 && saturation <= 1.0);
    assert(lightness >= -1.0 && lightness <= 1.0);

    final hslColor = _getPatchedHslColor();

    double scale(double value, double amount, [double upperLimit = 1.0]) {
      var result = value;

      if (amount > 0) {
        result = value + (upperLimit - value) * amount;
      } else if (amount < 0) {
        result = value + value * amount;
      }

      return result.clamp(0.0, upperLimit);
    }

    return hslColor
        .withAlpha(scale(a, alpha))
        .withHue(scale(hslColor.hue, hue, 360.0))
        .withSaturation(scale(hslColor.saturation, saturation))
        .withLightness(scale(hslColor.lightness, lightness))
        .toColor();
  }

  /// Adjust color attributes by the given values.
  /// [alpha], [saturation] and [lightness] values must be clamped between -1.0 and 1.0
  /// [hue] value must be clamped between -360.0 and 360.0
  Color adjust({
    double alpha = 0.0,
    double hue = 0.0,
    double saturation = 0.0,
    double lightness = 0.0,
  }) {
    assert(alpha >= -1.0 && alpha <= 1.0);
    assert(hue >= -360.0 && hue <= 360.0);
    assert(saturation >= -1.0 && saturation <= 1.0);
    assert(lightness >= -1.0 && lightness <= 1.0);

    final hslColor = _getPatchedHslColor();

    double adjust(double value, double amount, [double upperLimit = 1.0]) {
      return (value + amount).clamp(0.0, upperLimit);
    }

    return hslColor
        .withAlpha(adjust(hslColor.alpha, alpha))
        .withHue(adjust(hslColor.hue, hue, 360.0))
        .withSaturation(adjust(hslColor.saturation, saturation))
        .withLightness(adjust(hslColor.lightness, lightness))
        .toColor();
  }

  /// Return a copy of this color with attributes replaced by given values.
  /// [alpha], [saturation] and [lightness] values must be clamped between 0.0 and 1.0
  /// [hue] value must be clamped between 0.0 and 360.0
  Color copyWith({
    double? alpha,
    double? hue,
    double? saturation,
    double? lightness,
  }) {
    assert(alpha == null || (alpha >= 0.0 && alpha <= 1.0));
    assert(hue == null || (hue >= 0.0 && hue <= 360.0));
    assert(saturation == null || (saturation >= 0.0 && saturation <= 1.0));
    assert(lightness == null || (lightness >= 0.0 && lightness <= 1.0));

    final hslColor = _getPatchedHslColor();

    return hslColor
        .withAlpha(alpha ?? hslColor.alpha)
        .withHue(hue ?? hslColor.hue)
        .withSaturation(saturation ?? hslColor.saturation)
        .withLightness(lightness ?? hslColor.lightness)
        .toColor();
  }

  Color cap({
    double alpha = 1.0,
    double saturation = 1.0,
    double lightness = 1.0,
  }) {
    assert(alpha >= 0.0 && alpha <= 1.0);
    assert(saturation >= 0.0 && saturation <= 1.0);
    assert(lightness >= 0.0 && lightness <= 1.0);

    final hslColor = _getPatchedHslColor();

    return hslColor
        .withAlpha(hslColor.alpha <= alpha ? hslColor.alpha : alpha)
        .withSaturation(
          hslColor.saturation <= saturation ? hslColor.saturation : saturation,
        )
        .withLightness(
          hslColor.lightness <= lightness ? hslColor.lightness : lightness,
        )
        .toColor();
  }

  Color capDown({
    double alpha = 0.0,
    double saturation = 0.0,
    double lightness = 0.0,
  }) {
    assert(alpha >= 0.0 && alpha <= 1.0);
    assert(saturation >= 0.0 && saturation <= 1.0);
    assert(lightness >= 0.0 && lightness <= 1.0);

    final hslColor = _getPatchedHslColor();

    return hslColor
        .withAlpha(hslColor.alpha >= alpha ? hslColor.alpha : alpha)
        .withSaturation(
          hslColor.saturation >= saturation ? hslColor.saturation : saturation,
        )
        .withLightness(
          hslColor.lightness >= lightness ? hslColor.lightness : lightness,
        )
        .toColor();
  }

  HSLColor _getPatchedHslColor() {
    final hslColor = HSLColor.fromColor(this);

    // A pure dark color have saturation level at 1.0, which results in red when lighten it.
    // We reset this value to 0.0, so the result is desaturated as expected:
    return hslColor
        .withSaturation(hslColor.lightness == 0.0 ? 0.0 : hslColor.saturation);
  }

  /// Returns a hex representation (`#AARRGGBB`) of the color.
  String toHex() {
    return '#${a.toInt().toHex()}${r.toInt().toHex()}${g.toInt().toHex()}${b.toInt().toHex()}';
  }

  Color get contrastColor =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.light
          ? Colors.black
          : Colors.white;
}

extension IntX on int {
  String toHex() => toRadixString(16).padLeft(2, '0');
}
