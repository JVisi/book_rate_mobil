import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/main_page.dart';
import 'package:book_rate/web/request_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/serialized/user/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  bool? keepLoginData = false;

  bool? isEmailOK=false;
  bool? isNameOK=false;
  bool? isPasswordOK=false;
  bool? doPasswordsMatch=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(checkForms);
    name.addListener(checkForms);
    password.addListener(checkForms);
    password2.addListener(checkForms);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical/4),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ScrollConfiguration(behavior: ListViewWithoutGlowEffect(),
                  child: ListView(children: [
                    AspectRatio(aspectRatio: SizeConfig.blockSizeVertical,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email,hintStyle: TextStyle(color:CustomColors.textColor),
                            errorText: !isEmailOK! && email.text.isNotEmpty?AppLocalizations.of(context)!.lengthWarning:null),
                        controller: email,
                        style: themeConfig().textTheme.bodyText1,
                      ),
                    ),
                    AspectRatio(aspectRatio: SizeConfig.blockSizeVertical,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.username,hintStyle: TextStyle(color:CustomColors.textColor),
                            errorText: !isNameOK! && name.text.isNotEmpty?AppLocalizations.of(context)!.lengthWarning:null),
                        controller: name,
                        style: themeConfig().textTheme.bodyText1,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: SizeConfig.blockSizeVertical,
                      child: TextFormField(
                          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password,hintStyle: TextStyle(color:CustomColors.textColor),
                              errorText: !isPasswordOK! && password.text.isNotEmpty?AppLocalizations.of(context)!.lengthWarning:null),
                          controller: password,
                          obscureText: true, style: themeConfig().textTheme.bodyText1
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: SizeConfig.blockSizeVertical,
                      child: TextFormField(
                          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.passwordAgain,hintStyle: TextStyle(color:CustomColors.textColor),
                              errorText: !doPasswordsMatch! && password.text.isNotEmpty?AppLocalizations.of(context)!.passwordMatch:null),
                          controller: password2,
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
                            checkColor: CustomColors.interact,
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

                      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*2),
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrangeAccent,
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical*2,horizontal: SizeConfig.blockSizeHorizontal*10)
                      ),
                        child: Text(AppLocalizations.of(context)!.regBtn,style: themeConfig().textTheme.bodyText1),
                        onPressed: () {
                          if(isEmailOK! && isPasswordOK! && isNameOK! && doPasswordsMatch! ){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register(email.text,name.text, password.text, keepLoginData!, true, null)));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.fillCredsWarning),
                              duration: const Duration(milliseconds: 750),));
                          }
                        },
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text(AppLocalizations.of(context)!.noAccount_Reg,
                          style: themeConfig().textTheme.bodyText1),),
                  ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkForms(){
    setState(() {
      isEmailOK= email.text.length>2;
      isPasswordOK= password.text.length>2;
      doPasswordsMatch = password.text==password2.text;
      isNameOK=name.text.length>2;
    });
  }

  void checkPassword() {
    setState(() {
      isPasswordOK= password.text.length>2;
      doPasswordsMatch = password.text==password2.text;
    });
  }

  register(String email, String name, String password, bool keepLogin, bool needReloadButton, Widget? onError) {
    return LoadingHandler<User?>(
      future: RequestRegister(email: email,name:name,password: password,keepLogin: keepLoginData!).sendRequest,
      succeeding: (User? data){
        AppModel.of(context).setUser(data!);
        return MainPage(name: data.name);
      },
      onError: onError,
      needReloadButton: true,

    );
    ///if response body ok
  }
}

