import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'generated/i18n.dart';
import 'ui/login/login_screen.dart';

//void main() => runApp(DemoApp(null));

Future<Null> main() async {
  var store = await createStore();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(DemoApp(store));
  });
}

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

class _DemoAppState extends State<DemoApp> with TickerProviderStateMixin {
  Locale _currentLocale;

  onLocaleChange(Locale l) {
    setState(() {
      _currentLocale = l;
    });
  }

  @override
  void initState() {
    super.initState();
    LogUtil.init(isDebug: true, tag: '[Store]');
    widget.store.onChange.listen((AppState event) => {
          onLocaleChange(event.localeState.locale),
          LogUtil.v('Store onChange data')
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          showSemanticsDebugger: false,
          title: widget.appDescription,
          localizationsDelegates: DemoApp._materialDelegates,
          supportedLocales: DemoApp._appDelegate.supportedLocales,
          locale: this._currentLocale,
          theme: buildThemeData(),
          home: LoginScreen()),
      store: widget.store,
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      cursorColor: Colors.blueGrey.shade700,
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
