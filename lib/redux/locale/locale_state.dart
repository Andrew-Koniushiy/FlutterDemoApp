import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LocaleState {
  final Locale locale;

  LocaleState({
    @required this.locale,
  });

  LocaleState copyWith({
    Locale locale,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}
