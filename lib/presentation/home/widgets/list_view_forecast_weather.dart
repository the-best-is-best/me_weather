import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
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
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: appCubit.listForcastWeather[appCubit.currentCity]!.length,
        itemBuilder: (context, index) {
          List<WeatherModel> weatherData =
              appCubit.listForcastWeather[appCubit.currentCity]!;
          return Column(
            children: [
              MyText(
                  title:
                      "${DateFormat('HH').format(weatherData[index].dateTime)} :00"),
              const SizedBox(height: 5),
              MyText(title: weatherData[index].temp.kelvinToCelsiusString()),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                      weatherData[index].windDeg >= 0 &&
                              weatherData[index].windDeg < 25
                          ? WeatherIcons.wind_deg_0
                          : weatherData[index].windDeg >= 25 &&
                                  weatherData[index].windDeg <= 75
                              ? WeatherIcons.wind_deg_45
                              : weatherData[index].windDeg > 75 &&
                                      weatherData[index].windDeg <= 120
                                  ? WeatherIcons.wind_deg_135
                                  : weatherData[index].windDeg > 125 &&
                                          weatherData[index].windDeg <= 165
                                      ? WeatherIcons.wind_deg_180
                                      : weatherData[index].windDeg > 165 &&
                                              weatherData[index].windDeg <= 210
                                          ? WeatherIcons.wind_deg_225
                                          : weatherData[index].windDeg > 210 &&
                                                  weatherData[index].windDeg <=
                                                      245
                                              ? WeatherIcons.wind_deg_270
                                              : WeatherIcons.wind_deg_315,
                      size: 20),
                  const SizedBox(width: 5),
                  MyText(
                    title: weatherData[index].windSpeed.msToKM(),
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
