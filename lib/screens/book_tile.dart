
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bookTile(BuildContext context, Book book){
    return GestureDetector(
      child: ListTile(
        title: Text(book.name+",  "+book.languageCode),
        subtitle: Text(book.author),
      ),
      onTap: ()async {
        ///await RateBook(rate: 5, ISBN: book.ISBN, userId: AppModel.of(context).getUser().id).sendRequest();
      },
    );
  }