import 'dart:convert';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/message/message.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:http/http.dart'as http;

class BarcodeSearch{
  final String barcode;

  BarcodeSearch({required this.barcode});

  Future<Message?> sendRequest() async{
    final  String body=jsonEncode({"keyWord":barcode});
    final response = await http.post(Uri.parse(WebConfig.url+"/searchBook"), headers: WebConfig.headers,body: body).timeout(const Duration(seconds: 10));
    try{
      Message l=Message.fromJson(jsonDecode(response.body));
      return l;
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}