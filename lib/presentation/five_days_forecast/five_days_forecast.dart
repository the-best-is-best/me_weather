import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () {
                    MitX.back();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0) +
                      const EdgeInsets.only(top: 12.0),
                  child: Column(
                    children: [
                      MyText(
                        title: '5-Days Forecast',
                        style: getSemiBoldStyle(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<AppCubit, AppStates>(
                        builder: (context, state) {
                          AppCubit appCubit = AppCubit.get(context);
                          return SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              labelStyle:
                                  getRegularStyle(fontSize: FontSize.s20),
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: CategoryAxis(
                              labelStyle: getRegularStyle(),
                              visibleMinimum: 25,
                              labelPlacement: LabelPlacement.betweenTicks,
                              majorGridLines: const MajorGridLines(width: 0),
                              multiLevelLabelStyle: MultiLevelLabelStyle(
                                  textStyle: getRegularStyle(),
                                  borderColor: Colors.amber),
                            ),
                            margin: const EdgeInsets.only(top: 120),
                            borderColor: Colors.transparent,
                            plotAreaBorderColor: Colors.transparent,
                            series: <CartesianSeries>[
                              LineSeries<WeatherModel, String>(
                                dataSource: appCubit.listForcastByDaysWeather,
                                xValueMapper: (WeatherModel weatherData,
                                        index) =>
                                    index == 0
                                        ? "Today"
                                        : index == 1
                                            ? 'Tomorrow'
                                            : DateFormat('dd-MM')
                                                .format(weatherData.dateTime),
                                yValueMapper: (WeatherModel weatherData, _) =>
                                    weatherData.temp.kelvinToCelsius().round(),
                                name: '',
                                color: Colors.white,
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  alignment: ChartAlignment.center,
                                  opacity: 20,
                                  labelPosition: ChartDataLabelPosition.outside,
                                  labelAlignment: ChartDataLabelAlignment.top,
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
