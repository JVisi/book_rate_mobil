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
  ///0-10
  int rate = 5;

  final List<Icon> stars=List.filled(10,Icon(Icons.star));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Text(widget.book.name),
          )),

          Expanded(
              child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: const RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: rate.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: rate.toString(),
              onChanged: (double value) {
                setState(() {
                  rate = value.toInt();
                });
              },
            ),
          )),
          Expanded(
              child: ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: rate,
                itemBuilder: (context, index) => stars.elementAt(index),
              )),
        ],
      ),
    );
  }
}
