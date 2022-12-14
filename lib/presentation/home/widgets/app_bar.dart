import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/presentation/components/my_text.dart';
import 'package:mit_x/mit_x.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../../app/cubit/app_cubit.dart';
import 'search_app_bar.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final PageController pageController;
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppNeededLocationState) {
        focusNode.requestFocus();
      }
    }, builder: (context, state) {
      AppCubit appCubit = AppCubit.get(context);

      return BuildCondition(
          condition: state is! AppLoadDataState,
          builder: (context) {
            return BuildCondition(
              condition: appCubit.listWeather.isNotEmpty,
              builder: (context) {
                return AppBar(
                  centerTitle: true,
                  title: Column(
                    children: [
                      BlocBuilder<AppCubit, AppStates>(
                          builder: (context, state) {
                        return MyText(
                          title: appCubit.citiesUser[appCubit.currentCity],
                          style: getMediumStyle(color: Colors.white),
                        );
                      }),
                      const SizedBox(height: 10),
                      SmoothPageIndicator(
                        controller: widget.pageController,
                        count: appCubit.listWeather.length,
                        effect: const ScrollingDotsEffect(
                            activeDotColor: Colors.blue,
                            activeStrokeWidth: 2.6,
                            activeDotScale: 1.3,
                            maxVisibleDots: 5,
                            radius: 5,
                            spacing: 5,
                            dotHeight: 8,
                            dotWidth: 8,
                            fixedCenter: true),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      MitX.openDrawer();
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(appCubit.isFahrenheit
                          ? WeatherIcons.fahrenheit
                          : WeatherIcons.celsius),
                      onPressed: () async {
                        appCubit.changeToFahrenheit();
                      },
                    )
                  ],
                );
              },
              fallback: (context) =>
                  SearchWidget(focusNode: focusNode, appCubit: appCubit),
            );
          });
    });
  }
}
