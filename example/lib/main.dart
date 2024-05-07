import 'package:flutter/material.dart';
import 'package:phoenix_theme/phoenix_theme.dart';

import 'home.dart';
import 'src/color.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, widget) {
        return ValueListenableBuilder(
          valueListenable: colorNotifier,
          builder: (context, color, widget) {
            final theme = phoenixTheme(color: color);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme.lightTheme,
              themeMode: themeMode,
              darkTheme: theme.darkTheme,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
