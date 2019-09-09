import 'package:flutter_app/redux/locale/locale_actions.dart';
import 'package:flutter_app/redux/locale/locale_state.dart';
import 'package:redux/redux.dart';

final localeReducer = combineReducers<LocaleState>([
  TypedReducer<LocaleState, ChangeLocaleAction>(_localeStatus),
]);

LocaleState _localeStatus(LocaleState state, ChangeLocaleAction action) {
  return state.copyWith(locale: action.locale);
}
