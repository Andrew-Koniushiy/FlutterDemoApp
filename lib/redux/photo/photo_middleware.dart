import 'package:redux/redux.dart';
import 'package:flutter_app/redux/action_report.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/photo/photo_actions.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/data/remote/photo_repository.dart';
import 'package:flutter_app/data/db/photo_repository_db.dart';
import 'package:flutter_app/redux/photo/photo_actions.dart';
import 'package:flutter_app/data/model/page_data.dart';

List<Middleware<AppState>> createPhotoMiddleware([
  PhotoRepository _repository = const PhotoRepository(),
  PhotoRepositoryDB _repositoryDB = const PhotoRepositoryDB(),
]) {
  final getPhoto = _createGetPhoto(_repository, _repositoryDB);
  final getPhotos = _createGetPhotos(_repository, _repositoryDB);
  final createPhoto = _createCreatePhoto(_repository, _repositoryDB);
  final updatePhoto = _createUpdatePhoto(_repository, _repositoryDB);
  final deletePhoto = _createDeletePhoto(_repository, _repositoryDB);
  final searchPhoto = _createSearchPhoto(_repository);

  return [
    TypedMiddleware<AppState, GetPhotoAction>(getPhoto),
    TypedMiddleware<AppState, GetPhotosAction>(getPhotos),
    TypedMiddleware<AppState, CreatePhotoAction>(createPhoto),
    TypedMiddleware<AppState, UpdatePhotoAction>(updatePhoto),
    TypedMiddleware<AppState, DeletePhotoAction>(deletePhoto),
    TypedMiddleware<AppState, SearchPhotoAction>(searchPhoto),
  ];
}


Middleware<AppState> _createGetPhoto(
    PhotoRepository repository, PhotoRepositoryDB repositoryDB) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action.id == null) {
      idEmpty(action);
    } else {
      repository.getPhoto(action.id).then((item) {
        next(SyncPhotoAction(photo: item));
        completed(action);
      }).catchError((error) {
        catchError(action, error);
      });
    }
  };
}

Middleware<AppState> _createGetPhotos(
    PhotoRepository repository, PhotoRepositoryDB repositoryDB) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action.isRefresh) {
      store.state.photoState.page.currPage = 1;
      store.state.photoState.photos.clear();
    } else {
      var p = ++store.state.photoState.page.currPage;
      if (p > ++store.state.photoState.page.totalPage) {
        noMoreItem(action);
        return;
      }
    }
    repository
        .getPhotosList(
            "sorting",
            store.state.photoState.page.currPage,
            store.state.photoState.page.pageSize)
        .then((map) {
      if (map.isNotEmpty) {
        var page = Page(
            currPage: map["currPage"],
            totalPage: map["totalPage"],
            totalCount: map["totalCount"]);
        var l = map["list"] ?? List();
        List<Photo> list =
            l.map<Photo>((item) => new Photo.fromJson(item)).toList();
        next(SyncPhotosAction(page: page, photos: list));
      }
      completed(action);
    }).catchError((error) {
      catchError(action, error);
    });
//    repositoryDB
//        .getPhotosList(
//            "id",
//            store.state.photoState.page.pageSize,
//            store.state.photoState.page.pageSize *
//                store.state.photoState.page.currPage)
//        .then((map) {
//      if (map.isNotEmpty) {
//        var page = Page(currPage: store.state.photoState.page.currPage + 1);
//        next(SyncPhotosAction(page: page, photos: map));
//        completed(action);
//      }
//    }).catchError((error) {
//      catchError(action, error);
//    });
  };
}

Middleware<AppState> _createCreatePhoto(
    PhotoRepository repository, PhotoRepositoryDB repositoryDB) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository.createPhoto(action.photo).then((item) {
      next(SyncPhotoAction(photo: item));
      completed(action);
    }).catchError((error) {
      catchError(action, error);
    });
  };
}

Middleware<AppState> _createUpdatePhoto(
    PhotoRepository repository, PhotoRepositoryDB repositoryDB) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository.updatePhoto(action.photo).then((item) {
      next(SyncPhotoAction(photo: item));
      completed(action);
    }).catchError((error) {
      catchError(action, error);
    });
  };
}

Middleware<AppState> _createDeletePhoto(
    PhotoRepository repository, PhotoRepositoryDB repositoryDB) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository.deletePhoto(action.photo.id).then((item) {
      next(RemovePhotoAction(id: action.photo.id));
      completed(action);
    }).catchError((error) {
      catchError(action, error);
    });
  };
}

Middleware<AppState> _createSearchPhoto(PhotoRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    next(SyncSearchPhotoAction(searchPhotos: []));
    repository.searchPhoto(action.query, 1, 30).then((searchPhotos) {
      next(SyncSearchPhotoAction(searchPhotos: searchPhotos));
      completed(action);
    }).catchError((error) {
      catchError(action, error);
    });
  };
}