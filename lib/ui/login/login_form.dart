import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/validators/login_validator.dart';
import 'package:flutter_app/validators/pass_validator.dart';
import 'package:flutter_app/widgets/material_text_field.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  final _loginKey = GlobalKey<FormFieldState>();
  final _loginNodeFocus = FocusNode();
  final _passNodeFocus = FocusNode();

  @override
  void dispose() {
    _loginNodeFocus.dispose();
    _passNodeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 20,
          borderOnForeground: true,
          margin: EdgeInsets.symmetric(horizontal: 16),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              side: BorderSide(), borderRadius: BorderRadius.circular(10)),
          child: buildDecoratedBox(context),
        ),
      ],
    );
  }

  DecoratedBox buildDecoratedBox(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.background,
      child: BackdropFilter(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Text(
                S.of(context).loginTitle,
                style: buildLoginTitleTextStyle(),
              ),
              buildForm(context),
            ],
          ),
        ),
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      ),
      decoration: buildBoxDecoration(),
    );
  }

  TextStyle buildLoginTitleTextStyle() {
    return TextStyle(
        color: Colors.blueGrey,
        fontFamily: 'PTSansBold',
        fontSize: 37,
        fontWeight: FontWeight.bold);
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withAlpha(140), BlendMode.hardLight),
            image: Image.asset(
              'assets/images/login_background.jpg',
              filterQuality: FilterQuality.low,
            ).image));
  }

  Form buildForm(BuildContext context) {
    final loginHint = S.of(context).loginFieldHint;
    final passHint = S.of(context).passFieldHint;

    VoidCallback loginFieldSubmittedCallback =
        () => {FocusScope.of(context).requestFocus(_passNodeFocus)};

    VoidCallback passFieldSubmittedCallback = () => {doLogin()};

    return Form(
        key: _formKey,
        child: KeyboardAvoider(
          focusPadding: 10,
          child: Column(
            children: <Widget>[
              buildLoginField(loginFieldSubmittedCallback, loginHint, context),
              buildPassField(passFieldSubmittedCallback, passHint, context),
              SizedBox(
                height: 40,
              ),
              buildLoginButton(context),
            ],
          ),
        ));
  }

  MaterialButton buildLoginButton(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
      child: Text(
        S.of(context).loginButton.toUpperCase(),
      ),
      onPressed: () {
        doLogin();
      },
    );
  }

  MaterialTextField buildPassField(VoidCallback fieldSubmittedCallback,
      String passHint, BuildContext context) {
    return MaterialTextField(
        key: _passKey,
        onFieldSubmitted: fieldSubmittedCallback,
        nodeFocus: _passNodeFocus,
        label: passHint,
        obscureText: true,
        validator: PasswordValidator(context),
        textInputAction: TextInputAction.done);
  }

  MaterialTextField buildLoginField(VoidCallback fieldSubmittedCallback,
      String loginHint, BuildContext context) {
    return MaterialTextField(
      key: _loginKey,
      onFieldSubmitted: fieldSubmittedCallback,
      nodeFocus: _loginNodeFocus,
      textInputAction: TextInputAction.next,
      label: loginHint,
      textInputType: TextInputType.emailAddress,
      initialValue: 'a.yu.koniushyy@gmail.com',
      validator: LoginValidator(context),
    );
  }

  doLogin() {
    if (_formKey.currentState.validate()) {
      var login = _loginKey.currentState.value;
      var pass = _passKey.currentState.value;
      showToast('do login with ' + login + ' and ' + pass);
    }
  }
}
