import 'package:book_rate/screens/book_tile.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Books extends StatelessWidget{
    final Library library;

  const Books({Key? key, required this.library}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookTiles=library.books.map((book) => bookTile(context, book));

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount:library.books.length,
                  itemBuilder: (context, index)=> bookTiles.elementAt(index))),
        ],
      ),
    );
  }
}