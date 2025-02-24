import 'package:evently/core/constants/firebase/firebaseHandeler.dart';
import 'package:flutter/material.dart';
import '../constants/objects/eventObj.dart';
import 'package:flutter/foundation.dart';
class EventProvider extends ChangeNotifier{
  List<EventObj?>? event;
  getEvent()async{
     event= await FirebaseHandler.getEvent();
     notifyListeners();

  }
}