import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class User {
  final String email;
  final String name;
  User({required this.email, required this.name});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class LoginResponse{
  final User user;
  LoginResponse({required this.user});
  factory LoginResponse.fromJson(Map<String, dynamic> json)=> _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
