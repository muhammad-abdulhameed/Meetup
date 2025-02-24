import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({required this.elevetadChild,required this.onPressed});
   void Function()? onPressed;
String elevetadChild;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        onPressed: onPressed
        , child:Text(elevetadChild.tr()
    ,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorManger.lightPrimary,
        ))
    );
  }
}
