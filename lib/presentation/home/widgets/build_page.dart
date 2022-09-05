import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:me_weather/app/extensions/extension_date.dart';
import 'package:me_weather/app/extensions/extension_num.dart';
import 'package:me_weather/app/resources/font_manager.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/domain/models/weather_model.dart';
import 'package:me_weather/presentation/components/loading_indicator.dart';
import 'package:me_weather/presentation/components/my_input_field.dart';
import 'package:me_weather/presentation/search/view/search_view.dart';
import 'package:me_weather/presentation/home/widgets/weather_details.dart';
import 'package:mit_x/mit_x.dart';
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
        drawer: MyDrawer(
          pageController: pageController,
        ),
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

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue[300],
      child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              title: 'Manage cities',
              style: getMediumStyle(),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
            final AppCubit appCubit = AppCubit.get(context);
            return Column(
              children: [
                SearchWidget(appCubit: appCubit),
                const SizedBox(height: 15),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: appCubit.listWeather.length,
                  itemBuilder: (context, index) {
                    WeatherModel weatherData = appCubit.listWeather[index];
                    return GestureDetector(
                      key: ValueKey(weatherData),
                      onTap: () {
                        widget.pageController.jumpToPage(index);
                        MitX.back();
                      },
                      child: Dismissible(
                        key: ValueKey(weatherData),
                        onDismissed: (direction) =>
                            appCubit.deleteWeather(weatherData.cityName),
                        child: CardSearch(weatherData: weatherData),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;

                      appCubit.changeListWeather(oldIndex, newIndex);
                    });
                  },
                ),
              ],
            );
          })
        ]),
      ),
    );
  }
}

class CardSearch extends StatelessWidget {
  const CardSearch({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel weatherData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SizedBox(
          width: context.width * .7,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  title: weatherData.cityName,
                  style: getMediumStyle(),
                ),
                MyText(
                  title: weatherData.temp.kelvinToCelsiusString(),
                  style: getBoldStyle(),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Column(
                  children: [
                    MyText(
                      title: weatherData.tempMin.kelvinToCelsiusString(),
                      style: getLightStyle(),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    child: MyText(title: '/'),
                  ),
                ),
                Column(
                  children: [
                    MyText(
                      title: weatherData.tempMax.kelvinToCelsiusString(),
                      style: getLightStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    required this.appCubit,
  }) : super(key: key);

  final AppCubit appCubit;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
      child: Center(
        child: MyTextField(
          hintText: 'Search',
          keyboardType: TextInputType.none,
          onTap: () {
            MitX.to(const SearchView());
          },
        ),
      ),
    );
  }
}
