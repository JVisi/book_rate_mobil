import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:book_rate/web/request_login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
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
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context)!.greeting,style: TextStyle(color: CustomColors.textColor),),
            const Spacer(flex: 1,),
            AspectRatio(aspectRatio: SizeConfig.blockSizeVertical,
              child: TextFormField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email,
                errorText: !isEmailOK! && email.text.isNotEmpty?AppLocalizations.of(context)!.lengthWarning:null),
                controller: email,
                style: themeConfig().textTheme.bodyText1,
              ),
            ),
            AspectRatio(
              aspectRatio: SizeConfig.blockSizeVertical,
              child: TextFormField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password,
                errorText: !isPasswordOK! && password.text.isNotEmpty?AppLocalizations.of(context)!.lengthWarning:null),
                controller: password,
                obscureText: true, style: themeConfig().textTheme.bodyText1
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical/4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.saveLogin,style: themeConfig().textTheme.bodyText1),
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
                child: Text(AppLocalizations.of(context)!.loginBtn,style: themeConfig().textTheme.bodyText1),
                onPressed: () {
                  if(isEmailOK! && isPasswordOK!){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => login(null, email.text, password.text, keepLoginData!, true, null)));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.fillCredsWarning),
                      duration: const Duration(milliseconds: 750),));
                  }
                },
              ),
            ),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/registerPage');
            },
              child: Text(AppLocalizations.of(context)!.noAccount_Login,style: themeConfig().textTheme.bodyText1),),
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

  login(BuildContext? foreignContext,String email, String password, bool keepLogin, bool needReloadButton, Widget? onError) {
    return LoadingHandler<User?>(
      future: RequestLogin(email: email,password: password,keepLogin: keepLoginData!).sendRequest,
      succeeding: (User? data){
        AppModel.of(foreignContext??context).setUser(data!);
        return MainPage(name: data.name);
      },
      onError: onError,
      needReloadButton: true,

    );
  }
}

