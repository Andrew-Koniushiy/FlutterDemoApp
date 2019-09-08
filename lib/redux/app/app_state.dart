import 'package:flutter_app/data/model/page_data.dart';
import 'package:flutter_app/redux/photo/photo_state.dart';
import 'package:meta/meta.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final PhotoState photoState;

  AppState({
    @required this.photoState,
  });

  factory AppState.initial() {
    return AppState(
      photoState: PhotoState(
        photo: null,
        photos: Map(),
        status: Map(),
        page: Page(),
      ),
    );
  }
}
