import 'package:json_annotation/json_annotation.dart';

part 'error_message.g.dart';


@JsonSerializable()
class ErrorMessage {
  final String error;
  ErrorMessage({required this.error});
  factory ErrorMessage.fromJson(Map<String, dynamic> json) => _$ErrorMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
}
