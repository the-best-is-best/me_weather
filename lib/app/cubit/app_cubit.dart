import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/data/mapper/forcast_weather_response_mapper.dart';
import 'package:me_weather/data/mapper/weather_response_mapper.dart';
import 'package:me_weather/data/responses/forcast_weather_response.dart';
import 'package:me_weather/data/responses/get_weather_response.dart';
import 'package:me_weather/domain/models/city_model.dart';
import 'package:me_weather/domain/models/weather_model.dart';
import 'package:me_weather/domain/use_case/get_five_days_three_hours_forcast_data_by_location.dart';
import 'package:me_weather/domain/use_case/get_forcast_weather_by_country_name_use_case.dart';
import 'package:me_weather/domain/use_case/get_weather_by_country_name_use_case.dart';
import 'package:me_weather/domain/use_case/get_weather_data_by_location.dart';
import 'package:me_weather/gen/assets.gen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mit_x/mit_x.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(
      this.box,
      this._weatherByCountryNameUseCase,
      this._weatherForcastByCountryNameUseCase,
      this._weatherByLocationUseCase,
      this._weatherForcastByLocationUseCase)
      : super(AppInitialState());
  final GetStorage box;
  final GetWeatherByCountryNameUseCase _weatherByCountryNameUseCase;
  final GetWeatherDataByLocationUseCase _weatherByLocationUseCase;
  final GetForcastWeatherByCountryNameUseCase
      _weatherForcastByCountryNameUseCase;
  final GetFiveDaysThreeHoursForcastDataByLocationUseCase
      _weatherForcastByLocationUseCase;

  static AppCubit get(BuildContext context) => context.read<AppCubit>();

  static List<CityModel> citiesData = [];

  List<WeatherModel> listWeather = [];

  List<WeatherModel> listThreeDayWeather = [];

  Map<int, List<WeatherModel>> listForcastWeather = {};

  List<WeatherModel> listForcastByDaysWeather = [];

  int currentCity = 0;

  void changeCurrentCity(int index) {
    currentCity = index;
    getListThreeDaysWeather();
    emit(AppChangeCountryState());
  }

  void getListThreeDaysWeather() {
    listThreeDayWeather = [];
    listForcastByDaysWeather = [];
    int maxDays = 2;
    listThreeDayWeather.add(listWeather[currentCity]);
    listForcastByDaysWeather.add(listWeather[currentCity]);

    for (int days = 1; days <= maxDays; days++) {
      WeatherModel nextDayWeather = listForcastWeather[currentCity]!.firstWhere(
          (element) =>
              element.dateTime.day ==
              listWeather[currentCity].dateTime.day + days);

      listThreeDayWeather.add(nextDayWeather);
    }
    maxDays = 4;
    // get Weather Three Days

    for (int days = 1; days <= maxDays; days++) {
      WeatherModel? nextDayWeather = listForcastWeather[currentCity]
          ?.firstWhere((element) =>
              element.dateTime.day ==
                  listWeather[currentCity].dateTime.day + days &&
              element.dateTime.hour >= listWeather[currentCity].dateTime.hour);

      listForcastByDaysWeather.add(nextDayWeather!);
    }
  }

  void loadDataCites() async {
    if (citiesData.isEmpty) {
      emit(AppLoadAppDataState());

      List<dynamic> cityMapJson = json.decode(
          await DefaultAssetBundle.of(MitX.context!)
              .loadString(const $AssetsJsonGen().cityMap));
      for (var city in cityMapJson) {
        citiesData.add(CityModel.fromJson(city));
      }
    }
    emit(AppLoadedState());
  }

  void getWeatherDataByYourLocation() async {
    // emit(AppLoadDataState());
    // if (listWeather.isEmpty) {
    //   try {
    //     Position yourPosition = await getGeoLocationPosition();
    //     var response = await _weatherByLocationUseCase.execute(
    //         GetWeatherDataByLocationUseCaseInput(
    //             yourPosition.longitude.toString(),
    //             yourPosition.latitude.toString()));
    //     response.fold((err) => emit(AppErrorState(err.messages)), (data) async {
    //       listWeather.add(data);
    //       var response1 = await _weatherForcastByLocationUseCase.execute(
    //           GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput(
    //               yourPosition.longitude.toString(),
    //               yourPosition.latitude.toString()));
    //       response1.fold(
    //         (error) => emit(
    //           AppErrorState(error.messages),
    //         ),
    //         (data) {
    //           listForcastWeather.addAll(data);
    //           emit(AppLoadedDataState());
    //         },
    //       );
    //     });
    //   } catch (ex) {
    //     emit(AppNeededLocationState());
    //   }
    // }
  }

  void getWeatherDataByCounty() async {
    // load from local data
    emit(AppLoadDataState());
    Map<String, dynamic> egyptWeather = json.decode(
        await DefaultAssetBundle.of(MitX.context!)
            .loadString(const $AssetsJsonGen().weatherEgypt));
    listWeather.add(GetWeatherResponse.fromJson(egyptWeather).toDomain());

    Map<String, dynamic> newYorkYWeather = json.decode(
        await DefaultAssetBundle.of(MitX.context!)
            .loadString(const $AssetsJsonGen().weatherNewYork));
    listWeather.add(GetWeatherResponse.fromJson(newYorkYWeather).toDomain());

    Map<String, dynamic> egyptWeatherForcast = json.decode(
        await DefaultAssetBundle.of(MitX.context!)
            .loadString(const $AssetsJsonGen().egyptForecast));
    listForcastWeather.addAll(
        {0: ForcastWeatherResponse.fromJson(egyptWeatherForcast).toDomain()});

    Map<String, dynamic> newYorkWeatherForcast = json.decode(
        await DefaultAssetBundle.of(MitX.context!)
            .loadString(const $AssetsJsonGen().newYorkForecast));
    listForcastWeather.addAll(
        {1: ForcastWeatherResponse.fromJson(newYorkWeatherForcast).toDomain()});
    getListThreeDaysWeather();

    emit(AppLoadedDataState());
  }
}
