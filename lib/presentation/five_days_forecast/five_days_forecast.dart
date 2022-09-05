import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/presentation/components/cached_image.dart';
import 'package:me_weather/presentation/components/my_text.dart';
import 'package:mit_x/mit_x.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/models/weather_model.dart';
import '../home/widgets/background_image.dart';

class FiveDaysForecastView extends StatelessWidget {
  const FiveDaysForecastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            Positioned(
              top: 5,
              left: 5,
              child: Column(
                children: [
                  BackButton(onPressed: () {
                    MitX.back();
                  })
                ],
              ),
            ),
            Positioned(
              top: 80,
              left: 20,
              child: Column(
                children: [
                  MyText(
                    title: '5-Days Forecast',
                    style: getSemiBoldStyle(),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<AppCubit, AppStates>(
                        builder: (context, state) {
                          AppCubit appCubit = AppCubit.get(context);

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: appCubit
                                              .listForcastByDaysWeather.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            WeatherModel weatherData = appCubit
                                                    .listForcastByDaysWeather[
                                                index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Column(
                                                children: [
                                                  CachedImage(
                                                    url: weatherData.iconImage,
                                                    width: 45,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Builder(builder: (context) {
                                  double minTemp = appCubit.isFahrenheit
                                      ? appCubit.listForcastByDaysWeather
                                          .reduce((value, element) {
                                            if (value.temp < element.temp) {
                                              return value;
                                            } else {
                                              return element;
                                            }
                                          })
                                          .temp
                                          .kelvinTFahrenheit()
                                          .toDouble()
                                      : appCubit.listForcastByDaysWeather
                                          .reduce((value, element) {
                                            if (value.temp < element.temp) {
                                              return value;
                                            } else {
                                              return element;
                                            }
                                          })
                                          .temp
                                          .kelvinToCelsius()
                                          .toDouble();
                                  return SfCartesianChart(
                                    primaryXAxis: CategoryAxis(
                                      labelStyle: getRegularStyle(
                                          fontSize: FontSize.s20),
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                    ),
                                    primaryYAxis: CategoryAxis(
                                      labelStyle: getRegularStyle(
                                          fontSize: FontSize.s20),
                                      visibleMinimum: minTemp - 1,
                                      labelPlacement:
                                          LabelPlacement.betweenTicks,
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                      multiLevelLabelStyle:
                                          MultiLevelLabelStyle(
                                              textStyle: getRegularStyle(),
                                              borderColor: Colors.amber),
                                    ),
                                    borderColor: Colors.transparent,
                                    plotAreaBorderColor: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    series: <CartesianSeries>[
                                      LineSeries<WeatherModel, String>(
                                        dataSource:
                                            appCubit.listForcastByDaysWeather,
                                        xValueMapper:
                                            (WeatherModel weatherData, index) =>
                                                index == 0
                                                    ? "Today"
                                                    : index == 1
                                                        ? 'Tomorrow'
                                                        : DateFormat('dd-MM')
                                                            .format(weatherData
                                                                .dateTime),
                                        yValueMapper:
                                            (WeatherModel weatherData, _) =>
                                                appCubit.isFahrenheit
                                                    ? weatherData.temp
                                                        .kelvinTFahrenheit()
                                                        .round()
                                                    : weatherData.temp
                                                        .kelvinToCelsius()
                                                        .round(),
                                        name: '',
                                        color: Colors.white,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: true,
                                          alignment: ChartAlignment.center,
                                          opacity: 20,
                                          labelPosition:
                                              ChartDataLabelPosition.outside,
                                          labelAlignment:
                                              ChartDataLabelAlignment.top,
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        markerSettings: const MarkerSettings(
                                            isVisible: true, width: 6),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
