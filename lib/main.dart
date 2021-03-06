import 'package:book_rate/config/loader.dart';
import 'package:flutter/material.dart';
import 'package:book_rate/config/core.dart';
import 'package:book_rate/screens/userAuth/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/model.dart';


void main() {
  final appModel = AppModel();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      value) =>
      runApp(ScopedModel<AppModel>(model: appModel, child: const MyApp())));


  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('hu', ''), // Spanish, no country code
      ],
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Start(),

      ///check memory
    );
  }
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingHandler(future: loadLoginCreds,
        succeeding: (Map<String?, String?> creds) {
          if (creds["email"] != null && creds["password"] != null) {
            //killLoginCreds();
            return LoginState().login(
                context, creds["email"]!, creds["password"]!, false, false,
                const LoginScreen());
          }
          return const LoginScreen();
        });
  }

}