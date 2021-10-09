
import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/book_detailed.dart';
import 'package:book_rate/screens/rated_book_detailed.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bookTile(BuildContext context, Book book){
    return GestureDetector(
      child: ListTile(
        title: Text(book.name+",  "+book.languageCode,style: TextStyle(color: CustomColors.textColor)),
        subtitle: Text(book.author,style: TextStyle(color: CustomColors.textColor)),
      ),
      onTap: ()async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedBook(book: book)));
        ///await RateBook(rate: 5, ISBN: book.ISBN, userId: AppModel.of(context).getUser().id).sendRequest();
      },
    );
  }

Widget ratedBookTile(BuildContext context, Book book, int rating){
  return GestureDetector(
    child: ListTile(
      title: Text(book.name+",  "+book.languageCode,style: TextStyle(color: CustomColors.textColor)),
      subtitle: Text(book.author+", rated: "+rating.toString(),style: TextStyle(color: CustomColors.textColor)),
    ),
    onTap: ()async {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedRate(book: book, rating: rating,)));
      ///await RateBook(rate: 5, ISBN: book.ISBN, userId: AppModel.of(context).getUser().id).sendRequest();
    },
  );
}