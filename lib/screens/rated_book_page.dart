import 'package:book_rate/config/core.dart';
import 'package:book_rate/screens/book_tile.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/rates/rates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class RatedBooks extends StatefulWidget{
    final Rates rates;

  const RatedBooks({Key? key, required this.rates}) : super(key: key);

  @override
  State<RatedBooks> createState() => _RatedBooksState();
}

class _RatedBooksState extends State<RatedBooks> {
  late ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
          CustomColors.backgroundColor = CustomColors.backgroundColor;
          CustomColors.textColor = CustomColors.textColor ;
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
    final ratedBookTiles=widget.rates.rates.map((e) => ratedBookTile(context, e.book,e.rate));

    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount:widget.rates.rates.length,
                  itemBuilder: (context, index)=> ratedBookTiles.elementAt(index))),
        ],
      ),
    );
  }
}