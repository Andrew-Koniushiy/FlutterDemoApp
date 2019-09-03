import 'dart:convert';
import 'package:intl/intl.dart';

class Type {
  String prettySlug;
  String slug;

  Type({
    this.prettySlug = "",
    this.slug = "",
  });

  Type.fromJson(Map<String, dynamic>  map) :
        prettySlug = map['pretty_slug']  ?? "",
        slug = map['slug']  ?? "";

  Map<String, dynamic> toJson() => {
        'pretty_slug': prettySlug,
        'slug': slug,
      };

  Type copyWith({
    String prettySlug,
    String slug,
  }) {
    return Type(
      prettySlug: prettySlug ?? this.prettySlug,
      slug: slug ?? this.slug,
    );
  }

}

