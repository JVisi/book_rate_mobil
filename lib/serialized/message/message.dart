import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';


@JsonSerializable()
class Message {
  final String? message;
  final String? error;
  Message({this.message, this.error});
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
