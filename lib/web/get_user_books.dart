import 'dart:convert';
import 'dart:io';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/rates/rates.dart';
import 'package:book_rate/serialized/wishList/wish_list.dart';
import 'package:http/http.dart'as http;

class GetRatesOfUser{
  final String userId;
  GetRatesOfUser(this.userId);

  Future<Rates> sendRequest() async{

    final headers = {
      ...WebConfig.headers,
    };

    final  String body=jsonEncode({"id":userId});
    final response = await http.post(Uri.parse(WebConfig.url+"/mobile/rates"),body:body,headers: headers);
    try{
      if(response.body!="[]") {
        List temp=jsonDecode(response.body);
        List<Rate> items =temp.map((e) => Rate.fromJson(e)).toList();

        return Rates(rates: items);
      }
      return Rates(rates: []);
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}