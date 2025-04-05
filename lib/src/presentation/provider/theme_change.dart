import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/src/config/themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    _loadThemeFromPreferences(); // Load the saved theme mode on initialization
  }

  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _saveThemeToPreferences(mode); // Save the selected theme mode
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

  Future<void> _saveThemeToPreferences(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }

  Future<void> _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString =
        prefs.getString('theme_mode') ?? ThemeMode.system.toString();
    _themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeString,
      orElse: () => ThemeMode.system,
    );
    notifyListeners();
  }
}
