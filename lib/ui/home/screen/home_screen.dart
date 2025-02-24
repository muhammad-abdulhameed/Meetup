import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/ui/creatEvent/screen/createEvent_Screen.dart';
import 'package:evently/ui/home/taps/home/homeTap.dart';
import 'package:evently/ui/home/taps/love/loveTap.dart';
import 'package:evently/ui/home/taps/mapTap.dart';
import 'package:evently/ui/home/taps/profile/profileTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/eventProvider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName="HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget>taps=[
    HomeTap(),
    MapTap(),
    LoveTap(),
    ProfileTap()
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(CreateEvent.routeName);
      },child: Icon(Icons.add,color: Colors.white,),shape:StadiumBorder(side: BorderSide(color: Colors.white,width: 5))),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){

          setState(() {
            selectedIndex=index;

          });
        },
currentIndex: selectedIndex,

        items: [

        BottomNavigationBarItem(icon: SvgPicture.asset(ImageManger.homeIcon),label: "Home",activeIcon:SvgPicture.asset(ImageManger.homeSelected) ),
        BottomNavigationBarItem(icon: SvgPicture.asset(ImageManger.mapIcon),label: "Map",activeIcon: SvgPicture.asset(ImageManger.mapSelected)),
        BottomNavigationBarItem(icon: SvgPicture.asset(ImageManger.heartIcon),label: "Love",activeIcon: SvgPicture.asset(ImageManger.heartSelected)),
        BottomNavigationBarItem(icon: SvgPicture.asset(ImageManger.profileIcon),label: "Profile",activeIcon: SvgPicture.asset(ImageManger.profileSelected)),

      ],),
     body:taps[selectedIndex] ,
    );
  }
}
