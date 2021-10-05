import 'package:book_rate/serialized/book/book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rates.g.dart';


@JsonSerializable()
class Rate {
  final int rate;
  final Book book;
  Rate({required this.rate, required this.book});


  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
  Map<String, dynamic> toJson() => _$RateToJson(this);
}
@JsonSerializable()
class Rates {
  final List<Rate> rates;

  Rates({required this.rates});

  factory Rates.fromJson(Map<String, dynamic> json) => _$RatesFromJson(json);
  Map<String, dynamic> toJson() => _$RatesToJson(this);
}
