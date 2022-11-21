import 'package:flutter/material.dart';
import 'package:wheather_app_clone/data/models/detail/daily_item/daily_item.dart';
import 'package:wheather_app_clone/data/models/helper/lat_lon.dart';
import 'package:wheather_app_clone/screens/splash_page.dart';
import 'package:wheather_app_clone/screens/wheather_detail_screen/weather_detail.dart';
import 'package:wheather_app_clone/screens/wheather_main/home_page.dart';
import 'package:wheather_app_clone/utils/time_utils.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(
            builder: (_) => WeatherMainScreen(
                  latLong: settings.arguments as LatLong,
                ));
      case dailyScreen:
        return MaterialPageRoute(
          builder: (_) => WeatherDailyScreen(
            daily: settings.arguments as List<DailyItem>,
          ),
        );
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}