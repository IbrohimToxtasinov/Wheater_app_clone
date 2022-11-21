import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheather_app_clone/data/models/detail/daily_item/daily_item.dart';
import 'package:wheather_app_clone/data/models/detail/hourly_item/hourly_item.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/time_utils.dart';

Widget listViewhourlyWidget(BuildContext context, {required List<HourlyItem> hourly}) {
  return SizedBox(
    child: SizedBox(
      height: 146,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(5),
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1, color: AppColors.cFFFFFF)),
            child: Column(
              children: [
                const SizedBox(height: 11),
                Text(
                  "${TimeUtils.getDateHour(hourly[index].dt)}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cFFFFFF),
                ),
                Image.network("http://openweathermap.org/img/w/${hourly[index].weather[0].icon}.png"),
                Text("${-20 + ((index + 1) * 10)}%",
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c40CBD8)),
                const SizedBox(height: 8),
                Text("${hourly[index].temp}°",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColors.cFFFFFF))
              ],
            ),
          );
        },
      ),
    ),
  );
}

//!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Widget listViewdailyWidget(BuildContext context, {required List<DailyItem> daily}) {
  return SizedBox(
    child: SizedBox(
      height: 146,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: daily.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(5),
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1, color: AppColors.cFFFFFF)),
            child: Column(
              children: [
                const SizedBox(height: 11),
                Text(
                  "${TimeUtils.getDateWeek(daily[index].dt)}",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cFFFFFF),
                ),
                Image.network("http://openweathermap.org/img/w/${daily[index].weather[0].icon}.png"),
                Text("${-20 + ((index + 1) * 10)}%",
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c40CBD8)),
                const SizedBox(height: 8),
                Text("${daily[index].dailyTemp.day}°",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColors.cFFFFFF))
              ],
            ),
          );
        },
      ),
    ),
  );
}
