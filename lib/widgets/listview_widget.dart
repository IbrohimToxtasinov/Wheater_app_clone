import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/images.dart';

Widget listViewWidget(BuildContext context, {temp}) {
  return SizedBox(
    child: SizedBox(
      height: 146,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
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
                const Text(
                  "Now",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cFFFFFF),
                ),
                SvgPicture.asset(AppImages.iconSunCloud),
                Text("${-20 + ((index + 1) * 10)}%",
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c40CBD8)),
                const SizedBox(height: 8),
                Text("${temp}°",
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
