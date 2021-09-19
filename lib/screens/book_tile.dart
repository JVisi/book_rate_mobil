
import 'package:book_rate/serialized/book/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bookTile(Book book){
    return ListTile(
      title: Text(book.name+",  "+book.languageCode),
      subtitle: Text(book.author),
    );
  }