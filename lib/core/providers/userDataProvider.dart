import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../constants/firebase/firebaseHandeler.dart';
import '../constants/objects/userObj.dart'as MyUser;



class UserDataProvider extends ChangeNotifier{
  MyUser.User? User;
  bool isLoading=false;

  changeUserData()async {
    isLoading=true;
    notifyListeners();
    User= await FirebaseHandler.getUser(FirebaseAuth.instance.currentUser!.uid);
    isLoading=false;
    notifyListeners();

  }

}