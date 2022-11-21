class SysInMain {
  final num type;
  final num id;
  final num sunrise;
  final num sunset;
  final String country;

  SysInMain({
    required this.id,
    required this.type,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SysInMain.fromJson(Map<String, Object?> json) {
    return SysInMain(
      id: json["id"] as num? ?? 0.0,
      type: json["type"] as num? ?? 0.0,
      sunrise: json["sunrise"] as num? ?? 0.0,
      country: json["country"] as String? ?? '',
      sunset: json["sunset"] as num? ?? 0.0,
    );
  }
}