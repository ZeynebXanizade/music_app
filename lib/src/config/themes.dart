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
    colorScheme: ColorScheme.dark(
      primary: darkGrey,
      secondary: green,
      surface: darkBlue,
    ),

    textTheme: TextTheme(
      labelMedium: TextStyle(color: lightBlue),
      headlineLarge: TextStyle(color: lightBlue),
      headlineSmall: TextStyle(color: lightBlue),
      titleMedium: TextStyle(color: secondaryGrey),
      titleLarge: TextStyle(color: secondaryGrey),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: lightBlue,
      textStyle: TextStyle(color: darkBlue),
      iconColor: lightBlue,
    ),
    iconTheme: IconThemeData(color: lightBlue),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: lightBlue),
    ),
    hintColor: lightBlue,
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
    colorScheme: ColorScheme.light(
      primary: grey,
      secondary: green,
      surface: lightBlue,
    ),

    textTheme: TextTheme(
      labelMedium: TextStyle(color: darkBlue),
      headlineLarge: TextStyle(color: lightBlue),
      headlineSmall: TextStyle(color: darkBlue),
      titleMedium: TextStyle(color: secondaryGrey),
      titleLarge: TextStyle(color: secondaryGrey),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: darkBlue,
      textStyle: TextStyle(color: lightBlue),
      iconColor: darkBlue,
    ),
    iconTheme: IconThemeData(color: darkBlue),
    hintColor: darkBlue,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: darkBlue),
    ),
  );
}
