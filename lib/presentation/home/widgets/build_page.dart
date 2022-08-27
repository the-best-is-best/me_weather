import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/extensions/extension_date.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/domain/models/weather_model.dart';
import 'package:me_weather/presentation/components/loading_indicator.dart';
import 'package:me_weather/presentation/home/widgets/weather_details.dart';
import 'package:mit_x/mit_x.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_states.dart';
import '../../components/my_text.dart';
import 'app_bar.dart';
import 'list_view_forecast_weather.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    AppCubit appCubit = AppCubit.get(context);
    appCubit.getWeatherDataByYourLocation();
    //appCubit.getWeatherDataByCounty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      AppCubit appCubit = AppCubit.get(context);

      return Scaffold(
        key: MitX.scaffoldKey,
        drawer: Drawer(),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: HomeAppBar(
              pageController: pageController,
            )),
        body: BuildCondition(
          condition: AppCubit.citiesData.isNotEmpty || state is! AppLoadedState,
          builder: (context) {
            return Builder(builder: (context) {
              return BuildCondition(
                  condition: state is! AppLoadDataState,
                  fallback: (context) => const LoadingIndicator(),
                  builder: (context) {
                    return BuildCondition(
                      condition: appCubit.listWeather.isNotEmpty,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                    onPageChanged: (value) {
                                      appCubit.changeCurrentCity(value);
                                    },
                                    itemBuilder: (context, index) {
                                      WeatherModel currentWeather =
                                          appCubit.listWeather[index];
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: MyText(
                                                  title: currentWeather.dateTime
                                                      .toTimeString()),
                                            ),
                                            const SizedBox(height: 50),
                                            MyText(
                                              title: currentWeather.temp
                                                  .kelvinToCelsiusString(),
                                              style: getBoldStyle(
                                                  color: Colors.white,
                                                  fontSize: 100.sp),
                                            ),
                                            WeatherDetails(appCubit: appCubit),
                                            const SizedBox(height: 25),
                                            ListViewForecastWeather(
                                                appCubit: appCubit),
                                            const SizedBox(height: 25),
                                            Builder(builder: (context) {
                                              WeatherModel weatherData =
                                                  appCubit.listWeather[
                                                      appCubit.currentCity];
                                              return Card(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
                                                  child: Column(children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        MyText(
                                                            title:
                                                                'Sunrise ${weatherData.sunrise!.toTime()}'),
                                                        MyText(
                                                            title:
                                                                'Sunset ${weatherData.sunset!.toTime()}'),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const MyText(
                                                                title:
                                                                    'Real Feel'),
                                                            const SizedBox(
                                                                height: 5),
                                                            MyText(
                                                              title: weatherData
                                                                  .feelsLike
                                                                  .kelvinToCelsiusString(),
                                                              style:
                                                                  getMediumStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Column(
                                                          children: [
                                                            const MyText(
                                                                title:
                                                                    'Humidity'),
                                                            const SizedBox(
                                                                height: 5),
                                                            MyText(
                                                              title:
                                                                  '${weatherData.humidity} %',
                                                              style:
                                                                  getMediumStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const MyText(
                                                                title:
                                                                    'Wind Speed'),
                                                            const SizedBox(
                                                                height: 5),
                                                            MyText(
                                                              title: weatherData
                                                                  .windSpeed
                                                                  .msToKM(),
                                                              style:
                                                                  getMediumStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Column(
                                                          children: [
                                                            const MyText(
                                                                title:
                                                                    'Pressure'),
                                                            const SizedBox(
                                                                height: 5),
                                                            MyText(
                                                              title:
                                                                  '${weatherData.pressure} mbar',
                                                              style:
                                                                  getMediumStyle(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10)
                                                  ]),
                                                ),
                                              );
                                            }),
                                            const SizedBox(height: 10)
                                          ],
                                        ),
                                      );
                                    },
                                    controller: pageController,
                                    itemCount: appCubit.listWeather.length),
                              ),
                            ],
                          ),
                        );
                      },
                      fallback: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15),
                          child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                appCubit.getWeatherDataByCounty(
                                    appCubit.searchCity[index].city);
                              },
                              child: SizedBox(
                                width: context.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title: appCubit.searchCity[index].city,
                                      style: getMediumStyle(
                                          fontSize: FontSize.s30),
                                    ),
                                    const SizedBox(height: 5),
                                    MyText(
                                        title:
                                            appCubit.searchCity[index].timezone,
                                        style: getRegularStyle()),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: appCubit.searchCity.length,
                          ),
                        );
                      },
                    );
                  });
            });
          },
        ),
      );
    });
  }
}
