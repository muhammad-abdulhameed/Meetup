import 'package:evently/core/providers/locationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapTap extends StatefulWidget {
   MapTap({super.key});

  @override
  State<MapTap> createState() => _MapTapState();
}

class _MapTapState extends State<MapTap> {

@override
  void initState() {
  super.initState();


  }
  @override
  Widget build(BuildContext context) {
/*  LocationProvider  locationProvider=Provider.of<LocationProvider>(context,);
  locationProvider.getLocation();*/
    return Scaffold(
      body: Center(child: Text(/*locationProvider.locationMassage??*/""),),
    );
  }
}
