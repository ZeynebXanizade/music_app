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
    colorScheme: ColorScheme.dark(primary: darkGrey, secondary: green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: darkBlue),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(color: lightBlue),
      headlineLarge: TextStyle(color: lightBlue),
      headlineSmall: TextStyle(color: lightBlue),
      titleMedium: TextStyle(color: secondaryGrey),
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
    colorScheme: ColorScheme.light(primary: grey, secondary: green),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(color: darkBlue),
      headlineLarge: TextStyle(color: lightBlue),
      headlineSmall: TextStyle(color: darkBlue),
      titleMedium: TextStyle(color: secondaryGrey),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: green,
      textStyle: TextStyle(color: lightBlue),
      iconColor: green,
    ),
    iconTheme: IconThemeData(color: green),
  );
}
