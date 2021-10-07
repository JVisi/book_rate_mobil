import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailedRate extends StatefulWidget {
  final Book book;
  final int rating;

  const DetailedRate({Key? key, required this.book, required this.rating}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedRateState();
}

class DetailedRateState extends State<DetailedRate> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Center(
                child: Text(widget.book.name + widget.rating.toString()),
              )),
        ],
      ),
    );
  }
}
