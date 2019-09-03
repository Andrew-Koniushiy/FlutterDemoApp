import 'dart:convert';
import 'package:intl/intl.dart';

class Category {
  String prettySlug;
  String slug;

  Category({
    this.prettySlug = "",
    this.slug = "",
  });

  Category.fromJson(Map<String, dynamic>  map) :
        prettySlug = map['pretty_slug']  ?? "",
        slug = map['slug']  ?? "";

  Map<String, dynamic> toJson() => {
        'pretty_slug': prettySlug,
        'slug': slug,
      };

  Category copyWith({
    String prettySlug,
    String slug,
  }) {
    return Category(
      prettySlug: prettySlug ?? this.prettySlug,
      slug: slug ?? this.slug,
    );
  }

}

