import 'package:flutter/material.dart';
import 'package:prompt_echo/home/home.dart';

import 'util/my_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          themeMode: currentMode,
          title: "Prompt Echo - All in one ai prompt bar",
          home: const Home(),
        );
      },
    );
  }
}
