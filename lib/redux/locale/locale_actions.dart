import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ChangeLocaleAction {
  final String actionName = "ChangeLocaleAction";
  final Locale locale;

  ChangeLocaleAction({@required this.locale});
}
