import 'package:book_rate/config/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget menu_tile<T>(BuildContext context, Future<T> Function() function, String title, IconData? icon) {
  return GestureDetector(
    child: SizedBox(
      width: SizeConfig.screenHeight/4,
      height: SizeConfig.screenHeight/4,
      child: Container(
        child:Card(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
              child: Icon(icon ?? Icons.book,color: Colors.white,size: SizeConfig.blockSizeVertical*8),
            ),
            TextButton(
              onPressed: () {  },
              child: Text(title,style:TextStyle(color: Colors.white70,fontSize: SizeConfig.blockSizeVertical * 2.5) ,),
            ),
          ],
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20.0,
            ),
          ],
        ),
      ),
    ),
    onTap: () async{
      await function();
    },
  );
}