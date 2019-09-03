import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/model/source_data.dart';

class TagsItem {
  Source source;
  String type;
  String title;

  TagsItem({
    this.source,
    this.type = "",
    this.title = "",
  });

  TagsItem.fromJson(Map<String, dynamic>  map) :
        source = map['source'] == null
            ? null
            : Source.fromJson(map['source']),
        type = map['type']  ?? "",
        title = map['title']  ?? "";

  Map<String, dynamic> toJson() => {
        'source': source.toJson(),
        'type': type,
        'title': title,
      };

  TagsItem copyWith({
    Source source,
    String type,
    String title,
  }) {
    return TagsItem(
      source: source ?? this.source,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

}

