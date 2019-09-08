import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';

import 'generated/i18n.dart';
import 'ui/login/login_screen.dart';

void main() => runApp(DemoApp(null));

//Future<Null> main() async {
//  var store = await createStore();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//      .then((_) {
//    runApp(DemoApp(store));
//  });
//}

class DemoApp extends StatefulWidget {
  final Store<AppState> store;
  static const _appDelegate = S.delegate;
  static const List<LocalizationsDelegate> _materialDelegates = [
    _appDelegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
  final appDescription = "Demo App using the BLoC pattern";

  DemoApp(this.store);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  var _currentLocale = Locale('en');

//  SettingsOptions _options;

  onLocaleChange(Locale l) {
    setState(() {
      _currentLocale = l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        title: widget.appDescription,
        localizationsDelegates: DemoApp._materialDelegates,
        supportedLocales: DemoApp._appDelegate.supportedLocales,
        locale: _currentLocale,
        theme: buildThemeData(),
        home: LoginScreen(onLocaleChange: onLocaleChange));
  }

  ThemeData buildThemeData() {
    return ThemeData(
      backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      fontFamily: 'PTSans',
      textTheme: TextTheme(
          button: TextStyle(
            fontFamily: 'PTSans',
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          headline: TextStyle(fontStyle: FontStyle.normal, fontSize: 30),
          display2: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
          display1: TextStyle(fontStyle: FontStyle.normal, fontSize: 20)),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      ),
      primarySwatch: Colors.blueGrey,
    );
  }
}
