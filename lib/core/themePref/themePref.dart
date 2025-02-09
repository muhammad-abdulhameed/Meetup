import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper{
static late SharedPreferences prefs;
static init()async{
 prefs= await SharedPreferences.getInstance();
}
setTheme(){
  prefs.setBool("theme", true);
}
getTheme(){
  prefs.get("theme");
}
}
