import 'package:evently/core/themePref/themePref.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  initTheme(){
  bool isLight =  PrefHelper.prefs.getBool("theme")??true;
  if(isLight){
    themeMode=ThemeMode.light;
  }else{
    themeMode=ThemeMode.dark;
  }
  }
  changeThemeMode(ThemeMode newThemeMode){

    themeMode=newThemeMode;
    notifyListeners();


  }

}