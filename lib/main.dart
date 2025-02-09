import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appStyle.dart';
import 'package:evently/core/providers/eventProvider.dart';
import 'package:evently/core/providers/locationProvider.dart';
import 'package:evently/core/providers/themeProvider.dart';
import 'package:evently/core/providers/userDataProvider.dart';
import 'package:evently/core/themePref/themePref.dart';
import 'package:evently/ui/EventDetails/EventDetails_screen.dart';
import 'package:evently/ui/EventDetails/editEvent/editEventScreen.dart';
import 'package:evently/ui/creatEvent/screen/createEvent_Screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/onBoarding/onBoarding_screen.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/resetPassword/screen/resetPassword_screen.dart';
import 'package:evently/ui/start_screen/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();///that's to insure flutter engine load all settings (local settings)

  await Firebase.initializeApp(///this code debends on firebase_options file/lib which platform targeted to use json file in platform file that's have configrations file of the platform like(api key) to connect to server of firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        StartScreen.routeName: (context) => StartScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
       LoginScreen.routeName:(_)=>LoginScreen(),
       ResetPasswordScreen.routeName:(_)=> ResetPasswordScreen(),
        HomeScreen.routeName:(_)=>  ChangeNotifierProvider(
          create:(context) =>  UserDataProvider()..changeUserData(),



            child:HomeScreen() ,
        )
          /*  ChangeNotifierProvider(create: (context) => LocationProvider()..getLocation(),
          child: ChangeNotifierProvider(create: (context) {
            return UserDataProvider()..changeUserData();
          }, child: HomeScreen()),
        ),*/,
        OnBoardingScreen.routeName:(_)=>OnBoardingScreen(),
        CreateEvent.routeName:(_)=>CreateEvent(),
        EventDetailsScreen.routeName:(_)=>EventDetailsScreen(),
        EditEvent.routeName:(_)=>EditEvent(),
      },
      initialRoute:FirebaseAuth.instance.currentUser!=null? HomeScreen.routeName:RegisterScreen.routeName,
    );
  }
}