import 'package:flutter/material.dart';

final themeNotifier = ThemeNotifier();

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setLightMode() {
    value = ThemeMode.light;
  }

  void setDarkMode() {
    value = ThemeMode.dark;
  }
}

class MyTheme {
  static const primaryDark = Color(0xffF54A27);
  static const surfaceDark = Color(0xff1F1F1F);
  static const onSurfaceDark = Color(0xffD1CFC0);
  static const outlineDark = Color(0xffffffff);
  static const secondaryDark = Color(0xff616161);
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      outline: outlineDark,
      secondary: secondaryDark,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: onSurfaceDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: onSurfaceDark,
        foregroundColor: surfaceDark,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: onSurfaceDark,
      foregroundColor: surfaceDark,
      extendedTextStyle: TextStyle(fontWeight: FontWeight.bold),
      extendedSizeConstraints: BoxConstraints(minHeight: 47),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: primaryDark),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return onSurfaceDark;
        }
        return surfaceDark;
      }),
    ),
    useMaterial3: true,
  );
  static const primaryLight = Color(0xffF54A27);
  static const surfaceLight = Color(0xffD1CFC0);
  static const onSurfaceLight = Color(0xff1F1F1F);
  static const outlineLight = Color(0xff000000);
  static const secondaryLight = Color(0xff9A9A9A);
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      outline: outlineLight,
      secondary: secondaryLight,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: onSurfaceLight,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: onSurfaceLight,
      foregroundColor: surfaceLight,
      extendedTextStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: primaryLight),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return onSurfaceLight;
        }
        return surfaceLight;
      }),
    ),
    useMaterial3: true,
  );
}
