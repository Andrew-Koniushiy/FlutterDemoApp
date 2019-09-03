import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/model/ancestry_data.dart';
import 'package:flutter_app/data/model/cover_photo_data.dart';

class Source {
  String metaDescription;
  Ancestry ancestry;
  CoverPhoto coverPhoto;
  String metaTitle;
  String description;
  String title;

  Source({
    this.metaDescription = "",
    this.ancestry,
    this.coverPhoto,
    this.metaTitle = "",
    this.description = "",
    this.title = "",
  });

  Source.fromJson(Map<String, dynamic>  map) :
        metaDescription = map['meta_description']  ?? "",
        ancestry = map['ancestry'] == null
            ? null
            : Ancestry.fromJson(map['ancestry']),
        coverPhoto = map['cover_photo'] == null
            ? null
            : CoverPhoto.fromJson(map['cover_photo']),
        metaTitle = map['meta_title']  ?? "",
        description = map['description']  ?? "",
        title = map['title']  ?? "";

  Map<String, dynamic> toJson() => {
        'meta_description': metaDescription,
        'ancestry': ancestry.toJson(),
        'cover_photo': coverPhoto.toJson(),
        'meta_title': metaTitle,
        'description': description,
        'title': title,
      };

  Source copyWith({
    String metaDescription,
    Ancestry ancestry,
    CoverPhoto coverPhoto,
    String metaTitle,
    String description,
    String title,
  }) {
    return Source(
      metaDescription: metaDescription ?? this.metaDescription,
      ancestry: ancestry ?? this.ancestry,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      metaTitle: metaTitle ?? this.metaTitle,
      description: description ?? this.description,
      title: title ?? this.title,
    );
  }

}

