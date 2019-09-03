import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/model/type_data.dart';
import 'package:flutter_app/data/model/category_data.dart';

class Ancestry {
  Type type;
  Category category;

  Ancestry({
    this.type,
    this.category,
  });

  Ancestry.fromJson(Map<String, dynamic>  map) :
        type = map['type'] == null
            ? null
            : Type.fromJson(map['type']),
        category = map['category'] == null
            ? null
            : Category.fromJson(map['category']);

  Map<String, dynamic> toJson() => {
        'type': type.toJson(),
        'category': category.toJson(),
      };

  Ancestry copyWith({
    Type type,
    Category category,
  }) {
    return Ancestry(
      type: type ?? this.type,
      category: category ?? this.category,
    );
  }

}

