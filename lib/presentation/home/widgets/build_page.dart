// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:me_weather/app/extensions/extension_date.dart';
import 'package:me_weather/app/extensions/extension_int.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/domain/models/weather_model.dart';
import 'package:me_weather/presentation/components/loading_indicator.dart';
import 'package:mit_x/mit_x.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_states.dart';
import '../../components/my_text.dart';
import 'app_bar.dart';

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
    appCubit.getWeatherDataByCounty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      AppCubit appCubit = AppCubit.get(context);

      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: HomeAppBar(
              pageController: pageController,
            )),
        body: BuildCondition(
            condition:
                AppCubit.citiesData.isNotEmpty || state is! AppLoadedState,
            builder: (context) {
              return Builder(builder: (context) {
                return BuildCondition(
                    condition: state is! AppLoadDataState,
                    fallback: (context) => const LoadingIndicator(),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: context.height,
                                child: PageView.builder(
                                    onPageChanged: (value) {
                                      appCubit.changeCurrentCity(value);
                                    },
                                    itemBuilder: (context, index) {
                                      WeatherModel weatherData =
                                          appCubit.listWeather[index];
                                      WeatherModel tommorowWeather = appCubit
                                          .listForcastWeather[index]!
                                          .firstWhere(
                                        (element) => element.dateTime.isAfter(
                                          element.dateTime
                                              .add(Duration(hours: 3)),
                                        ),
                                      );

                                      return Column(
                                        children: [
                                          Center(
                                            child: MyText(
                                                title: weatherData.dateTime
                                                    .toTimeString()),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Column(children: [
                                              MyText(
                                                title: weatherData.temp
                                                    .kelvinToCelsiusString(),
                                                style: getBoldStyle(
                                                    color: Colors.white,
                                                    fontSize: 100.sp),
                                              ),
                                              const SizedBox(height: 50),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CachedImage(
                                                      url: weatherData
                                                          .iconImage),
                                                  const SizedBox(width: 0),
                                                  MyText(
                                                    title:
                                                        weatherData.description,
                                                    style: getMediumStyle(),
                                                  ),
                                                  const Spacer(),
                                                  MyText(
                                                    // ignore: unnecessary_string_interpolations
                                                    title: '${weatherData.tempMax.kelvinToCelsiusString()}' +
                                                        ' / ${weatherData.tempMin.kelvinToCelsiusString()}',
                                                    style: getMediumStyle(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        'http://openweathermap.org/img/w/10d.png',
                                                    height: 50,
                                                  ),
                                                  const SizedBox(width: 0),
                                                  MyText(
                                                    title:
                                                        weatherData.description,
                                                    style: getMediumStyle(),
                                                  ),
                                                  const Spacer(),
                                                  MyText(
                                                    // ignore: unnecessary_string_interpolations
                                                    title: '${weatherData.tempMax.kelvinToCelsiusString()}' +
                                                        ' / ${weatherData.tempMin.kelvinToCelsiusString()}',
                                                    style: getMediumStyle(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: context.width * .90,
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    child: const MyText(
                                                      title: '4-day forecast',
                                                    )),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      );
                                    },
                                    controller: pageController,
                                    itemCount: appCubit.listWeather.length),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              });
            }),
      );
    });
  }
}

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.url,
    this.width = 50,
  }) : super(key: key);

  final String url;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
    );
  }
}
