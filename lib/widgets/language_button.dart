import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/ui/login/login_screen_view_model.dart';

class LanguageButton extends AnimatedWidget {
  final _translateTween = Tween<double>(begin: -100, end: 0);
  final LoginScreenViewModel viewModel;

  LanguageButton({Key key, Animation<double> animation, this.viewModel})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> _opacityAnimation = listenable as Animation<double>;
    LogUtil.v('LanguageButton -> build vidget');
    return Transform.translate(
      offset: Offset(0, _translateTween.evaluate(_opacityAnimation)),
      child: Padding(
        padding: EdgeInsets.only(top: 25, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Opacity(
              opacity: _opacityAnimation.value,
              child: OutlineButton.icon(
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
                    viewModel: this.viewModel,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMaterialDialog(
      {BuildContext context, LoginScreenViewModel viewModel}) async {
    LogUtil.init(isDebug: true, tag: 'ChangeLngDialog');
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
    LogUtil.v('dialogResult: ' + dialogResult);
    if (dialogResult != null) {
      LogUtil.v('viewModel.changeLocale: ' + dialogResult);
      viewModel.changeLocale(Locale(dialogResult));
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
}
