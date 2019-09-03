import 'package:meta/meta.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/redux/action_report.dart';
import 'package:flutter_app/data/model/page_data.dart';

class GetPhotosAction extends Action {
  final bool isRefresh;

  GetPhotosAction({this.isRefresh, completer})
      : super(completer, "GetPhotosAction");
}

class GetPhotoAction extends Action {
  final String id;

  GetPhotoAction({@required this.id, completer})
      : super(completer, "GetPhotoAction");
}

class CreatePhotoAction extends Action {
  final Photo photo;

  CreatePhotoAction({@required this.photo, completer})
      : super(completer, "CreatePhotoAction");
}

class UpdatePhotoAction extends Action {
  final Photo photo;

  UpdatePhotoAction({@required this.photo, completer})
      : super(completer, "UpdatePhotoAction");
}

class DeletePhotoAction extends Action {
  final Photo photo;

  DeletePhotoAction({@required this.photo, completer})
      : super(completer, "DeletePhotoAction");
}


class SyncPhotosAction extends Action {
  final Page page;
  final List<Photo> photos;

  SyncPhotosAction({this.page, this.photos, completer})
      : super(completer, "SyncPhotosAction");
}

class SyncPhotoAction extends Action {
  final Photo photo;

  SyncPhotoAction({@required this.photo, completer})
      : super(completer, "SyncPhotoAction");
}

class RemovePhotoAction extends Action {
  final String id;

  RemovePhotoAction({@required this.id, completer})
      : super(null, "RemovePhotoAction");
}

class SearchPhotoAction extends Action {
  final String query;

  SearchPhotoAction({this.query, completer})
        : super(completer, "SearchPhotoAction");
}

class SyncSearchPhotoAction extends Action {
  final List<Photo> searchPhotos;

  SyncSearchPhotoAction({this.searchPhotos, completer})
        : super(completer, "SyncSearchPhotoAction");
}