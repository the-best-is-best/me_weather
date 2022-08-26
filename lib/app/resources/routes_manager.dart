import 'package:flutter/material.dart';
import 'package:me_weather/presentation/five_days_forecast/five_days_forecast.dart';
import 'package:me_weather/presentation/home/view/home_view.dart';
import 'package:mit_x/mit_x.dart';

class Routes {
  static const String main = "/";
  static const String fiveDaysForecast = "/FourDaysForecast";
}

class RoutesManager {
  static Route<dynamic>? getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return mitXMaterialPageRoute(page: const HomeView());
      case Routes.fiveDaysForecast:
        return mitXMaterialPageRoute(page: const FiveDaysForecastView());
    }
    return null;
  }
}
