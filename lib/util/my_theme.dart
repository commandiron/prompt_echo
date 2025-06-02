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
  static const onSurfaceDark = Color(0xffF2F0E3);
  static const outlineDark = Color(0xffffffff);
  static const secondaryDark = Color(0xff616161);
  static const tertiaryDark = Color(0xff363636);
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      outline: outlineDark,
      secondary: secondaryDark,
      tertiary: tertiaryDark,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: onSurfaceDark),
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
      extendedSizeConstraints: BoxConstraints(minHeight: 47),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: primaryDark),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return onSurfaceDark;
        }
        return surfaceDark;
      }),
    ),
    useMaterial3: true,
  );
  static const primaryLight = Color(0xffF54A27);
  static const surfaceLight = Color(0xffF2F0E3);
  static const onSurfaceLight = Color(0xff1F1F1F);
  static const outlineLight = Color(0xff000000);
  static const secondaryLight = Color(0xff9A9A9A);
  static const tertiaryLight = Color(0xffE6E4D7);
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      outline: outlineLight,
      secondary: secondaryLight,
      tertiary: tertiaryLight
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: onSurfaceLight),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: onSurfaceLight,
      foregroundColor: surfaceLight,
      extendedSizeConstraints: BoxConstraints(minHeight: 47),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: primaryLight),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return onSurfaceLight;
        }
        return surfaceLight;
      }),
    ),
    useMaterial3: true,
  );
}
