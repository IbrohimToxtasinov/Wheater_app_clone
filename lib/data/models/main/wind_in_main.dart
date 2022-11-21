class WindInMain {
  final num speed;
  final num deg;
  final num gust;

  WindInMain({
    required this.deg,
    required this.gust,
    required this.speed,
  });

  factory WindInMain.fromJson(Map<String, Object?> json) {
    return WindInMain(
      deg: json["deg"] as num? ?? 0,
      gust: json["gust"] as num? ?? 0.0,
      speed: json["speed"] as num? ?? 0.0,
    );
  }
}