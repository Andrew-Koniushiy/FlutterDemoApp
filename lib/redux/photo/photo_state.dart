import 'package:meta/meta.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/data/model/page_data.dart';
import 'package:flutter_app/redux/action_report.dart';

class PhotoState {
  final List<Photo> searchPhotos;
  final Map<String, Photo> photos;
  final Photo photo;
  final Page page;

  PhotoState({
    @required this.searchPhotos,
    @required this.photos,
    @required this.photo,
    @required this.page,
  });

  PhotoState copyWith({
    List<Photo> searchPhotos,
    Map<String, Photo> photos,
    Photo photo,
    Page page,
  }) {
    return PhotoState(
      searchPhotos: searchPhotos ?? this.searchPhotos,
      photos: photos ?? this.photos ?? Map(),
      photo: photo ?? this.photo,
      page: page ?? this.page,
    );
  }
}
