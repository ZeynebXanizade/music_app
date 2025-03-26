import 'package:flutter/material.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';

class ThemesApp {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBlue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBlue,
      unselectedItemColor: grey,
      selectedItemColor: green,
    ),
    highlightColor: transparent,
    splashColor: transparent,
    colorScheme: ColorScheme.dark(primary: lightBlue, secondary: green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: darkBlue),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(color: lightBlue),
      headlineLarge: TextStyle(color: darkBlue),
      headlineSmall: TextStyle(color: lightBlue),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: green,
      textStyle: TextStyle(color: darkBlue),
      iconColor: green,
    ),
    iconTheme: IconThemeData(color: green),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBlue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightBlue,
      unselectedItemColor: darkGrey,
      selectedItemColor: green,
    ),
    highlightColor: transparent,
    splashColor: transparent,
    colorScheme: ColorScheme.light(primary: darkBlue, secondary: green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(color: darkBlue),
      headlineLarge: TextStyle(color: lightBlue),
      headlineSmall: TextStyle(color: darkBlue),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: green,
      textStyle: TextStyle(color: lightBlue),
      iconColor: green,
    ),
    iconTheme: IconThemeData(color: green),
  );
}
