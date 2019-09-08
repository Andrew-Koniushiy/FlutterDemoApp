import 'dart:core';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/validators/validator.dart';

class PasswordValidator extends Validator {
  final minLength;
  dynamic context;

  PasswordValidator(this.context, {this.minLength = 6});

  @override
  String validate(String value) {
    var translation = S.of(this.context);
    var fieldHint = translation.passFieldHint;
    if (value.isEmpty) {
      return translation.emptyValueValidationError(fieldHint);
    } else if (value.length < this.minLength) {
      return translation.minLengthValidationError(
          fieldHint, this.minLength.toString());
    }
    return null;
  }
}
