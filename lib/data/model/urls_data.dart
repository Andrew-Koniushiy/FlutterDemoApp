class Urls {
  String small;
  String thumb;
  String raw;
  String regular;
  String full;

  Urls({
    this.small = "",
    this.thumb = "",
    this.raw = "",
    this.regular = "",
    this.full = "",
  });

  Urls.fromJson(Map<String, dynamic> map)
      : small = map['small'] ?? "",
        thumb = map['thumb'] ?? "",
        raw = map['raw'] ?? "",
        regular = map['regular'] ?? "",
        full = map['full'] ?? "";

  Map<String, dynamic> toJson() => {
        'small': small,
        'thumb': thumb,
        'raw': raw,
        'regular': regular,
        'full': full,
      };

  Urls copyWith({
    String small,
    String thumb,
    String raw,
    String regular,
    String full,
  }) {
    return Urls(
      small: small ?? this.small,
      thumb: thumb ?? this.thumb,
      raw: raw ?? this.raw,
      regular: regular ?? this.regular,
      full: full ?? this.full,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'small': this.small,
      'thumb': this.thumb,
      'raw': this.raw,
      'regular': this.regular,
      'full': this.full,
    };
  }

  factory Urls.fromMap(Map<String, dynamic> map) {
    return new Urls(
      small: map['small'] as String,
      thumb: map['thumb'] as String,
      raw: map['raw'] as String,
      regular: map['regular'] as String,
      full: map['full'] as String,
    );
  }
}
