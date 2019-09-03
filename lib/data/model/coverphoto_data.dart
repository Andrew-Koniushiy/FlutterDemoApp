import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/model/urls_data.dart';
import 'package:flutter_app/data/model/links_data.dart';
import 'package:flutter_app/data/model/user_data.dart';

class CoverPhoto {
  String color;
  String createdAt;
  String description;
  bool likedByUser;
  Urls urls;
  String altDescription;
  String updatedAt;
  int width;
  Links links;
  String id;
  User user;
  int height;
  int likes;

  CoverPhoto({
    this.color = "",
    this.createdAt = "",
    this.description = "",
    this.likedByUser = false,
    this.urls,
    this.altDescription = "",
    this.updatedAt = "",
    this.width = 0,
    this.links,
    this.id = "",
    this.user,
    this.height = 0,
    this.likes = 0,
  });

  CoverPhoto.fromJson(Map<String, dynamic>  map) :
        color = map['color']  ?? "",
        createdAt = map['created_at']  ?? "",
        description = map['description']  ?? "",
        likedByUser = map['liked_by_user']  ?? false,
        urls = map['urls'] == null
            ? null
            : Urls.fromJson(map['urls']),
        altDescription = map['alt_description']  ?? "",
        updatedAt = map['updated_at']  ?? "",
        width = map['width']  ?? 0,
        links = map['links'] == null
            ? null
            : Links.fromJson(map['links']),
        id = map['id']  ?? "",
        user = map['user'] == null
            ? null
            : User.fromJson(map['user']),
        height = map['height']  ?? 0,
        likes = map['likes']  ?? 0;

  Map<String, dynamic> toJson() => {
        'color': color,
        'created_at': createdAt,
        'description': description,
        'liked_by_user': likedByUser,
        'urls': urls.toJson(),
        'alt_description': altDescription,
        'updated_at': updatedAt,
        'width': width,
        'links': links.toJson(),
        'id': id,
        'user': user.toJson(),
        'height': height,
        'likes': likes,
      };

  CoverPhoto copyWith({
    String color,
    String createdAt,
    String description,
    bool likedByUser,
    Urls urls,
    String altDescription,
    String updatedAt,
    int width,
    Links links,
    String id,
    User user,
    int height,
    int likes,
  }) {
    return CoverPhoto(
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      likedByUser: likedByUser ?? this.likedByUser,
      urls: urls ?? this.urls,
      altDescription: altDescription ?? this.altDescription,
      updatedAt: updatedAt ?? this.updatedAt,
      width: width ?? this.width,
      links: links ?? this.links,
      id: id ?? this.id,
      user: user ?? this.user,
      height: height ?? this.height,
      likes: likes ?? this.likes,
    );
  }

}

