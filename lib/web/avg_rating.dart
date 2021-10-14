import 'dart:convert';

import 'package:book_rate/config/core.dart';
import 'package:book_rate/serialized/averageRatings/average_rating.dart';
import 'package:book_rate/serialized/errorHandling/error_message.dart';
import 'package:book_rate/serialized/message/message.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:http/http.dart'as http;

class Get_AvgRatings{
  final String ISBN;

  Get_AvgRatings({required this.ISBN});

  Future<AvgRatings> sendRequest() async{
    final  String body=jsonEncode({"ISBN":ISBN});
    final response = await http.post(Uri.parse(WebConfig.url+"/mobile/averageRatings"), headers: WebConfig.headers,body: body).timeout(const Duration(seconds: 10));
    try{
      AvgRatings avg=AvgRatings.fromJson(jsonDecode(response.body));
      return avg;
    }catch(e){
      ErrorMessage err=ErrorMessage.fromJson(jsonDecode(response.body));
      return Future.error(err.error);
    }
  }
}