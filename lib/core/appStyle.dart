import 'package:flutter/material.dart';

import 'appMangers/colorsManger.dart';
///themes can't take widget
class AppStyle{
  static ThemeData light=ThemeData(
scaffoldBackgroundColor: ColorManger.lightPrimary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontFamily: "inter",fontSize: 20,fontWeight: FontWeight.w700,color: ColorManger.lightSecondary ),
      bodyMedium: TextStyle(fontFamily: "inter",fontSize: 16,fontWeight: FontWeight.w700,color: ColorManger.lightTertiary),
    ),
    colorScheme: ColorScheme.highContrastLight(
      primary: ColorManger.lightPrimary,
      secondary: ColorManger.lightSecondary,
      tertiary: ColorManger.lightTertiary,

    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
        color: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0
    )
  );
  static ThemeData dark=ThemeData(
      scaffoldBackgroundColor: ColorManger.darkPrimary,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontFamily: "inter",fontSize: 20,fontWeight: FontWeight.w700,color: ColorManger.darkPrimary ),
        bodyMedium: TextStyle(fontFamily: "inter",fontSize: 16,fontWeight: FontWeight.w700,color: ColorManger.lightPrimary),
      ),
      colorScheme: ColorScheme.highContrastLight(
          primary: ColorManger.darkPrimary,
        secondary: ColorManger.darkSecondary,
         tertiary: ColorManger.darkTertiary
      )
  );
}