import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/constants/firebase/firebaseHandeler.dart';
import 'package:evently/core/providers/eventProvider.dart';
import 'package:evently/core/providers/userDataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../core/constants/objects/eventObj.dart';

class EventWidget extends StatefulWidget {
  EventWidget({super.key, required this.eventObj});

  EventObj? eventObj;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
UserDataProvider userData=Provider.of<UserDataProvider>(context);
List<String>favoriteList =userData.User?.favorite??[];
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .25,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: AssetImage(
              categoryImage(),
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.d()
                      .format(widget.eventObj!.date?.toDate() ?? DateTime(2025)),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                    DateFormat.MMM()
                        .format(widget.eventObj!.date?.toDate() ?? DateTime(2025)),
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Text(widget.eventObj!.title!)),

                 GestureDetector(
                   onTap: ()async{

                     if(userData.User!.favorite!.contains(widget.eventObj!.id)){
                       userData.User!.favorite!.remove(widget.eventObj?.id??"");
                      await FirebaseHandler.removeFromUSerFavorite(userData.User!.id!,widget.eventObj!);
                        FirebaseHandler.updateUSerFavorite(FirebaseAuth.instance.currentUser!.uid, favoriteList);
                     }else {
                       userData.User!.favorite!.add(widget.eventObj?.id??"");
                        FirebaseHandler.updateUSerFavorite(FirebaseAuth.instance.currentUser!.uid, favoriteList);
                      await FirebaseHandler.addToWishList(widget.eventObj!);
                     }

setState(() {

});
                   },
                   child: SvgPicture.asset(
                     favoriteList.contains(widget.eventObj?.id)?
                     ImageManger.loveIcon:ImageManger.heartIcon
                ),
                 )
              ],
            ),
          )
        ],
      ),
    );
  }

  String categoryImage() {
    if (widget.eventObj!.category == "book") {
      return ImageManger.bookCard;
    } else if (widget.eventObj!.category == "sport") {
      return ImageManger.sportCard;
    } else {
      return ImageManger.birthdayCard;
    }
  }
}
