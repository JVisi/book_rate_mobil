import 'package:book_rate/serialized/book/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedBook extends StatefulWidget {
  final Book book;

  const DetailedBook({Key? key, required this.book}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedBookState();
}

class DetailedBookState extends State<DetailedBook> {
  int rate = 0;
  ///0-10

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Text(widget.book.name),
          ))
        ],
      ),
    );
  }
}
