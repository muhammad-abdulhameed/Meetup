import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constants/objects/eventObj.dart';
import 'package:evently/core/constants/objects/userObj.dart';
import 'package:firebase_auth/firebase_auth.dart' as currentUset;

class FirebaseHandler {
  static CollectionReference<User> getUserCollection() {
    var collectionRef =
        FirebaseFirestore.instance.collection("User").withConverter(
              fromFirestore: (snapshot, options) {
                return User.fromFireStore(snapshot.data());
              },
              toFirestore: (value, options) => value.toFireStore(),
            );
    return collectionRef;
  }

  static Future<void> addUser(User user) {
    var doc = getUserCollection().doc(user.id);
    user.favorite = [];
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async {
    var collRef = getUserCollection();
    var docRef = collRef.doc(uid);
    var snapShot = await docRef.get();
    return snapShot.data();
  }

  static CollectionReference<EventObj> getEvenCollection() {
    var collection =
        FirebaseFirestore.instance.collection("Event").withConverter(
              fromFirestore: (snapshot, options) {
                return EventObj.fromFireStore(snapshot.data());
              },
              toFirestore: (value, options) => value.toFireStoe(),
            );
    return collection;
  }

  static Future<void> addEvent(EventObj event) {
    var doc = getEvenCollection().doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventObj?>> getEvent() async {
    var collection = getEvenCollection();
    var snapshot = await collection.get();
    var listEventSnapShot = snapshot.docs;
    List<EventObj?> eventList = listEventSnapShot.map((e) => e.data()).toList();
    return eventList;
  }

  static Future<List<EventObj>> getEventByCategory(String category) async {
    var collection = getEvenCollection().where("category", isEqualTo: category);
    var snapShot = await collection.get();
    var eventList = snapShot.docs;
    return eventList.map((e) => e.data()).toList();
  }

  static Future<void> editEvent(
      {required String id,
      required String title,
      required String eventDesc,
      required String category,
      required Timestamp date,
      required double lat,
      required double lng,
      required String uid}) async {
    var collection = getEvenCollection();
    var doc = collection.doc(id);
    var newObj = await doc.update({
      "title": title,
      "id": id,
      "eventDesc": eventDesc,
      "category": category,
      "date": date,
      "lat": lat,
      "lng": lng,
      "uid": uid
    });
    return newObj;
  }

  static CollectionReference<EventObj> getWishListCollection() {
    var collection = getUserCollection()
        .doc(currentUset.FirebaseAuth.instance.currentUser?.uid)
        .collection("wishList")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              EventObj.fromFireStore(snapshot.data()),
          toFirestore: (value, options) => value.toFireStoe(),
        );
    return collection;
  }

  static Future<void> addToWishList(
    EventObj event,
  ) async {
    var collection = getWishListCollection();
    var doc = collection.doc(event.id).set(event);

    return doc;
  }

  static Stream<List<EventObj>> getEventFromWishList() async* {
    var collection = getWishListCollection();
    var snapShot = await collection.snapshots();


    yield*  snapShot.map((event) => event.docs.map((e) => e.data()).toList());;
  }

  static Future<void> updateUSerFavorite(String uid,List<String> newList)async {
    var collection=getUserCollection();
   return  await collection.doc(uid).update({
      "favorite":newList
    });
  }
  static Future<void> removeFromUSerFavorite(String uid,EventObj event)async {
    var collection=getWishListCollection();
    return  await collection.doc(event.id).delete();
  }
 static Stream<List< EventObj?>> streamGetCollection()async*{
   var collection= getEvenCollection();
  var snapShot = collection.snapshots();

      Stream<List< EventObj?>>listOfStreamObj= snapShot.map((event) => event.docs.map((e) => e.data()).toList())  ;
   yield*  listOfStreamObj ;

   }
   static Future<void> deleteEvent(String eventId)async {
    var collection= getEvenCollection();
    await collection.doc(eventId).delete();

   }
   static Future<bool> signOutFromGoogle() async {
     try {
       await currentUset.FirebaseAuth.instance.signOut();
       return true;
     } on Exception catch (_) {
       return false;
     }
   }
}
