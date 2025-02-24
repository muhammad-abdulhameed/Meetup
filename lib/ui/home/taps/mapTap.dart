import 'package:evently/core/providers/locationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapTap extends StatefulWidget {
   MapTap({super.key});

  @override
  State<MapTap> createState() => _MapTapState();
}

class _MapTapState extends State<MapTap> {
late LocationProvider locationProvider;
@override
  void initState() {
  super.initState();
  locationProvider=Provider.of<LocationProvider>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
