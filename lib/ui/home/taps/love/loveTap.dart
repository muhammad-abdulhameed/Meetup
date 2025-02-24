import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/reusableWidgets/customTextFormField.dart';
import 'package:evently/ui/home/taps/love/wishListEvents.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/eventProvider.dart';
import '../../widget/eventWidget.dart';
import '../home/taps/allTap.dart';

class LoveTap extends StatefulWidget {
  const LoveTap({super.key});

  @override
  State<LoveTap> createState() => _LoveTapState();
}

class _LoveTapState extends State<LoveTap> {
late  TextEditingController searchController;
  @override
  void initState() {
    searchController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(padding: EdgeInsets.all(8),
        child: Column(
          children: [
             CustomTextFormField(prefixIcon: ImageManger.searchIcon, hint: "Search For Event", validator: (value){return;}, controller:searchController )
        ,Gap(16)
         , Expanded(
           child:Padding(padding: EdgeInsets.all(16),
               child: WishListEvents())
           ),
          ],
        ),
      ),
    );
  }
}