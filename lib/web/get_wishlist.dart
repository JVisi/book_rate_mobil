import 'dart:convert';
import 'dart:io';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:http/http.dart'as http;

class GetWishlist{
  final String userId;
  GetWishlist(this.userId);

  Future<Library> sendRequest() async{

    final headers = {
      ...WebConfig.headers,
    };

    final  String body=jsonEncode({"id":userId});
    final response = await http.post(Uri.parse(WebConfig.url+"/mobile/wishlisted"),body:body,headers: headers);
    try{
      if(response.body!="[]") {
        Library l=Library.fromJson(jsonDecode(response.body));
        return l;
      }
      return Library(books: <Book>[]);
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}