import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  String? locationMassage;
  Location location=Location();
 late bool _serviceEnabled;
 late PermissionStatus _permissionGranted;
 late LocationData _locationData;
   Future getLocation()async {
  locationMassage="check Serves Enable";
  _serviceEnabled=await location.serviceEnabled();
  if(!_serviceEnabled){
    locationMassage="Please Enable Location ";
    _serviceEnabled=await location.requestService();
    if(!_serviceEnabled){
      notifyListeners();
      return ;
    }
  }

  _permissionGranted=await location.hasPermission();
  if(_permissionGranted==PermissionStatus.denied){
    locationMassage="sorry you cant use location serves";
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      notifyListeners();
      return;
    }
  }
  _locationData=await location.getLocation();
 notifyListeners();
  }


}