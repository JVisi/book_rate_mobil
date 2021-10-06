import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailedBook extends StatefulWidget {
  final Book book;

  const DetailedBook({Key? key, required this.book}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedBookState();
}

class DetailedBookState extends State<DetailedBook> {
  ///0-10
  int rate = 5;

  final List<Icon> stars = List.filled(
      10,
      Icon(
        Icons.star,
        color: Colors.amberAccent,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Center(
                child: Text(widget.book.name),
              )),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: rate,
                      itemBuilder: (context, index) => stars.elementAt(index),
                    )),
                Expanded(
                    flex: 1,
                    child: CustomSliderTheme(
                      Slider(
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
              ],
            ),
          ),
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  onPressed: () async {
                    final response = await RateBook(
                            userId: AppModel.of(context).getUser().id,
                            ISBN: widget.book.ISBN,
                            rate: rate)
                        .sendRequest();
                    if (response!.message != null) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.alertDialogTitle),
                          content: Text(response.message!),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                    else if(response.error!=null){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(response.error!),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Rate this book!"))),
          const Expanded(flex: 2, child: Text(""))
        ],
      ),
    );
  }

  SliderTheme CustomSliderTheme(Slider slider) {
    return SliderTheme(
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
        child: slider);
  }
}
