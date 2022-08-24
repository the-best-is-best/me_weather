import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/routes_manager.dart';
import 'package:mit_x/mit_x.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/resources/styles_manger.dart';
import '../../../domain/models/weather_model.dart';
import '../../components/cached_image.dart';
import '../../components/my_text.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    Key? key,
    required this.appCubit,
  }) : super(key: key);

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              WeatherModel weatherData = appCubit.listThreeDayWeather[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedImage(url: weatherData.iconImage),
                      const SizedBox(width: 0),
                      MyText(
                        title:
                            "${index == 0 ? 'Today' : index == 1 ? 'Tomorrow' : DateFormat('E, d').format(weatherData.dateTime)}: ${weatherData.description}",
                        style: getRegularStyle(fontSize: 12),
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
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: appCubit.listThreeDayWeather.length),
        const SizedBox(height: 10),
        SizedBox(
          width: context.width * .90,
          child: ElevatedButton(
              onPressed: () {
                MitX.toNamed(Routes.fiveDaysForecast);
              },
              child: const MyText(
                title: '5-day forecast',
              )),
        ),
      ]),
    );
  }
}
