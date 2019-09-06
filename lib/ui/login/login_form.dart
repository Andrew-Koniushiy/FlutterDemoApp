import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/widgets/material_text_field.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            elevation: 0,
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      S.of(context).loginTitle,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialTextField(label: S.of(context).loginFieldHint),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialTextField(
                      label: S.of(context).passFieldHint,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textColor: Colors.white,
                      color: Colors.green.shade700,
                      child: Text(
                        S.of(context).loginButton,
                      ),
                      onPressed: () {
                        showToast('do login');
                        _formKey.currentState.validate();
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
