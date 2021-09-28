import 'dart:convert';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:http/http.dart'as http;

class RequestLogin{
  final String email;
  final String password;
  final bool keepLogin;

  RequestLogin({required this.email, required this.password, required this.keepLogin});

  Future<User?> sendRequest() async{
    final  String body=jsonEncode({"user":{"email":email,"password":password}});
    final response = await http.post(Uri.parse(WebConfig.url+"/mobile/login"), headers: WebConfig.headers,body: body).timeout(const Duration(seconds: 10));
    try{
      LoginResponse l=LoginResponse.fromJson(jsonDecode(response.body));
      if(keepLogin){
        await saveToPreferences(email, password);
      }
      return l.user;
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}