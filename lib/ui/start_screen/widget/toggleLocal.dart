import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/appMangers/colorsManger.dart';
import '../../../core/appMangers/imageManger.dart';

class LocalToggle extends StatefulWidget {
  const LocalToggle({super.key});

  @override
  State<LocalToggle> createState() => _LocalToggleState();
}

class _LocalToggleState extends State<LocalToggle> {
  bool isEnglish=true;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(28),
          border: Border.all(
              color: ColorManger.lightSecondary,
              width: 2
          )
      ),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                isEnglish=true;
              });

            },
            child: CircleAvatar(
              backgroundColor: isEnglish==true?Theme.of(context).colorScheme.secondary:Colors.transparent,
              child: SvgPicture.asset(ImageManger.enIcon,
                height: 30,
                width: 30,
              ),

            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                isEnglish=false;
              });

            },
            child: CircleAvatar(
              backgroundColor: isEnglish==true?Colors.transparent:Theme.of(context).colorScheme.secondary,
              child: SvgPicture.asset(ImageManger.arIcon
                ,height:30 ,
                width: 30,
              ),
            ),
          )
        ],

      ),
    );
  }
}
