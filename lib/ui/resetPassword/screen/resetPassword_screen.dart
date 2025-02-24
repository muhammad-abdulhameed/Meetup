import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/dialogUtils.dart';
import 'package:evently/core/reusableWidgets/customElevatedButtom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/regx/regx.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  static String routeName = "ResetPasswordScreen";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String mail = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManger.forgetPassword),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageManger.resetPassword),
              Gap(24),
              FormField(

                key: formKey,
                builder: (field) => TextFormField(
                  initialValue: mail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringManger.emptyError.tr();
                    }
                    if (!RegExp(emailRegex).hasMatch(value)) {
                      return "Email not Valid";
                    }
                  },
                  decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: SvgPicture.asset(ImageManger.mailIcon)),
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 24, minHeight: 24),
                      hintText: "Mail"),
                ),
              ),
              Gap(24),
              CustomElevatedButton(
                  elevetadChild: StringManger.resetPassword, onPressed: () async{
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: mail);
                DialogUtils.showToastMassage("Check your mail");
              })
            ],
          ),
        ),
      ),
    );
  }
}
