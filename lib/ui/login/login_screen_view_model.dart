import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/locale/locale_actions.dart';
import 'package:redux/redux.dart';

typedef DoChangeLocale = void Function(Locale);

class LoginScreenViewModel {
  final Locale locale;
  final DoChangeLocale changeLocale;

  LoginScreenViewModel({this.locale, this.changeLocale});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginScreenViewModel &&
          runtimeType == other.runtimeType &&
          locale == other.locale &&
          changeLocale == other.changeLocale;

  @override
  int get hashCode => locale.hashCode ^ changeLocale.hashCode;

  static LoginScreenViewModel fromStore(Store<AppState> store) {
    return LoginScreenViewModel(
        locale: store.state.localeState.locale,
        changeLocale: (locale) {
          store.dispatch(ChangeLocaleAction(locale: locale));
        });
  }
}
