import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wheather_app_clone/data/models/detail/one_call_data.dart';
import 'package:wheather_app_clone/data/models/helper/lat_lon.dart';
import 'package:wheather_app_clone/data/models/weather_main_model.dart';

const String baseUrl = "api.openweathermap.org";
const String apiToken = "139d82d53b7f20c0a44c1bc27377f9ff";
const String UNITS = "metric";

class AppRepository {
  static Future<WeatherMainModel> getWeatherMainDataByQuery({
    required String query,
  }) async {
    var queryParams = {
      "appid": apiToken,
      "q": query,
      "birnima": "units=metric"
    };
    var uri = Uri.https(baseUrl, "/data/2.5/weather", queryParams);
    try {
      Response response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // print(response.body.toString());
        return WeatherMainModel.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  static Future<WeatherMainModel> getWeatherMainDataByLocation({
    required LatLong latLong
  }) async {
    var queryParams = {
      "lat": latLong.lat.toString(),
      "lon": latLong.long.toString(),
      "appid": apiToken,
      "units": UNITS, 
    };
    var uri = Uri.http(baseUrl, "/data/2.5/weather", queryParams);
    try {
      Response response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body.toString());
        return WeatherMainModel.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

    static Future<OneCallData> getHourlyDailyWeather({required LatLong latLong}) async {
    var queryParams = {
      "lat": latLong.lat.toString(),
      "lon": latLong.long.toString(),
      "units": "metric",
      "exclude": "minutely,current",
      "appid": apiToken,
    };
    var uri = Uri.https(baseUrl, "/data/2.5/onecall", queryParams);

    try {
      Response response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // print(response.body);
        return OneCallData.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}