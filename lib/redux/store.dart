import 'package:flutter_app/redux/app/app_reducer.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/photo/photo_middleware.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: []
      ..addAll(createPhotoMiddleware())
      ..addAll([
        LoggingMiddleware<dynamic>.printer(level: Level.ALL),
      ]),
  );
}
