// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
      rate: json['rate'] as int,
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'rate': instance.rate,
      'book': instance.book,
    };

Rates _$RatesFromJson(Map<String, dynamic> json) => Rates(
      rates: (json['rates'] as List<dynamic>)
          .map((e) => Rate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RatesToJson(Rates instance) => <String, dynamic>{
      'rates': instance.rates,
    };
