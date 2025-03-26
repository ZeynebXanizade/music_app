import 'package:flutter/material.dart';
import 'package:music_app/src/config/themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  Object getTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        return ThemesApp.lightTheme;
      case ThemeMode.dark:
        return ThemesApp.darkTheme;
      default:
        return _themeMode;
    }
  }
}
