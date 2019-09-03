import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/redux/action_report.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/features/action_callback.dart';
import 'package:flutter_app/redux/photo/photo_actions.dart';

class HomeViewModel {
  final Photo photo;
  final List<Photo> photos;
  final Function(bool, ActionCallback) getPhotos;
  final List<Photo> searchPhotos;
  final Function(String) searchPhoto;

  HomeViewModel({
    this.photo,
    this.photos,
    this.getPhotos,
    this.searchPhotos,
    this.searchPhoto,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      photo: store.state.photoState.photo,
      photos: store.state.photoState.photos.values.toList() ?? [],
      getPhotos: (isRefresh, callback) {
        final Completer<ActionReport> completer = Completer<ActionReport>();
        store.dispatch(GetPhotosAction(isRefresh: isRefresh, completer: completer));
        completer.future.then((status) {
          callback(status);
        }).catchError((error) => callback(error));
      },
      searchPhotos: store.state.photoState.searchPhotos ?? [],
      searchPhoto: (query) {
        final Completer<ActionReport> completer = Completer<ActionReport>();
        store.dispatch(SearchPhotoAction(query: query, completer: completer));
        completer.future.then((status) {});
      },
    );
  }
}
