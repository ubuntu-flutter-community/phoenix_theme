import 'package:flutter/material.dart';

import '../constants.dart';

class FontsView extends StatelessWidget {
  const FontsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(kWrapSpacing),
      children: <Widget>[
        _TextShow(
          name: 'displayLarge',
          style: theme.textTheme.displayLarge,
        ),
        _TextShow(
          name: 'displayMedium',
          style: theme.textTheme.displayMedium,
        ),
        _TextShow(
          name: 'displaySmall',
          style: theme.textTheme.displaySmall,
        ),
        _TextShow(
          name: 'headlineLarge',
          style: theme.textTheme.headlineLarge,
        ),
        _TextShow(
          name: 'headlineMedium',
          style: theme.textTheme.headlineMedium,
        ),
        _TextShow(
          name: 'headlineSmall',
          style: theme.textTheme.headlineSmall,
        ),
        _TextShow(
          name: 'titleLarge',
          style: theme.textTheme.titleLarge,
        ),
        _TextShow(
          name: 'titleMedium',
          style: theme.textTheme.titleMedium,
        ),
        _TextShow(
          name: 'titleSmall',
          style: theme.textTheme.titleSmall,
        ),
        _TextShow(
          name: 'bodyLarge',
          style: theme.textTheme.bodyLarge,
        ),
        _TextShow(
          name: 'bodyMedium',
          style: theme.textTheme.bodyMedium,
        ),
        _TextShow(
          name: 'bodySmall',
          style: theme.textTheme.bodySmall,
        ),
        _TextShow(
          name: 'labelLarge',
          style: theme.textTheme.labelLarge,
        ),
        _TextShow(
          name: 'labelMedium',
          style: theme.textTheme.labelMedium,
        ),
        _TextShow(
          name: 'labelSmall',
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _TextShow extends StatelessWidget {
  const _TextShow({
    required this.name,
    required this.style,
  });

  final String name;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final showStyle = TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.normal,
      color: style?.color,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Text(
                    'color: ${style?.color.toString().replaceAll('Color(0x', '#').replaceAll(')', '') ?? ''}',
                    style: showStyle,
                  ),
                  Text(
                    style?.fontWeight.toString() ?? '',
                    style: showStyle,
                  ),
                  Text(
                    'size: ${style?.fontSize.toString() ?? ''} ',
                    style: showStyle,
                  ),
                ],
              ),
            ),
            Text(
              name,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
