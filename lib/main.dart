import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';
import 'ui/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static const _appDelegate = S.delegate;
  static const List<LocalizationsDelegate> _materialDelegates = [
    _appDelegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentLocale = Locale('en');

  onLocaleChange(Locale l) {
    setState(() {
      _currentLocale = l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo App using the BLoC pattern',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: MyApp._materialDelegates,
        supportedLocales: MyApp._appDelegate.supportedLocales,
        locale: _currentLocale,
//        localeResolutionCallback: (locale, supportedLocales) {
//          Locale enLocale = Locale('en');
//          for (var supportedLocale in supportedLocales) {
//            if (supportedLocale.languageCode == enLocale.languageCode) {
//              enLocale = supportedLocale;
//            }
////            if (supportedLocale.countryCode == locale.countryCode
////                && supportedLocale.languageCode == locale.languageCode) {
////              return supportedLocale;
////            }
//          }
//          return enLocale;
//        },
        showSemanticsDebugger: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          fontFamily: 'PTSans',
          textTheme: TextTheme(
              headline: TextStyle(fontStyle: FontStyle.normal, fontSize: 30),
              display2: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
              display1: TextStyle(fontStyle: FontStyle.normal, fontSize: 20)),
          buttonColor: Colors.green.shade700,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.green.shade700,
              textTheme: ButtonTextTheme.primary),
          primarySwatch: Colors.green,
        ),
        home: LoginScreen(onLocaleChange: onLocaleChange));
  }
}
