
import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/book_detailed.dart';
import 'package:book_rate/screens/rated_book_detailed.dart';
import 'package:book_rate/serialized/averageRatings/average_rating.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/avg_rating.dart';
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  LoadingHandler(
        future: Get_AvgRatings(ISBN: book.ISBN).sendRequest,
        succeeding: (AvgRatings avg) {
          //List<Book> l = wl.wishlist.map((e) => e.book).toList();
          return DetailedRate(book: book,rating:rating,averageRatings:avg.ratings);
        },
      )));//DetailedRate(book: book, rating: rating,)));
      ///await RateBook(rate: 5, ISBN: book.ISBN, userId: AppModel.of(context).getUser().id).sendRequest();
    },
  );
}

/*
Future<void> loadBooks() async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoadingHandler(
                future: GetAllBooks().sendRequest,
                succeeding: (Library wl) {
                  //List<Book> l = wl.wishlist.map((e) => e.book).toList();
                  return Books(library: wl);
                },
              )));
}*/