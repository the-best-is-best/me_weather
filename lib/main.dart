import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:me_weather/data/network/dio_manager.dart';
import 'app/app.dart';
import 'app/di.dart';
import 'services/my_bloc_observer.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initAppModel();
  DioManger.init();
  await GetStorage.init();
  Bloc.observer = MyBlocObserver();
  tz.initializeTimeZones();

  runApp(const MyApp());
}
