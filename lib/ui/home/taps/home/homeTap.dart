import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/ui/home/taps/home/taps/allTap.dart';
import 'package:evently/ui/home/taps/home/taps/birthdayTap.dart';
import 'package:evently/ui/home/taps/home/taps/bookTap.dart';
import 'package:evently/ui/home/taps/home/taps/sportTap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/appMangers/imageManger.dart';
import '../../../../core/appMangers/stringsManger.dart';
import '../../../../core/providers/userDataProvider.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  void initState() {
    super.initState();

    // TODO: implement initState


  }
  @override
  Widget build(BuildContext context) {
    UserDataProvider userNAme=Provider.of<UserDataProvider>(context) ;


    var height=MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Column(
          children: [
            Container(height: height*.22,padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorManger.lightSecondary,
               borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight:Radius.circular(24)),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),
                  Text(StringManger.welcomeBack.tr(),style: Theme.of(context).textTheme.bodySmall,),
                  const Gap(8),

                  userNAme.isLoading?const CircularProgressIndicator(color: Colors.white,):
                  Text(userNAme.User?.name?.toUpperCase()??"No Name",style:Theme.of(context).textTheme.titleLarge ,),
                  const Gap(8),
                  Row(children: [
                    SvgPicture.asset(ImageManger.locationIcon),
                    Text("Cairo,Egypt",style: Theme.of(context).textTheme.bodySmall ,),
                     ],),
                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.white,
                          indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(46)
                          ),
                          tabs: [
                            Tab(
                              /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/compass.svg"
                                  ,height: 24,width: 24,
                                  ),
                                  Text(StringManger.all.tr()),

                                ],
                              ),
                            ),
                            Tab(
                              /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/compass.svg"),
                                  Text(StringManger.sport.tr()),

                                ],
                              ),
                            ),
                            Tab(
                              /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/compass.svg"),
                                  Text(StringManger.birthday.tr()),

                                ],
                              ),
                            ),
                            Tab(
                              /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/compass.svg"),
                                  Text(StringManger.book.tr()),

                                ],
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                ],),
            ),
const Gap(16),
          const Expanded(
            child: TabBarView(children: [
              Padding(padding: EdgeInsets.all(16),
                child: AllEvents()
              ),
              Padding(padding: EdgeInsets.all(16),
                  child:SportEvents()
              ),

              Padding(padding: EdgeInsets.all(16),
                  child: BirthdayEvents()
              ),

              Padding(padding: EdgeInsets.all(16),
                  child: BookEvents()
              ),

            /*  ListView.separated(itemBuilder: (
                  context,index)=>EventWidget( ),
                  separatorBuilder: (_,index)=>Gap(8),
                  itemCount: 10),
              ListView.separated(itemBuilder: (
                  context,index)=>EventWidget(),
                  separatorBuilder: (_,index)=>Gap(8),
                  itemCount: 10),
              ListView.separated(itemBuilder: (
                  context,index)=>EventWidget(),
                  separatorBuilder: (_,index)=>Gap(8),
                  itemCount: 10),*/
            ]),
          )

          ],
        ),
      ),
    );
  }
}
