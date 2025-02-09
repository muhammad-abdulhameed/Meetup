/*
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  Location location =Location();
  String? locationMassage;

  Future <void> getLocation()async{

    bool?  _serviceEnabled=await Location().serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await Location().requestService();
      if(!_serviceEnabled){
        return;
      }


    }
    bool locationPermission=await _getLocationPermession();

}

  _getLocationPermession()async{
    PermissionStatus permissionStatus =await location.hasPermission();
    if(permissionStatus==PermissionStatus.denied){

      locationMassage="We can't access your Location";
     permissionStatus= await location.requestPermission();
      notifyListeners();
      if(permissionStatus==PermissionStatus.granted){
        locationMassage="Now we can access location";
        notifyListeners();
        print("=============================================${permissionStatus}");
        return location.getLocation();
      }else return;

    }
  }

}*/
