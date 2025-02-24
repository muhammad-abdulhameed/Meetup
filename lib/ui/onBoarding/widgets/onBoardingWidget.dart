import 'package:evently/ui/onBoarding/dataClass/OnBoardingDataClass.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoardingWidget extends StatelessWidget{
  OnBoardingClass onBoardingClass;
  OnBoardingWidget({required this.onBoardingClass});

  @override
  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(onBoardingClass.image),
          Gap(44),
          Text(onBoardingClass.headTitle,style: Theme.of(context).textTheme.bodyLarge,),
          Gap(44),
          Text(onBoardingClass.bodyTitle),
        ],
      ),
    );
  }
}