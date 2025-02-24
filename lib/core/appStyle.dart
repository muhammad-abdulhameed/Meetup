import 'package:flutter/material.dart';

import 'appMangers/colorsManger.dart';
///themes can't take widget
class AppStyle{
  static ThemeData light=ThemeData(
scaffoldBackgroundColor: ColorManger.lightPrimary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontFamily: "inter",fontSize: 20,fontWeight: FontWeight.w700,color: ColorManger.lightSecondary ),
      bodyMedium: TextStyle(fontFamily: "inter",fontSize: 16,fontWeight: FontWeight.w700,color: ColorManger.lightTertiary),
      bodySmall: TextStyle(fontFamily: "inter",fontSize: 14,fontWeight: FontWeight.w500,color: ColorManger.lightPrimary),
        titleLarge:TextStyle(fontFamily: "inter",fontSize: 24,fontWeight: FontWeight.w700,color: ColorManger.lightPrimary),
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
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color: ColorManger.lightTertiary),
      iconTheme: IconThemeData(
        color: ColorManger.lightSecondary
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(

        backgroundColor: ColorManger.lightSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          maximumSize: Size(double.infinity, 56),
          minimumSize: Size(double.infinity, 56)
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 24,color: ColorManger.lightSecondary)
      )

    )
     , bottomNavigationBarTheme: BottomNavigationBarThemeData(
     backgroundColor: ColorManger.lightSecondary,type:BottomNavigationBarType.fixed,
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
      ,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManger.darkSecondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            maximumSize: Size(double.infinity, 56),
            minimumSize: Size(double.infinity, 20)

          )

      )
      , bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManger.darkPrimary,type:BottomNavigationBarType.fixed,

  )
  );
}