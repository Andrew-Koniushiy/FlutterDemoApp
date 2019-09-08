import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/ui/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  final onLocaleChange;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        buildImage(size),
        Padding(
          padding: const EdgeInsets.only(top: 25, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildLanguageButton(context),
            ],
          ),
        ),
        LoginForm(),
      ],
    );
  }

  Image buildImage(Size size) {
    return Image.asset(
      'assets/images/login_background.jpg',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
    );
  }

  OutlineButton buildLanguageButton(BuildContext context) {
    return OutlineButton.icon(
      icon: const Icon(
        Icons.language,
        size: 24.0,
      ),
      label: Text(S.of(context).changeLanguageButton.toUpperCase()),
      borderSide: BorderSide(
          width: 1,
          style: BorderStyle.solid,
          color: Theme.of(context).primaryColorDark),
      textColor: Theme.of(context).primaryColorDark,
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
