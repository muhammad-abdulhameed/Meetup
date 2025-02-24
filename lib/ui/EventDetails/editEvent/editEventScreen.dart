import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/constants/firebase/firebaseHandeler.dart';
import 'package:evently/core/constants/objects/eventObj.dart';
import 'package:evently/core/dialogUtils.dart';

import 'package:evently/core/reusableWidgets/customTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EditEvent extends StatefulWidget {
  static String routeName = "EditEvent";

  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late GlobalKey<FormState> formKey;
  late int selectedTap;

  DateTime? mergedDateTime;
  EventObj? editEventModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      editEventModal = ModalRoute.of(context)?.settings.arguments as EventObj;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManger.createEvent),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: DefaultTabController(
            initialIndex: initialTap(),
            length: 3,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * .22,
                    child: TabBarView(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            ImageManger.bookCard,
                            fit: BoxFit.cover,
                          )),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            ImageManger.sportCard,
                            fit: BoxFit.cover,
                          )),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            ImageManger.birthdayCard,
                            fit: BoxFit.cover,
                          )),
                    ]),
                  ),
                  TabBar(
                    onTap: (value) {
                      selectedTap = value;
                    },
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.secondary,
                    indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(46)),
                    tabs: [
                      Tab(
                        /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/book-open.svg"),
                            Text(StringManger.book.tr()),
                          ],
                        ),
                      ),
                      Tab(
                        /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/bike.svg"),
                            Text(StringManger.sport.tr()),
                          ],
                        ),
                      ),
                      Tab(
                        /*text: "all",icon:SvgPicture.asset("assets/images/compass.svg") ,*/
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/cake.svg"),
                            Text(StringManger.birthday.tr()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Gap(8),
                  CustomTextFormField(
                      prefixIcon: ImageManger.titleFieldIcon,
                      hint: "Old Title: ${editEventModal?.title}",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field Shouldn't be empty ";
                        }
                      },
                      controller: titleController),
                  Gap(16),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Gap(8),
                  CustomTextFormField(
                    prefixIcon: "",
                    hint:
                        "Old description: ${editEventModal?.eventDesc}.description",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field Shouldn't be empty ";
                      }
                    },
                    controller: descriptionController,
                    maxLine: 5,
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      Text("Event Date"),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            datePicker();
                          },
                          child: Text(
                              selectedDate == null
                                  ? editEventModal?.date?.toDate().day.toString()??""
                                  : selectedDate.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary)))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined),
                      Text("Event Time"),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            timePicker();
                          },
                          child: Text(
                              selectedTime == null
                                  ? editEventModal?.date?.millisecondsSinceEpoch.toString()??""
                                  : selectedTime.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary)))
                    ],
                  ),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: ColorManger.lightSecondary),
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.secondary),
                            child: Icon(Icons.my_location),
                          ),
                          Expanded(
                              child: Text(
                            "Choose Event Location",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      )),
                  Gap(16),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (selectedDate != null && selectedTime != null) {

                          await editEvent();



                          } else {
                            DialogUtils.showToastMassage(
                                "please select date and time");
                          }
                        }
                      },
                      child: Text(
                        "Add Event",
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  datePicker() async {
    DateTime? temp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    selectedDate = temp;
    setState(() {});
  }

  TimeOfDay? selectedTime;

  timePicker() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {});
  }

  String category() {
    if (selectedTap == 0) {
      return "book";
    } else if (selectedTap == 1) {
      return "sport";
    } else {
      return "birthday";
    }
  }
 Future<void> editEvent()async{
  mergedDateTime = DateTime(selectedDate!.year, selectedDate!.month,
      selectedDate!.day, selectedTime!.hour, selectedTime!.minute);
   var editEvent= await FirebaseHandler.editEvent(
      title: titleController.text,
      eventDesc: descriptionController.text,
      category: editEventModal?.category??"",
      date: Timestamp.fromDate(mergedDateTime!),
      lng: 0,
      lat: 2,
      uid: editEventModal?.uid??"",
      id: editEventModal!.id!


  );
   return editEvent;
}
  createEvent() async {
    mergedDateTime = DateTime(selectedDate!.year, selectedDate!.month,
        selectedDate!.day, selectedTime!.hour, selectedTime!.minute);
    await FirebaseHandler.addEvent(EventObj(
        title: titleController.text,
        eventDesc: descriptionController.text,
        category: category(),
        uid: FirebaseAuth.instance.currentUser?.uid,
        lat: 0,
        lng: 0,
        date: Timestamp.fromDate(mergedDateTime!)));
  }

  int initialTap() {
    if (editEventModal!.category == "book") {
      return 0;
    } else if (editEventModal!.category == "sport") {
      return 1;
    } else {
      return 2;
    }
  }
}
