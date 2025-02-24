import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils{
  static showDialogLoading(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(title: Row(
      children: [
        Text("Loading..."),
        CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,)
      ],
    ),) );

  }
  static showDialogMassage({required BuildContext context,
    required String massage,
    required String positiveBtnTitle,
     String? nigativBtnTitle,
  required void Function()? onPstvBtnPressed,
   void Function()? onngtvBtnPressed
  }){
    showDialog(context: context, builder: (context)=>AlertDialog(
      content:Text(massage) ,
      actions: [
        TextButton(onPressed: onPstvBtnPressed, child: Text(positiveBtnTitle)),
        if(nigativBtnTitle!=null)
        TextButton(onPressed: onPstvBtnPressed, child: Text(nigativBtnTitle)),

      ],
    ));
  }
  static showToastMassage(String massage){
    Fluttertoast.showToast(
        msg:massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.black54,
        fontSize: 20.0
    );
  }
}