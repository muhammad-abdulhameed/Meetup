import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/reusableWidgets/customAppbar.dart';
import 'package:evently/ui/onBoarding/widgets/onBoardingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'dataClass/OnBoardingDataClass.dart';

class OnBoardingScreen extends StatefulWidget {
  static String routeName="OnBoardingScreen";
   OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   int selectedIndex=0;

  List <OnBoardingClass> data=[
    OnBoardingClass(image: ImageManger.firstBoard,headTitle: StringManger.firstHeadTitle,bodyTitle:StringManger.firstBodyTitle ),
    OnBoardingClass(image: ImageManger.secondBoard, headTitle: StringManger.secondHeadTitle, bodyTitle:  StringManger.secondBodyTitle),
    OnBoardingClass(image: ImageManger.thBoard, headTitle:  StringManger.thHeadTitle, bodyTitle:  StringManger.thBodyTitle)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.defaultAppBar,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(itemCount: data.length,onPageChanged: (int){
              selectedIndex=int;
              setState(() {

              });
            },
              itemBuilder: (context, index) {
              return OnBoardingWidget(onBoardingClass: data[index]);
            },),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                  child: SvgPicture.asset(ImageManger.leftArrow)),
              AnimatedSmoothIndicator(
                activeIndex: selectedIndex,
                count: data.length,
                effect: const ExpandingDotsEffect(),
              ),
              GestureDetector(
                  child: SvgPicture.asset(ImageManger.rightArrow)),
            ],)
        ],
      ),
    );
  }
}
