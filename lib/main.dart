import 'package:book_rate/config/loader.dart';
import 'package:flutter/material.dart';
import 'package:book_rate/config/core.dart';
import 'package:book_rate/screens/userAuth/login.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Start(), ///check memory
    );
  }
}
class Start extends StatelessWidget{
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingHandler(future: loadLoginCreds,
        succeeding: (Map<String?,String?> creds){
      if (creds["email"] != null && creds["password"] != null) {
        //killLoginCreds();
        return LoginState().login(creds["email"]!, creds["password"]!,false,false,const LoginScreen());
      }
      return const LoginScreen();
    });
  }

}