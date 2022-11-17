import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:wheather_app_clone/data/models/helper/lat_lon.dart';
import 'package:wheather_app_clone/data/models/weather_main_model.dart';
import 'package:wheather_app_clone/data/repository/app_repository.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/images.dart';
import 'package:wheather_app_clone/widgets/listview_widget.dart';
import 'package:wheather_app_clone/widgets/text_widget.dart';

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
            // FutureBuilder<WeatherMainModel>(
            //     future: AppRepository.getWeatherMainDataByQuery(
            //       query: "Olmazor",
            //     ),
            //     builder: (context, AsyncSnapshot<WeatherMainModel> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator.adaptive(),
            //         );
            //       }
            //       if (snapshot.hasData) {
            //         var data = snapshot.data!;
            //         return Text("Data: ${data.name}");
            //       } else {
            //         return Text("Error:${snapshot.error.toString()}");
            //       }
            //     }),
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
                      return Expanded(
                        child: Column(children: [
                          const SizedBox(height: 86),
                          textWidget(context, name: data.name, color: AppColors.cFFFFFF, fontWeight: FontWeight.w400, fontsize: 34.0),
                          textWidget(context, name: "${data.mainInMain.temp.round()}", color: AppColors.cFFFFFF, fontWeight: FontWeight.w200, fontsize: 96.0),
                          textWidget(context, name: data.weatherModel[0].description, color: AppColors.cFFFFFF.withOpacity(0.4), fontWeight: FontWeight.w600, fontsize: 20.0),
                          textWidget(context, name: "H:24° L:18°", color: AppColors.cFFFFFF, fontWeight: FontWeight.w600, fontsize: 20.0),
                          const Spacer(),
                          Container(
                            height: 390,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.c2E335A.withOpacity(0.9),
                                      AppColors.c1C1B33.withOpacity(1),
                                    ])),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 120, left: 120),
                                    width: 45,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.c000000
                                          .withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: DefaultTabController(
                                    length: 2,
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                    child: Column(
                                      children: [
                                        TabBar(
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50), // Creates border
                                                color: Colors.greenAccent),
                                            labelColor: AppColors.cFFFFFF,
                                            unselectedLabelColor: AppColors
                                                .cEBEBF5
                                                .withOpacity(0.6),
                                            tabs: const [
                                              Tab(
                                                  child: Text(
                                                      "Hourly Forecast",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 17,
                                                      ))),
                                              Tab(
                                                  child: Text(
                                                      "Weekly Forecast",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 17,
                                                      ))),
                                            ]),
                                        Divider(
                                          thickness: 1,
                                          color: AppColors.cFFFFFF
                                              .withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 3),
                                        SizedBox(
                                          height: 146,
                                          child: TabBarView(
                                            children: [
                                              listViewWidget(context, temp: data.mainInMain.temp),
                                              listViewWidget(context, temp: data.mainInMain.temp),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: double.infinity,
                                  height: 120,
                                  padding: const EdgeInsets.only(
                                      left: 45, right: 50),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            AppImages.imageNavigationBar),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(AppImages.iconMap),
                                      Image.asset(AppImages.imageAddIcon),
                                      SvgPicture.asset(AppImages.iconMenu),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      );
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
          ],
        ),
      ),
    );
  }
}
