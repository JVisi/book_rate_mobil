import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/rate_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shake/shake.dart';

class DetailedBook extends StatefulWidget {
  final Book book;

  const DetailedBook({Key? key, required this.book}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedBookState();
}

class DetailedBookState extends State<DetailedBook> {
  ///0-10
  int rate = 5;
  bool isLoading = false;
  late ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        CustomColors.backgroundColor = CustomColors.backgroundColor;
        CustomColors.textColor = CustomColors.textColor ;
        CustomColors.interact = CustomColors.interact;
        CustomColors.starColor = CustomColors.starColor;
      });

    });
  }
  @override
  void dispose(){
    detector.stopListening();
    super.dispose();
  }

  final List<Icon> stars = List.filled(
      10,
      Icon(
        Icons.star,
        color: CustomColors.starColor,
      ));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child: Center(
                child: Text(widget.book.name, style: TextStyle(color: CustomColors.textColor)),
              )),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(SizeConfig.screenWidth)),
                      primary: CustomColors.interact),
                  onPressed: () {
                    ///PUT IT ON WISHLIST HERE
                  },
                  child: Text(AppLocalizations.of(context)!.wishlistBook_Btn))),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                    child: isLoading
                        ? SpinKitWave(
                            color: Colors.blue,
                            size: SizeConfig.blockSizeVertical * 10,
                          )
                        : Text("")),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: rate,
                      itemBuilder: (context, index) => stars.elementAt(index),
                    )),
                Expanded(
                    flex: 2,
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
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.interact,
                  ),
                  onPressed: () async {
                    if (isLoading == false) {
                      setState(() {
                        isLoading = true;
                      });
                      await loadRating();
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child:
                      Text(AppLocalizations.of(context)!.alertDialog_Ratebtn))),
          const Expanded(flex: 2, child: Text(""))
        ],
      ),
    );
  }

  void showResultDialog(String title, String desc) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> loadRating() async {
    final response = await RateBook(
            userId: AppModel.of(context).getUser().id,
            ISBN: widget.book.ISBN,
            rate: rate)
        .sendRequest();

    response!.message != null
        ? showResultDialog(AppLocalizations.of(context)!.alertDialog_OK,
            AppLocalizations.of(context)!.alertDialog_Rated)
        : showResultDialog(AppLocalizations.of(context)!.alertDialog_Error,
            AppLocalizations.of(context)!.alertDialog_AlreadyRated);
  }

  SliderTheme CustomSliderTheme(Slider slider) {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: CustomColors.interact,
          inactiveTrackColor: Colors.white,
          trackShape: const RoundedRectSliderTrackShape(),
          trackHeight: 4.0,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
          thumbColor: CustomColors.interact = CustomColors.interact,
          overlayColor: Colors.red.withAlpha(32),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
          tickMarkShape: const RoundSliderTickMarkShape(),
          activeTickMarkColor: CustomColors.interact ,
          inactiveTickMarkColor: Colors.white,
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: CustomColors.interact,
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        child: slider);
  }
}

/*
if (isButtonDisabled) {
                      ///Well, do nothing
                    } else {
                      setState(() {
                        isButtonDisabled = true;
                      });
                      final response = await RateBook(
                              userId: AppModel.of(context).getUser().id,
                              ISBN: widget.book.ISBN,
                              rate: rate)
                          .sendRequest();

                      if (response!.message != null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.alertDialog_OK),
                            content: Text(AppLocalizations.of(context)!
                                .alertDialog_Rated),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  setState(() {
                                    isButtonDisabled = false;
                                  });
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else if (response.error != null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(AppLocalizations.of(context)!
                                .alertDialog_Error),
                            content: Text(AppLocalizations.of(context)!
                                .alertDialog_AlreadyRated),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  setState(() {
                                    isButtonDisabled = false;
                                  });
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }

*/
