import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/ui/login/login_form.dart';
import 'package:flutter_app/ui/login/login_screen_view_model.dart';
import 'package:flutter_app/widgets/language_button.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  final loginAnimationDuration = const Duration(seconds: 1, microseconds: 500);

  _LoginScreenState() {
    LogUtil.init(isDebug: true, tag: '[ANIMATION]');
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: loginAnimationDuration,
        vsync: this,
        debugLabel: 'LoginAnimationController');
    LogUtil.v('_LoginScreenState -> initState() -> crete _controller');

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    LogUtil.v('_LoginScreenState -> initState() -> start animation');
    _controller.forward();
  }

  @override
  void dispose() {
    LogUtil.v('_LoginScreenState -> dispose() -> _controller.dispose()s');
    _controller ?? _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StoreConnector<AppState, LoginScreenViewModel>(
      converter: LoginScreenViewModel.fromStore,
      builder: (BuildContext context, LoginScreenViewModel vm) {
        return Stack(
          children: <Widget>[
            buildImage(size),
            LanguageButton(animation: this._opacityAnimation, viewModel: vm),
            LoginForm(animation: this._opacityAnimation, height: size.height),
          ],
        );
      },
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
}
