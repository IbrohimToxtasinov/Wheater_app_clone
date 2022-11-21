import 'package:wheather_app_clone/data/models/detail/daily_item/daily_feels_like.dart';
import 'package:wheather_app_clone/data/models/detail/daily_item/daily_temp.dart';
import 'package:wheather_app_clone/data/models/main/weather_model.dart';

class DailyItem {
  num dt;

  num sunrise;

  num sunset;

  num moonrise;

  num moonset;

  double moonPhase;

  DailyTemp dailyTemp;

  DailyFeelsLike dailyFeelsLike;

  num pressure;

  num humidity;

  double dewPoint;

  double windSpeed;

  num windDeg;

  double windGust;

  List<WeatherModel> weather;

  num clouds;

  double pop;

  double uvi;

  DailyItem({
    required this.dailyFeelsLike,
    required this.dailyTemp,
    required this.windSpeed,
    required this.windGust,
    required this.windDeg,
    required this.uvi,
    required this.dewPoint,
    required this.pop,
    required this.humidity,
    required this.clouds,
    required this.pressure,
    required this.dt,
    required this.weather,
    required this.sunset,
    required this.sunrise,
    required this.moonPhase,
    required this.moonrise,
    required this.moonset,
  });

  factory DailyItem.fromJson(Map<String, dynamic> json) => DailyItem(
        dailyFeelsLike:
            DailyFeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
        dailyTemp: DailyTemp.fromJson(json['temp'] as Map<String, dynamic>),
        windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
        windGust: (json['wind_gust'] as num?)?.toDouble() ?? 0.0,
        windDeg: json['wind_deg'] as int? ?? 0,
        uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
        dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
        pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
        humidity: json['humidity'] as num? ?? 0,
        clouds: json['clouds'] as num? ?? 0,
        pressure: json['pressure'] as num? ?? 0,
        dt: json['dt'] as num? ?? 0,
        weather: (json['weather'] as List<dynamic>?)
                ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        sunset: json['sunset'] as num? ?? 0,
        sunrise: json['sunrise'] as num? ?? 0,
        moonPhase: (json['moon_phase'] as num?)?.toDouble() ?? 0.0,
        moonrise: json['moonrise'] as num? ?? 0,
        moonset: json['moonset'] as num? ?? 0,
      );

  @override
  String toString() {
    return '''
     dt: $dt,
     sunrise: $sunrise
     sunset: $sunset
     moonrise: $moonrise
     moonset: $moonset
     dailyTemp: ${dailyTemp.toString()}
     dailyFeelsLike: ${dailyFeelsLike.toString()}
     pressure: $pressure
     humidity: $humidity
     dewPoint: $dewPoint
     windSpeed: $windSpeed
     windDeg: $windDeg
     windGust: $windGust
     weather: ${weather.toString()}
     clouds: $clouds
     pop: $pop
     uvi: $uvi
    ''';
  }
}
