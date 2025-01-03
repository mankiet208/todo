import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xffe4421b);
  static const Color primaryLight = Color(0xfffc4b21);
  static const Color primaryDark = Color.fromARGB(255, 114, 58, 43);
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
    primary: AppColors.primary,
    onPrimary: AppColors.white1,
    primaryContainer: AppColors.primaryAccent,
    onPrimaryContainer: AppColors.white1,
    secondary: AppColors.black1,
    onSecondary: AppColors.white1,
    tertiary: AppColors.green1,
    onTertiary: Colors.white,
    surface: AppColors.white1, // background
    onSurface: AppColors.black1,
    error: AppColors.red1,
    onError: Colors.white,
    outline: AppColors.grey3,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.white1,
    primaryContainer: AppColors.primaryAccent,
    onPrimaryContainer: AppColors.white1,
    secondary: AppColors.white1,
    onSecondary: AppColors.black1,
    tertiary: AppColors.green1,
    onTertiary: Colors.white,
    surface: AppColors.black1, // background
    onSurface: AppColors.white1,
    error: AppColors.red1,
    onError: AppColors.white1,
    outline: AppColors.grey3,
  );
}
