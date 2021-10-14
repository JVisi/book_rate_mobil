import 'package:json_annotation/json_annotation.dart';

part 'average_rating.g.dart';




@JsonSerializable()
class AvgRatings {
  final Map<String,int> ratings;

  AvgRatings({required this.ratings});


  factory AvgRatings.fromJson(Map<String, dynamic> json) => _$AvgRatingsFromJson(json);
  Map<String, dynamic> toJson() => _$AvgRatingsToJson(this);
}
