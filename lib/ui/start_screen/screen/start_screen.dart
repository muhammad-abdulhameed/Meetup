import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/reusableWidgets/customAppbar.dart';
import 'package:evently/core/reusableWidgets/customElevatedButtom.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/start_screen/widget/animatedToggleLocal.dart';
import 'package:evently/ui/start_screen/widget/toggleLocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widget/animatedToggleTheme.dart';

class StartScreen extends StatefulWidget {
  static String routeName = "StartScreen";

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.defaultAppBar,
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Image.asset(ImageManger.startScreen),
        Text(StringManger.personalizeYourExp.tr(), style: Theme
            .of(context)
            .textTheme
            .bodyLarge,),
        const Gap(28),
        Text(StringManger.startText, style: Theme
            .of(context)
            .textTheme
            .bodyMedium,).tr(),
        const Gap(28),
        Row(
          children: [
            Expanded(child: Text(StringManger.language.tr(), style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400),))///copy with use if you want to use same theme with some changes
            , /*LocalToggle(),*/ ///our custom toggle
            const AnimatedToggleLocal(),

            ],

            ),
              const Gap(16),
              Row(
                children: [
                  Expanded(child: Text(StringManger.theme.tr(), style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),)),
                  const AnimatedToggleTheme(),


                ],
              )///copy with use if you want to use same theme with some changes
              ,
Gap(16),
              Expanded(child: CustomElevatedButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
              },
                  elevetadChild: StringManger.start.tr()))
          ],
        ),
      ),
    );
  }
}
