import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.homePageBacgkround,
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(height: 86),
            const Text("Montreal",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: AppColors.cFFFFFF)),
            const Text("19°",
                style: TextStyle(
                    fontSize: 96,
                    fontWeight: FontWeight.w200,
                    color: AppColors.cFFFFFF)),
            Text("Mostly Clear",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cFFFFFF.withOpacity(0.4))),
            const Text("H:24° L:18°",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cFFFFFF)),
                    Spacer(),
            Container(
              height: 314,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                    gradient:  LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.c2E335A.withOpacity(0.9),
                        AppColors.c1C1B33.withOpacity(1),
                      ])
              ),
            ),
          ],
        ),
      ),
    );
  }
}
