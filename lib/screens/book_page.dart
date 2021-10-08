import 'package:book_rate/config/core.dart';
import 'package:book_rate/screens/book_tile.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class Books extends StatefulWidget{
    final Library library;

  const Books({Key? key, required this.library}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  late ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        CustomColors.backgroundColor = CustomColors.backgroundColor;
        CustomColors.textColor = CustomColors.textColor;
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
    final bookTiles=widget.library.books.map((book) => bookTile(context, book));

    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount:widget.library.books.length,
                  itemBuilder: (context, index)=> bookTiles.elementAt(index))),
        ],
      ),
    );
  }
}