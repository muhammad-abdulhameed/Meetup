import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/appMangers/imageManger.dart';

class AnimatedToggleLocal extends StatefulWidget {
  const AnimatedToggleLocal({super.key});

  @override
  State<AnimatedToggleLocal> createState() => _AnimatedToggleLocalState();
}

class _AnimatedToggleLocalState extends State<AnimatedToggleLocal> {
  String currentValue="en";
  @override
  void initState() {

    // TODO: implement initState
    super.initState();/*
    ///
    *here we used WidgetsBinding.instance.addPostFrameCallback((timeStamp) {}  to solve problem that's initState create before context
    *to binding this logic that's depends on context till first frame build run (build function that's have context run  )
    *after ui or widget tree fully build call this call back function (context created)
    *summarize:it's binding action till widget build
    */
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      if(context.locale==Locale("ar")){///that's for toggle be foucsed on saved locale
        currentValue="ar";
      }else{
        currentValue="en";
      }
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<String>.rolling(
      iconList: [
        SvgPicture.asset(ImageManger.enIcon
          ,height:24 ,
          width: 24,),
        SvgPicture.asset(ImageManger.arIcon
          ,height:24 ,
          width: 24,
        ),

      ],
      current: currentValue,
      values: ["en",'ar']///list of values to refere to every item on(iconList)
      ,onChanged: (value) {
      setState(() {
        currentValue=value;
        if(value=="ar"){
          context.setLocale(Locale("ar"));///set locale fun to change lang
        }else{
          context.setLocale(Locale("en"));
        }
      });


    },
      iconOpacity: 1,
    );
  }
}
