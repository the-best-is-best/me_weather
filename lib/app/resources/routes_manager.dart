import 'package:flutter/material.dart';
import 'package:me_weather/presentation/home/view/home_view.dart';

class Routes {
  static const String main = "/";
}

class RoutesManager {
  static Route<dynamic>? getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeView());
    }
    return null;
  }
}
