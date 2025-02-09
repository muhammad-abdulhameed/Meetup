import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/providers/themeProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/appMangers/imageManger.dart';


class AnimatedToggleTheme extends StatefulWidget {
  const AnimatedToggleTheme({super.key});

  @override
  State<AnimatedToggleTheme> createState() => _AnimatedToggleThemeState();
}

class _AnimatedToggleThemeState extends State<AnimatedToggleTheme> {
  String currentValue="light";
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

      if(currentValue=="light"){///that's for toggle be foucsed on saved locale
        currentValue="light";
      }else{
        currentValue="dark";
      }
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider= Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<String>.rolling(
      iconList: [
        SvgPicture.asset(ImageManger.sun
          ,height:24 ,
          width: 24,
        colorFilter: ColorFilter.mode(currentValue=="light"?
            Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary,
            BlendMode.srcIn),
        ),
        SvgPicture.asset(ImageManger.moon
          ,height:24 ,
          width: 24,
          colorFilter: ColorFilter.mode(currentValue=="light"?
          Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
        ),

      ],
      current: currentValue,
      values: ["light",'dark']///list of values to refere to every item on(iconList)
      ,onChanged: (value) {
      setState(() {
        if(value=="light"){
          themeProvider.changeThemeMode(ThemeMode.light);

        }else{
          themeProvider.changeThemeMode(ThemeMode.dark);
        }
        currentValue=value;

      });


    },
      iconOpacity: 1,
    );
  }
}
