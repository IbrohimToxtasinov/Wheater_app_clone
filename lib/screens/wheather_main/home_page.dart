import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheather_app_clone/data/models/detail/one_call_data.dart';
import 'package:wheather_app_clone/data/models/helper/lat_lon.dart';
import 'package:wheather_app_clone/data/models/weather_main_model.dart';
import 'package:wheather_app_clone/data/repository/app_repository.dart';
import 'package:wheather_app_clone/utils/colors.dart';
import 'package:wheather_app_clone/utils/images.dart';
import 'package:wheather_app_clone/utils/time_utils.dart';
import 'package:wheather_app_clone/widgets/listview_widget.dart';
import 'package:wheather_app_clone/widgets/serch_delegated.dart';
import 'package:wheather_app_clone/widgets/text_widget.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({Key? key, required this.latLong}) : super(key: key);

  final LatLong latLong;

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  String query = "";
  OneCallData? oneCallData;
  WeatherMainModel? weatherMainModel;

  @override
  void initState() {
    _initialData();
    super.initState();
  }

  _initialData() async {
    try {
      weatherMainModel =
          await AppRepository.getWeatherMainDataByQuery(query: "Olmazor");
    } catch (err) {}
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
                future: query.isEmpty
                    ? AppRepository.getWeatherMainDataByLocation(
                        latLong: widget.latLong,
                      )
                    : AppRepository.getWeatherMainDataByQuery(query: query),
                builder: (context, AsyncSnapshot<WeatherMainModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Column(children: [
                      const SizedBox(height: 86),
                      textWidget(context,
                          name: data.name,
                          color: AppColors.cFFFFFF,
                          fontWeight: FontWeight.w400,
                          fontsize: 34.0),
                      textWidget(context,
                          name: "${data.mainInMain.temp.round()}°",
                          color: AppColors.cFFFFFF,
                          fontWeight: FontWeight.w200,
                          fontsize: 96.0),
                      textWidget(context,
                          name: data.weatherModel[0].main,
                          color: AppColors.cFFFFFF.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                          fontsize: 20.0),
                      textWidget(context,
                          name: "H:24° L:18°",
                          color: AppColors.cFFFFFF,
                          fontWeight: FontWeight.w600,
                          fontsize: 20.0),
                    ]);
                  } else {
                    return Text("Error:${snapshot.error.toString()}");
                  }
                }),
            const Spacer(),
            FutureBuilder<OneCallData>(
              future:
                  AppRepository.getHourlyDailyWeather(latLong: widget.latLong),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (snapshot.hasData) {
                  oneCallData = snapshot.data!;
                  return Container(
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
                            margin:
                                const EdgeInsets.only(right: 120, left: 120),
                            width: 45,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.c000000.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: DefaultTabController(
                            length: 2,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                TabBar(
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            50), // Creates border
                                        color: Colors.greenAccent),
                                    labelColor: AppColors.cFFFFFF,
                                    unselectedLabelColor:
                                        AppColors.cEBEBF5.withOpacity(0.6),
                                    tabs: const [
                                      Tab(
                                          child: Text("Hourly Forecast",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                              ))),
                                      Tab(
                                          child: Text("Weekly Forecast",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                              ))),
                                    ]),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.cFFFFFF.withOpacity(0.5),
                                ),
                                const SizedBox(height: 3),
                                SizedBox(
                                  height: 146,
                                  child: TabBarView(
                                    children: [
                                      listViewhourlyWidget(context,
                                          hourly: oneCallData!.hourly),
                                      listViewdailyWidget(context,
                                          daily: oneCallData!.daily),
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
                          padding: const EdgeInsets.only(left: 45, right: 50),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.imageNavigationBar),
                                fit: BoxFit.cover),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(AppImages.iconMap),
                              Image.asset(AppImages.imageAddIcon),
                              InkWell(
                                  child: SvgPicture.asset(AppImages.iconMenu),
                                  onTap: () async {
                                    var searchText = await showSearch(
                                      context: context,
                                      delegate: SearchDelegateView(
                                          suggestionList:
                                              TimeUtils.getPlaceNames()),
                                    );
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Text("Error:${snapshot.error.toString()}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
