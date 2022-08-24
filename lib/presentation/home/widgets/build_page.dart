import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:me_weather/app/extensions/extension_date.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
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
                                height: MitX.height,
                                child: PageView.builder(
                                    onPageChanged: (value) {
                                      appCubit.changeCurrentCity(value);
                                    },
                                    itemBuilder: (context, index) {
                                      WeatherModel currentWeather =
                                          appCubit.listWeather[index];
                                      return Column(
                                        children: [
                                          Center(
                                            child: MyText(
                                                title: currentWeather.dateTime
                                                    .toTimeString()),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyText(
                                                  title:
                                                      'Sunrise ${currentWeather.sunrise!.toTime()}'),
                                              MyText(
                                                  title:
                                                      'sunset ${currentWeather.sunset!.toTime()}')
                                            ],
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
                                              appCubit: appCubit)
                                        ],
                                      );
                                    },
                                    controller: pageController,
                                    itemCount: appCubit.listWeather.length),
                              ),
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
                  title: index == 0
                      ? 'Now'
                      : DateFormat('hh').format(weatherData[index].dateTime)),
              const SizedBox(height: 5),
              MyText(title: weatherData[index].temp.kelvinToCelsiusString()),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                      weatherData[index].deg >= 0 && weatherData[index].deg < 25
                          ? WeatherIcons.wind_deg_0
                          : weatherData[index].deg >= 25 &&
                                  weatherData[index].deg <= 75
                              ? WeatherIcons.wind_deg_45
                              : weatherData[index].deg > 75 &&
                                      weatherData[index].deg <= 120
                                  ? WeatherIcons.wind_deg_135
                                  : weatherData[index].deg > 125 &&
                                          weatherData[index].deg <= 165
                                      ? WeatherIcons.wind_deg_180
                                      : weatherData[index].deg > 165 &&
                                              weatherData[index].deg <= 210
                                          ? WeatherIcons.wind_deg_225
                                          : weatherData[index].deg > 210 &&
                                                  weatherData[index].deg <= 245
                                              ? WeatherIcons.wind_deg_270
                                              : WeatherIcons.wind_deg_315,
                      size: 20),
                  const SizedBox(width: 5),
                  MyText(
                    title:
                        '${(weatherData[index].speed / 1000 * 60 * 60).round()} km/h',
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
