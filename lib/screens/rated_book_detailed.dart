import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shake/shake.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailedRate extends StatefulWidget {
  final Book book;
  final int rating;
  final Map<String, int> averageRatings;

  const DetailedRate({
    Key? key,
    required this.book,
    required this.rating,
    required this.averageRatings,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailedRateState();
}

class DetailedRateState extends State<DetailedRate> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        CustomColors.backgroundColor = CustomColors.backgroundColor;
        CustomColors.textColor = CustomColors.textColor;
        CustomColors.starColor = CustomColors.starColor;
      });
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<RatingAmount> data = [];
    widget.averageRatings.forEach((key, value) {
      data.add(RatingAmount(key, value));
    });

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text(widget.book.name +", "+ widget.rating.toString(),
                            style: TextStyle(color: CustomColors.textColor)),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfCartesianChart(
                            palette: [CustomColors.textColor],
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: AppLocalizations.of(context)!.given_stars,textStyle: TextStyle(color: CustomColors.textColor)),
                            legend: Legend(isVisible: false),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                numberFormat: NumberFormat.compact()),
                            series: _getDefaultBarSeries(data),
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )),
                    ),
                    Expanded(flex: 1, child: Text(""))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  List<ColumnSeries<RatingAmount, String>> _getDefaultBarSeries(
      List<RatingAmount> chartData) {
    return <ColumnSeries<RatingAmount, String>>[
      ColumnSeries<RatingAmount, String>(
          dataSource: chartData,
          xValueMapper: (RatingAmount r, _) => r.star+" "+AppLocalizations.of(context)!.star_label,
          yValueMapper: (RatingAmount r, _) => r.amount,
          name: 'stars'),
    ];
  }
}

class RatingAmount {
  final String star;
  final int amount;

  RatingAmount(this.star, this.amount);
}
