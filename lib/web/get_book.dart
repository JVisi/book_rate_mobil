import 'dart:convert';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:http/http.dart'as http;

class GetAllBooks{
  
  Future<Library> sendRequest() async{
    final response = await http.get(Uri.parse(WebConfig.url+"/getAllBooks"),headers: WebConfig.headers);
    try{
      Library l=Library.fromJson(jsonDecode(response.body));
      return l;
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}