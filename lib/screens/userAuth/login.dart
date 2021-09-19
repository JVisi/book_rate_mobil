import 'package:book_rate/screens/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:book_rate/web/request_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool? keepLoginData = false;

  bool? isEmailOK=false;
  bool? isPasswordOK=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(checkEmail);
    password.addListener(checkPassword);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            const Spacer(flex: 1,),
            AspectRatio(aspectRatio: SizeConfig.blockSizeVertical,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Email address",
                errorText: !isEmailOK! && email.text.isNotEmpty?"Must be at least 3 characters":null),
                controller: email,
                style: themeConfig().textTheme.bodyText1,
              ),
            ),
            AspectRatio(
              aspectRatio: SizeConfig.blockSizeVertical,
              child: TextFormField(
                decoration: InputDecoration(hintText: "password",
                errorText: !isPasswordOK! && password.text.isNotEmpty?"Must be at least 3 characters":null),
                controller: password,
                obscureText: true, style: themeConfig().textTheme.bodyText1
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical/4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Save login data",style: themeConfig().textTheme.bodyText1),
                  Checkbox(
                      value: keepLoginData,
                      onChanged: (bool? _val) {
                        setState(() {
                          keepLoginData = _val!;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical*2),
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical*2,horizontal: SizeConfig.blockSizeHorizontal*10)
              ),
                child: Text("Login",style: themeConfig().textTheme.bodyText1),
                onPressed: () {
                  if(isEmailOK! && isPasswordOK!){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => login(email.text, password.text, keepLoginData!, true, null)));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill all the stuff"),
                      duration: Duration(milliseconds: 750),));
                  }
                },
              ),
            ),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/registerPage');
            },
              child: Text("Don't have an account? Create one here!",style: themeConfig().textTheme.bodyText1),),
            const Spacer(flex:1)
          ],
        ),
      ),
    );
  }

  void checkEmail(){
    setState(() {
      isEmailOK= email.text.length>2;
    });
  }

  void checkPassword() {
    setState(() {
      isPasswordOK= password.text.length>2;
    });
  }

  login(String email, String password, bool keepLogin, bool needReloadButton, Widget? onError) {
    return LoadingHandler<User?>(
      future: RequestLogin(email: email,password: password,keepLogin: keepLoginData!).sendRequest,
      succeeding: (User? data){
        return MainPage(name: data!.name);
      },
      onError: onError,
      needReloadButton: true,

    );
    ///if response body ok
  }
}

