import 'package:intl/intl.dart';

class TimeUtils {
static getDateWeek(dt) {
  final format = DateFormat.E().format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
  return format;
}
static getDateHour(dt) {
  final format = DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
  return format;
}

 static List<String> getPlaceNames() => [
        "Tashkent",
        "Andijan",
        "Olmazor",
        "London",
        "Asaka",
        "Chust",
        "Fergana",
        "Samarkand",
        "Bukhara",
        "Moscow",
      ];
}

const String splashScreen = "/";
const String mainScreen = "/main_route";
const String dailyScreen = "/daily_route";


