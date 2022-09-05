import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/presentation/components/cached_image.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../domain/models/weather_model.dart';
import '../../components/my_text.dart';

class ListViewForecastWeather extends StatelessWidget {
  const ListViewForecastWeather({
    Key? key,
    required this.appCubit,
  }) : super(key: key);

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount:
            appCubit.listForcastWeather[appCubit.currentCity]?.length ?? 0,
        itemBuilder: (context, index) {
          List<WeatherModel> weatherData =
              appCubit.listForcastWeather[appCubit.currentCity]!;
          return Column(
            children: [
              MyText(
                title:
                    "${DateFormat('d/M h a').format(weatherData[index].dateTime)} ",
                style: getLightStyle(),
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  SizedBox(
                    width: getRegularStyle().fontSize! + 50.w,
                    child: MyText(
                        title: appCubit.isFahrenheit
                            ? weatherData[index]
                                .temp
                                .kelvinTFahrenheit()
                                .round()
                                .toString()
                            : weatherData[index]
                                .temp
                                .kelvinToCelsius()
                                .round()
                                .toString()),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Center(
                      child: MyText(
                        title: appCubit.isFahrenheit ? '\u00B0F' : '\u00B0C',
                        style: getLightStyle(fontSize: FontSize.s16.sp),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              CachedImage(url: weatherData[index].iconImage, width: 40),
              const SizedBox(height: 5),
              Row(
                children: [
                  Builder(builder: (context) {
                    return Icon(
                        weatherData[index].windDeg >= 0 &&
                                weatherData[index].windDeg < 25
                            ? WeatherIcons.wind_deg_180
                            : weatherData[index].windDeg >= 25 &&
                                    weatherData[index].windDeg <= 75
                                ? WeatherIcons.wind_deg_225
                                : weatherData[index].windDeg > 75 &&
                                        weatherData[index].windDeg <= 120
                                    ? WeatherIcons.wind_deg_315
                                    : weatherData[index].windDeg > 125 &&
                                            weatherData[index].windDeg <= 165
                                        ? WeatherIcons.wind_deg_315
                                        : weatherData[index].windDeg > 165 &&
                                                weatherData[index].windDeg <=
                                                    200
                                            ? WeatherIcons.wind_deg_0
                                            : weatherData[index].windDeg >
                                                        200 &&
                                                    weatherData[index]
                                                            .windDeg <=
                                                        245
                                                ? WeatherIcons.wind_deg_45
                                                : weatherData[index].windDeg >
                                                            245 &&
                                                        weatherData[index]
                                                                .windDeg <
                                                            290
                                                    ? WeatherIcons.wind_deg_90
                                                    : weatherData[index]
                                                                    .windDeg >
                                                                290 &&
                                                            weatherData[index]
                                                                    .windDeg <
                                                                340
                                                        ? WeatherIcons
                                                            .wind_deg_135
                                                        : WeatherIcons
                                                            .wind_deg_180,
                        size: 20);
                  }),
                  const SizedBox(width: 5),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: MyText(
                      title: weatherData[index].windSpeed.msToKM(),
                      style: getLightStyle(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
      ),
    );
  }
}
