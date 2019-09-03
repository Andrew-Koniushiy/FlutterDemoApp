import 'dart:async';

import 'package:flutter_app/data/model/photo_data.dart';
import 'package:flutter_app/data/db/database_client.dart';
import 'package:sqflite/sqflite.dart';

class PhotoRepositoryDB {
  const PhotoRepositoryDB();

  Future<List<Photo>> getPhotosList(String sorting, int limit, int skipCount) async {
    Database db = await DatabaseClient().db;
    List<Map> results = await db.query("photo", limit: limit, offset: skipCount, orderBy: "${sorting} DESC");

    List<Photo> photos = new List();
    results.forEach((result) {
      Photo photo = Photo.fromMap(result);
      photos.add(photo);
    });
    return photos;
  }

  Future<Photo> createPhoto(Photo photo) async {
    try {
      var count = 0;
      Database db = await DatabaseClient().db;
      if (photo.id != null) {
        count = Sqflite.firstIntValue(await db
            .rawQuery("SELECT COUNT(*) FROM photo WHERE id = ?", [photo.id]));
      }
      if (count == 0) {
        await db.insert("photo", photo.toMap());
      } else {
        await db.update("photo", photo.toMap(),
            where: "id = ?", whereArgs: [photo.id]);
      }
    } catch (e) {
      print(e.toString());
    }
    return photo;
  }

  Future<int> deletePhoto(String id) async {
    Database db = await DatabaseClient().db;
    return db.delete("photo", where: "id = ?", whereArgs: [id]);
  }

  Future<Photo> getPhoto(String id) async {
    Database db = await DatabaseClient().db;
    List<Map> results =
        await db.query("photo", where: "id = ?", whereArgs: [id]);
    Photo photo = Photo.fromMap(results[0]);
    return photo;
  }

  Future<Photo> updatePhoto(Photo photo) async {
    Database db = await DatabaseClient().db;
    var count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM photo WHERE id = ?", [photo.id]));
    if (count == 0) {
      await db.insert("photo", photo.toMap());
      //photo.id =
    } else {
      await db.update("photo", photo.toMap(),
          where: "id = ?", whereArgs: [photo.id]);
    }
    return photo;
  }

  Future<List<Photo>> searchPhoto(String query, int page, int perPage) {
    // TODO
  }
}