import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:wheather_app_clone/data/models/helper/lat_lon.dart';
import 'package:wheather_app_clone/data/models/weather_main_model.dart';
import 'package:wheather_app_clone/data/repository/app_repository.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isClicked = true;
  bool isLoaded = false;
  LatLong? latLong;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null) {
      setState(() {
        isLoaded = true;
      });
      latLong = LatLong(
        lat: _locationData.latitude!,
        long: _locationData.longitude!,
      );
    }

    print("LONGITUDE:${_locationData.longitude} AND ${_locationData.latitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.imageHomePageBacgkround,
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            FutureBuilder<WeatherMainModel>(
                future: AppRepository.getWeatherMainDataByQuery(
                  query: "Olmazor",
                ),
                builder: (context, AsyncSnapshot<WeatherMainModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Text("Data: ${data.name}");
                  } else {
                    return Text("Error:${snapshot.error.toString()}");
                  }
                }),
            if (latLong != null)
              FutureBuilder<WeatherMainModel>(
                  future: AppRepository.getWeatherMainDataByLocation(
                    latLong: latLong!,
                  ),
                  builder: (context, AsyncSnapshot<WeatherMainModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return Text("Data: ${data.name}");
                    } else {
                      return Text("Error:${snapshot.error.toString()}");
                    }
                  }),
            Visibility(
              visible: isLoaded == false,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
            //       const SizedBox(height: 86),
            //       const Text("Montreal",
            //           style: TextStyle(
            //               fontSize: 34,
            //               fontWeight: FontWeight.w400,
            //               color: AppColors.cFFFFFF)),
            //       const Text("19°",
            //           style: TextStyle(
            //               fontSize: 96,
            //               fontWeight: FontWeight.w200,
            //               color: AppColors.cFFFFFF)),
            //       Text("Mostly Clear",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w600,
            //               color: AppColors.cFFFFFF.withOpacity(0.4))),
            //       const Text("H:24° L:18°",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w600,
            //               color: AppColors.cFFFFFF)),
            //       const Spacer(),
            //       AnimatedContainer(
            //         duration: const Duration(milliseconds: 350),
            //         height: isClicked ? 560 : 360,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //             borderRadius: const BorderRadius.only(
            //                 topLeft: Radius.circular(50),
            //                 topRight: Radius.circular(50)),
            //             gradient: LinearGradient(
            //                 begin: Alignment.topCenter,
            //                 end: Alignment.bottomCenter,
            //                 colors: [
            //                   AppColors.c2E335A.withOpacity(0.9),
            //                   AppColors.c1C1B33.withOpacity(1),
            //                 ])),
            //         child: SingleChildScrollView(
            //           physics: const NeverScrollableScrollPhysics(),
            //           child: Column(
            //             children: [
            //               const SizedBox(
            //                 height: 15,
            //               ),
            //               InkWell(
            //                 onTap: () {
            //                   setState(() {
            //                     isClicked = !isClicked;
            //                   });
            //                 },
            //                 child: SizedBox(
            //                   width: 300,
            //                   child: Container(
            //                     margin: const EdgeInsets.only(right: 120, left: 120),
            //                     width: 45,
            //                     height: 8,
            //                     decoration: BoxDecoration(
            //                       color: AppColors.c000000.withOpacity(0.3),
            //                       borderRadius: BorderRadius.circular(10),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(height: 15),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 12, right: 12),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text("Hourly Forecast",
            //                         style: TextStyle(
            //                             color: AppColors.cEBEBF5.withOpacity(0.6),
            //                             fontSize: 17,
            //                             fontWeight: FontWeight.w400)),
            //                     Text("Weekly Forecast",
            //                         style: TextStyle(
            //                             color: AppColors.cEBEBF5.withOpacity(0.6),
            //                             fontSize: 17,
            //                             fontWeight: FontWeight.w400)),
            //                   ],
            //                 ),
            //               ),
            //               Divider(
            //                 thickness: 3,
            //                 color: AppColors.cFFFFFF.withOpacity(0.5),
            //               ),
            //               const SizedBox(height: 3),
            //               SizedBox(
            //                 child: SizedBox(
            //                   height: 146,
            //                   child: ListView.builder(
            //                     shrinkWrap: true,
            //                     scrollDirection: Axis.horizontal,
            //                     itemCount: 12,
            //                     itemBuilder: (context, index) {
            //                       return Container(
            //                         width: 60,
            //                         margin:
            //                             const EdgeInsets.only(left: 15, right: 15),
            //                         padding: const EdgeInsets.all(1),
            //                         height: 30,
            //                         decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(25),
            //                             border: Border.all(
            //                                 width: 1, color: Colors.white)),
            //                         child: Column(
            //                           children: [
            //                             const SizedBox(height: 11),
            //                             Text(
            //                               "${index + 1} AM",
            //                               style: const TextStyle(
            //                                   fontSize: 17,
            //                                   fontWeight: FontWeight.w400,
            //                                   color: AppColors.cFFFFFF),
            //                             ),
            //                             SvgPicture.asset(AppImages.iconSunCloud),
            //                             Text("${-20 + ((index + 1) * 10)}%",
            //                                 style: const TextStyle(
            //                                     fontSize: 11,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: AppColors.c40CBD8)),
            //                             const SizedBox(height: 8),
            //                             Text("${19 + (index + 2)}°",
            //                                 style: const TextStyle(
            //                                     fontSize: 17,
            //                                     fontWeight: FontWeight.w400,
            //                                     color: AppColors.cFFFFFF))
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 18,
            //               ),
            //               isClicked == false
            //                   ? AnimatedContainer(
            //                       duration: const Duration(milliseconds: 400),
            //                       width: double.infinity,
            //                       height: 120,
            //                       padding: const EdgeInsets.only(left: 45, right: 50),
            //                       decoration: const BoxDecoration(
            //                         image: DecorationImage(
            //                             image:
            //                                 AssetImage(AppImages.imageNavigationBar),
            //                             fit: BoxFit.cover),
            //                       ),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           SvgPicture.asset(AppImages.iconMap),
            //                           Image.asset(AppImages.imageAddIcon),
            //                           SvgPicture.asset(AppImages.iconMenu),
            //                         ],
            //                       ),
            //                     )
            //                   : Column(
            //                       children: [
            //                         Padding(
            //                           padding:
            //                               const EdgeInsets.only(left: 20, right: 28),
            //                           child: Container(
            //                             width: double.infinity,
            //                             height: 158,
            //                             decoration: BoxDecoration(
            //                               border: Border.all(
            //                                   width: 1,
            //                                   color: const Color(0xff6F45C9)),
            //                               borderRadius: BorderRadius.circular(22),
            //                               color: const Color(0xff26234F),
            //                             ),
            //                             child: Column(
            //                               children: [
            //                                 Text(
            //                                   "AIR QUALITY",
            //                                   style: TextStyle(
            //                                       color: Color(0xff9392A8),
            //                                       fontSize: 18,
            //                                       fontWeight: FontWeight.w700),
            //                                 )
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //             ],
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}
