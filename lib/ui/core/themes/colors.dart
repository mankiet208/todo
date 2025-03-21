import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xffe4421b);
  static const Color primaryLight = Color(0xFFF3623E);
  static const Color primaryDark = Color(0xFFCB3E1B);
  static const Color primaryAccent = Color(0xfffcede8);
  static const Color black1 = Color(0xFF101010);
  static const Color white1 = Color(0xFFFFF7FA);
  static const Color grey1 = Color(0xFFF2F2F2);
  static const Color grey2 = Color(0xFF919093);
  static const Color grey3 = Color(0xFF717171);
  static const Color whiteTransparent = Color(0x4DFFFFFF);
  static const Color blackTransparent = Color(0x4D000000);
  static const Color red1 = Color(0xFFE74C3C);
  static const Color green1 = Color(0xFF3D863E);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white1,
    primaryContainer: primaryAccent,
    onPrimaryContainer: black1,
    secondary: black1,
    onSecondary: white1,
    tertiary: green1,
    onTertiary: Colors.white,
    surface: white1, // background
    surfaceContainer: primaryLight,
    onSurface: black1,
    error: red1,
    onError: Colors.white,
    outline: grey3,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: white1,
    primaryContainer: primaryAccent,
    onPrimaryContainer: black1,
    secondary: white1,
    onSecondary: black1,
    tertiary: green1,
    onTertiary: Colors.white,
    surface: black1, // background
    surfaceContainer: primary,
    onSurface: white1,
    error: red1,
    onError: white1,
    outline: grey3,
  );
}
