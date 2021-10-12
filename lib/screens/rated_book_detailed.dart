import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shake/shake.dart';

class DetailedRate extends StatefulWidget {
  final Book book;
  final int rating;

  const DetailedRate({Key? key, required this.book, required this.rating}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedRateState();
}

class DetailedRateState extends State<DetailedRate> {
  late ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        CustomColors.backgroundColor = CustomColors.backgroundColor;
        CustomColors.textColor = CustomColors.textColor ;
        CustomColors.starColor = CustomColors.starColor;
      });

    });
  }
  @override
  void dispose(){
    detector.stopListening();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Center(
                child: Text(widget.book.name + widget.rating.toString(), style: TextStyle(color: CustomColors.textColor)),
              )),
        ],
      ),
    );
  }
}
