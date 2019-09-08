class Position {
  double latitude;
  double longitude;

  Position({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  Position.fromJson(Map<String, dynamic> map)
      : latitude = map['latitude'] ?? 0.0,
        longitude = map['longitude'] ?? 0.0;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  Position copyWith({
    double latitude,
    double longitude,
  }) {
    return Position(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return new Position(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
