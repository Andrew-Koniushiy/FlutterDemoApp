class ProfileImage {
  String small;
  String large;
  String medium;

  ProfileImage({
    this.small = "",
    this.large = "",
    this.medium = "",
  });

  ProfileImage.fromJson(Map<String, dynamic> map)
      : small = map['small'] ?? "",
        large = map['large'] ?? "",
        medium = map['medium'] ?? "";

  Map<String, dynamic> toJson() => {
        'small': small,
        'large': large,
        'medium': medium,
      };

  ProfileImage copyWith({
    String small,
    String large,
    String medium,
  }) {
    return ProfileImage(
      small: small ?? this.small,
      large: large ?? this.large,
      medium: medium ?? this.medium,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'small': this.small,
      'large': this.large,
      'medium': this.medium,
    };
  }

  factory ProfileImage.fromMap(Map<String, dynamic> map) {
    return new ProfileImage(
      small: map['small'] as String,
      large: map['large'] as String,
      medium: map['medium'] as String,
    );
  }
}
