import 'dart:convert';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:http/http.dart'as http;

class RequestRegister{
  final String email;
  final String name;
  final String password;
  final bool keepLogin;

  RequestRegister({required this.email, required this.name, required this.password, required this.keepLogin});

  Future<User?> sendRequest() async{
    final  String body=jsonEncode({"user":{"email":email,"name":name,"password":password}});
    final response = await http.post(Uri.parse(WebConfig.url+"/mobile/register"), headers: WebConfig.headers,body: body).timeout(const Duration(seconds: 10));
    try{
      LoginResponse l=LoginResponse.fromJson(jsonDecode(response.body));
      if(keepLogin){
        await saveToPreferences(email, password);
      }
      return l.user;
    }catch(e){
      print(e);
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}