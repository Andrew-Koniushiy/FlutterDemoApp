import 'dart:core';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/validators/validator.dart';

class LoginValidator extends Validator {
  final context;

  LoginValidator(this.context);

  @override
  String validate(String value) {
    final translation = S.of(this.context);
    final fieldHint = translation.loginFieldHint;
    if (value.isEmpty) {
      return translation.emptyValueValidationError(fieldHint);
    } else if (!RegexUtil.isEmail(value)) {
      return translation.emailValueValidationError(fieldHint);
    }
    return null;
  }
}
