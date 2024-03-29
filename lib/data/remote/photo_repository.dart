import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/data/network_common.dart';

class PhotoRepository {
  const PhotoRepository();

  Future<Map> getPhotosList(String sorting, int page, int limit) {
    return new NetworkCommon().dio.get("photo/", queryParameters: {
      "sorting": sorting,
      "page": page,
      "limit": limit
    }).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return results;
    });
  }

  Future<Photo> createPhoto(Photo photo) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.post("photo/", data: photo).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new Photo.fromJson(results);
    });
  }

  Future<Photo> updatePhoto(Photo photo) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.put("photo/", data: photo).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new Photo.fromJson(results);
    });
  }

  Future<int> deletePhoto(String id) {
    return new NetworkCommon().dio.delete("photo/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return 0;
    });
  }

  Future<Photo> getPhoto(String id) {
    return new NetworkCommon().dio.get("photo/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new Photo.fromJson(results);
    });
  }
  
  Future<List<Photo>> searchPhoto(String query, int page, int perPage) {
    return new NetworkCommon().dio.get("search/photo", queryParameters: {
      "query": query,
      "page": page,
      "per_page": perPage
    }).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return  results["results"].map<Photo>((item) => new Photo.fromJson(item)).toList();
    });
  }

}
