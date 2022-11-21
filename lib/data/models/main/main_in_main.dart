class MainInMain {
  final num temp;

  final num feelsLike;

  final num tempMin;

  final num tempMax;

  final num pressure;

  final num humidity;

  final num seaLevel;

  final num grndLevel;

  MainInMain({
    required this.feelsLike,
    required this.grndLevel,
    required this.humidity,
    required this.pressure,
    required this.seaLevel,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
  });

  factory MainInMain.fromJson(Map<String, Object?> json) {
    return MainInMain(
      temp: json["temp"] as num? ?? 0.0,
      feelsLike: json["feels_like"] as double? ?? 0.0,
      tempMin: json["temp_min"] as double? ?? 0.0,
      tempMax: json["temp_max"] as double? ?? 0.0,
      pressure: json["pressure"] as num? ?? 0,
      humidity: json["humidity"] as num? ?? 0,
      seaLevel: json["sea_level"] as num? ?? 0,
      grndLevel: json["grnd_level"] as num? ?? 0,
    );
  }
}
