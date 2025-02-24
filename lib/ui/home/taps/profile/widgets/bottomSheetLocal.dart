import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomSheetLocal extends StatelessWidget {
  const BottomSheetLocal({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.all(8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(whichLocal(context),style: Theme.of(context).textTheme.bodyLarge,)  ,
              Icon(Icons.check,color: Theme.of(context).colorScheme.secondary,)
            ],

          ),
          Divider(),
          GestureDetector(
            onTap: (){
              context.setLocale(Locale(whichLocal(context)=="Arabic"?"en":"ar"));

            },
            child: Text(
                whichLocal(context)=="Arabic"?"English":"Arabic"

            ),
          )
        ],),
    );
  }
  String whichLocal(BuildContext context){
    if(context.locale.languageCode=="en"){
      return 'English';
    }else{
      return "Arabic";
    }

  }
}
