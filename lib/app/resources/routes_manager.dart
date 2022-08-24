import 'package:flutter/material.dart';
import 'package:me_weather/presentation/home/view/home_view.dart';
import '../../presentation/five_days_forecast/five_days_forecast.dart';

class Routes {
  static const String main = "/";
  static const String fiveDaysForecast = "/FourDaysForecast";
}

class RoutesManager {
  static Route<dynamic>? getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case Routes.fiveDaysForecast:
        return MaterialPageRoute(
            builder: (context) => const FiveDaysForecastView());
    }
    return null;
  }
}
