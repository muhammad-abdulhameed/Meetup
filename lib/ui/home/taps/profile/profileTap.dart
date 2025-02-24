

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/providers/themeProvider.dart';
import 'package:evently/core/providers/userDataProvider.dart';
import 'package:evently/ui/home/taps/profile/widgets/bottomSheetLocal.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/appMangers/colorsManger.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    UserDataProvider userDataProvider=Provider.of<UserDataProvider>(context);
    var height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: height*.22,padding: EdgeInsets.all(16),
            decoration: BoxDecoration(

            color: ColorManger.lightSecondary,
            borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(54))
          ),
            child:Row(
              children: [
                Container(
                  height: 124,
                 width: 124,
                 decoration:BoxDecoration(color: Colors.white,
                     borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(0),bottomStart: Radius.circular(1000),topEnd: Radius.circular(1000),bottomEnd: Radius.circular(1000)
                 )) ,
                  child:Icon(Icons.person,color: Colors.grey,size: 100,),),
                Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      userDataProvider.isLoading?  CircularProgressIndicator():
                      Text(userDataProvider.User?.name??"No name",style: Theme.of(context).textTheme.titleLarge,),
                      Text(FirebaseAuth.instance.currentUser?.email??"".toString(),style: Theme.of(context).textTheme.bodySmall ,),
                    ],
                  ),
                ),
              ],
            ) ,
          ),
          Expanded(
            child: Column(
              children: [
                Gap(16),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(context: context, builder:(_) =>BottomSheetLocal());
                  },
                  child: Container( margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary
                        )


                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(context.locale.languageCode=="ar"?"العربية":"English",style: Theme.of(context).textTheme.bodyLarge,)),
                        SvgPicture.asset(ImageManger.downListIcon)
                      ],
                    ),),
                ),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(context: context, builder:(_) =>Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(provider.themeMode==ThemeMode.light?"Light":"Dark",style: Theme.of(context).textTheme.bodyLarge)),
                              Icon(Icons.check,color: Theme.of(context).colorScheme.secondary,)
                            ],
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: (){
                              if(provider.themeMode==ThemeMode.light){
                                provider.changeThemeMode(ThemeMode.dark);
                              }else{
                                provider.changeThemeMode(ThemeMode.light);
                              }

                            },
                            child: Text(
                                provider.themeMode==ThemeMode.light?"Dark":"Light"

                            ),
                          )
                        ],
                      ),
                    ));
                  },
                  child: Container( margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary
                        )


                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(provider.themeMode==ThemeMode.light?"Light":"Dark",style: Theme.of(context).textTheme.bodyLarge,)),
                        SvgPicture.asset(ImageManger.downListIcon)
                      ],
                    ),),
                ),


              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
            child: ElevatedButton(
              style: ElevatedButtonTheme.of(context).style?.copyWith(backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
                setState(() {

                });
            }, child: Row(
              children: [
                Icon(Icons.logout),
                Text("Log Out"),
              ],
            ),),
          )
        ],
      ),
    );
  }


}