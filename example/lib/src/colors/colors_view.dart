import 'package:flutter/material.dart';
import 'package:phoenix_theme/phoenix_theme.dart';

const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 300,
  mainAxisExtent: 40,
  mainAxisSpacing: 20,
  crossAxisSpacing: 20,
);

class ColorsView extends StatelessWidget {
  const ColorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColors = _getAccentColors(theme);
    final baseColors = _getBaseColors(theme);
    final specialColors = _getSpecialColors(theme);

    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        ..._themeSection(
          theme: theme,
          colors: accentColors,
          headline: 'Theme Accent Colors',
        ),
        ..._themeSection(
          theme: theme,
          colors: baseColors,
          headline: 'Theme Base Colors',
        ),
        ..._themeSection(
          theme: theme,
          colors: specialColors,
          headline: 'Theme Special Colors',
        ),
        ..._themeSection(
          theme: theme,
          colors: getPrimaryColors(theme),
          headline: 'Primary Color Phoenix Variations',
        ),
      ],
    );
  }

  List<Widget> _themeSection({
    required ThemeData theme,
    required Map<String, (Color, Color?)> colors,
    required String headline,
  }) {
    final headlineStyle = theme.textTheme.headlineMedium;

    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 5),
        child: Text(
          headline,
          style: headlineStyle,
        ),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: _gridDelegate,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final e = colors.entries.elementAt(index);
          return _colorContainer(
            e.key,
            e.value.$1,
            e.value.$2,
          );
        },
      ),
      const _SpacedDivider(),
    ];
  }

  Widget _colorContainer(
    String colorName,
    Color backgroundColor, [
    Color? foregroundColor,
  ]) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              colorName,
              style: TextStyle(
                color: backgroundColor.contrastColor,
                fontSize: 9,
              ),
            ),
            Text(
              backgroundColor
                  .toString()
                  .replaceAll('Color(0x', '#')
                  .replaceAll(')', ''),
              style: TextStyle(
                color: backgroundColor.contrastColor,
                fontSize: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpacedDivider extends StatelessWidget {
  const _SpacedDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      child: Divider(
        height: 0,
      ),
    );
  }
}

Map<String, (Color, Color?)> _getSpecialColors(ThemeData theme) {
  final s = theme.colorScheme;

  final colors = <String, (Color, Color?)>{
    'error': (s.error, s.onError),
    'onError': (s.onError, null),
    'shadow': (s.shadow, null),
    'scrim': (s.scrim, null),
  };
  return colors;
}

Map<String, (Color, Color?)> _getAccentColors(ThemeData theme) {
  final s = theme.colorScheme;

  final colors = <String, (Color, Color?)>{
    'primary': (s.primary, s.onPrimary),
    'onPrimary': (s.onPrimary, null),
    'inversePrimary': (s.inversePrimary, null),
    'primaryContainer': (s.primaryContainer, s.onPrimaryContainer),
    'onPrimaryContainer': (s.onPrimaryContainer, null),
    'secondary': (s.secondary, s.onSecondary),
    'onSecondary': (s.onSecondary, null),
    'secondaryContainer': (s.secondaryContainer, s.onSecondaryContainer),
    'onSecondaryContainer': (s.onSecondaryContainer, null),
    'tertiary': (s.tertiary, s.onTertiary),
    'onTertiary': (s.onTertiary, null),
    'tertiaryContainer': (s.tertiaryContainer, s.onTertiaryContainer),
    'onTertiaryContainer': (s.onTertiaryContainer, null),
  };
  return colors;
}

Map<String, (Color, Color?)> _getBaseColors(ThemeData theme) {
  final s = theme.colorScheme;

  final colors = <String, (Color, Color?)>{
    'background': (s.surface, s.onSurface),
    'onBackground': (s.onSurface, null),
    'surface': (s.surface, s.onSurface),
    'onSurface': (s.onSurface, null),
    'surfaceTint': (s.surfaceTint, null),
    'surfaceVariant': (s.surfaceContainerHighest, s.onSurfaceVariant),
    'onSurfaceVariant': (s.onSurfaceVariant, null),
    'inverseSurface': (s.inverseSurface, s.onInverseSurface),
    'onInverseSurface': (s.onInverseSurface, null),
  };
  return colors;
}

Map<String, (Color, Color?)> getPrimaryColors(ThemeData theme) {
  return Map.fromEntries(
    Colors.accents.map(
      (e) => MapEntry(
        '#${e.toARGB32().toHex().toString()}',
        (e, theme.colorScheme.onPrimary),
      ),
    ),
  );
}
