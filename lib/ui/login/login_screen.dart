import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/ui/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final onLocaleChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[buildImageContainer(context), LoginForm()],
      ),
    );
  }

  Container buildImageContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'images/login.png',
              ).image)),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[buildOutlineButton(context)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineButton buildOutlineButton(BuildContext context) {
    return OutlineButton.icon(
      icon: const Icon(
        Icons.language,
        size: 24.0,
        color: Colors.white,
      ),
      label: Text(S.of(context).changeLanguageButton),
      textColor: Colors.white,
      onPressed: () {
        showMaterialDialog(
          context: context,
        );
      },
    );
  }

  Future<void> showMaterialDialog({BuildContext context}) async {
    var dialogResult = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(S.of(context).lngDialogTitle),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'en');
                },
                child: text(context, S.of(context).lngEn),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'ru');
                },
                child: text(context, S.of(context).lngRu),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'uk');
                },
                child: text(context, S.of(context).lngUk),
              ),
            ],
          );
        });
    if (dialogResult != null) {
      onLocaleChange(Locale(dialogResult));
    }
  }

  Padding text(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.display2.merge(TextStyle(
            fontWeight: FontWeight.normal,
            decorationStyle: TextDecorationStyle.dotted)),
      ),
    );
  }

  LoginScreen({
    @required this.onLocaleChange,
  });
}
