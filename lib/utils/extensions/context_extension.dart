import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  AppLocalizations? get appLocalizations => AppLocalizations.of(this);
}

extension DarkMode on BuildContext {
  bool get isDarkMode => mediaQuery.platformBrightness == Brightness.dark;
}
