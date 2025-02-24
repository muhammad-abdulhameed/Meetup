import 'package:cloud_firestore/cloud_firestore.dart';

class EventObj{
  String? title;
  String? id;
  String? eventDesc;
  String? category;
  Timestamp? date;
  double? lat;
  double? lng;
  String? uid;
  EventObj ({required this.title,required this.uid,this.category,required this.date,required this.eventDesc,required this.lat,required this.lng});
  EventObj.fromFireStore(Map<String,dynamic>?eventMap ) {
    title=eventMap?["title"];
    id=eventMap?["id"];
    eventDesc=eventMap?["eventDesc"];
    category=eventMap?["category"];
    date=eventMap?["date"];
    lat=eventMap?["lat"];
    lng=eventMap?["lng"];
    uid=eventMap?["uid"];
}
Map<String,dynamic> toFireStoe(){
    return {
"title":title,
      "id":id,
"eventDesc":eventDesc,
"category":category,
"date":date,
"lat":lat,
"lng":lng,
"uid":uid
};
}
}