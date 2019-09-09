import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/locale/locale_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createLocaleMiddleware() {
  final changeLocale = _changeLocale();

  return [
    TypedMiddleware<AppState, ChangeLocaleAction>(changeLocale),
  ];
}

Middleware<AppState> _changeLocale() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(ChangeLocaleAction(locale: action.locale));
  };
}
