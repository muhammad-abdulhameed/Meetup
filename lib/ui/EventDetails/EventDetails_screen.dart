

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/constants/firebase/firebaseHandeler.dart';
import 'package:evently/core/constants/objects/eventObj.dart';


import 'package:evently/core/reusableWidgets/customTextFormField.dart';
import 'package:evently/ui/EventDetails/editEvent/editEventScreen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  static String routeName = "EventDetailsScreen";

  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {


  EventObj? eventModal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventModal=ModalRoute.of(context)?.settings.arguments as EventObj ;
      setState(() {

      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
        actions: [
          Visibility(visible: eventModal?.uid==FirebaseAuth.instance.currentUser?.uid,

              child: Row(children: [
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(EditEvent.routeName ,arguments: eventModal);
              },
                child: SvgPicture.asset(ImageManger.editIcon)),
            Gap(8),
            InkWell(onTap: ()async{
             await FirebaseHandler .deleteEvent(eventModal?.id??"");
             Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
                child: SvgPicture.asset(ImageManger.deleteIcon)),
          ],))

        ],
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(alignment: Alignment.center,
                  height: height * .22,
                  child: ClipRRect(  borderRadius: BorderRadius.circular(8),
                      child: Image.asset(categoryImage())),
                ),

                Gap(16),

                FilledButton(
                    style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorManger.lightSecondary),
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary),
                          child: Icon(Icons.calendar_month_outlined),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.yMMMd()
                                    .format(eventModal!.date?.toDate() ?? DateTime(2025)),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                DateFormat.Hm()
                                    .format(eventModal!.date?.toDate() ?? DateTime(2025))
                                    ,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),

                      ],
                    )),
Gap(16),
                FilledButton(
                    style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorManger.lightSecondary),
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary),
                          child: Icon(Icons.my_location),
                        ),
                        Expanded(
                            child: Text(
                              "Choose Event Location",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge,
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                        ),
                      ],
                    )),
                Gap(16),
                Text(eventModal?.eventDesc??"")


              ],
            ),
          ),
        ),
      ),
    );
  }


  String categoryImage() {
    if (eventModal?.category == "book") {
      return ImageManger.bookCard;
    } else if (eventModal?.category == "sport") {
      return ImageManger.sportCard;
    } else {
      return ImageManger.birthdayCard;
    }
  }
}
