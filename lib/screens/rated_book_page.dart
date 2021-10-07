import 'package:book_rate/screens/book_tile.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/rates/rates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatedBooks extends StatelessWidget{
    final Rates rates;

  const RatedBooks({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratedBookTiles=rates.rates.map((e) => ratedBookTile(context, e.book,e.rate));

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount:rates.rates.length,
                  itemBuilder: (context, index)=> ratedBookTiles.elementAt(index))),
        ],
      ),
    );
  }
}