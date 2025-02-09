import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appStyle.dart';
import 'package:evently/core/providers/themeProvider.dart';
import 'package:evently/core/themePref/themePref.dart';
import 'package:evently/ui/start_screen/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();///that's to insure flutter engine load all settings (local settings)
  await PrefHelper.init();
 await EasyLocalization.ensureInitialized();///that's await  to ensure all local files are read and wait untill init
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(///to change  status bar color
      statusBarColor: AppStyle.light.colorScheme.secondary
  ));
  runApp(EasyLocalization(supportedLocales: [Locale("ar"),Locale("en")],///we put or main app widget in easy local widget to set it's configration on material widget to config your app (as paernt of material )
  path: 'assets/translations',
  fallbackLocale: const Locale("en"),///that's for if your app have a proplem with tranclation that's will be main lang
  saveLocale: true,///that's to save last local to app cache
 /*startLocale: EasyLocalization.of(context)?.deviceLocale,*/
  child: ChangeNotifierProvider(
      create: (BuildContext context) {
        return ThemeProvider()..initTheme();
      },
      child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider providerThemeMode=Provider.of<ThemeProvider>(context);
    return MaterialApp(
localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: AppStyle.light,
      darkTheme: AppStyle.dark,
      themeMode: providerThemeMode.themeMode ,
      routes: {
        StartScreen.routeName: (context) => StartScreen()
      },
      initialRoute: StartScreen.routeName,
    );
  }
}