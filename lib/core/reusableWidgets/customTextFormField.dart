import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key, required this.prefixIcon,required this.hint,required this.validator,required this.controller,this.maxLine=1});
String prefixIcon;
String hint;

TextEditingController controller;
String? Function(String?)? validator;
int maxLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLines: maxLine,

controller: controller,
      validator: validator,
      decoration: InputDecoration(

        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: true,
        prefixIcon:Padding(padding: EdgeInsets.symmetric(horizontal: 16,),
            child: SvgPicture.asset(prefixIcon)),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24,
          minHeight: 24
        ),



        hintText: hint.tr(),

      ),
    );
  }
}
