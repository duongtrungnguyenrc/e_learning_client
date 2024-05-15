import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

class ThemeController {
  static ThemeData getAppTheme(ThemeMode themeMode) {
    return ThemeData(
      primaryColor: ColorConstants.primary,
      primaryColorLight: ColorConstants.primary,
      primaryColorDark: ColorConstants.white,
      fontFamily: "Roboto",
      popupMenuTheme: PopupMenuThemeData(
        color: ColorConstants.white,
        surfaceTintColor: ColorConstants.white,
        elevation: 1,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
