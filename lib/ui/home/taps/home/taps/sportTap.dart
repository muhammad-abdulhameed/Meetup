import 'package:evently/core/constants/firebase/firebaseHandeler.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/appMangers/colorsManger.dart';
import '../../../widget/eventWidget.dart';

class SportEvents extends StatelessWidget {
  const SportEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseHandler.getEventByCategory("sport"),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: ColorManger.lightSecondary,));
        }else if (snapshot.hasError){
          return Text(snapshot.error.toString());
        }else{
          return snapshot.data!.isEmpty?Center(child: Text("No Events",style: TextStyle(color: Colors.black54),)): ListView.separated(itemBuilder: (
              context,index)=>EventWidget(eventObj: snapshot.data?[index]),
              separatorBuilder: (_,index)=>Gap(16),
              itemCount:snapshot.data?.length??0);
        }
      },
    );
  }
}
