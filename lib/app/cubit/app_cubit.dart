import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/domain/models/city_model.dart';
import 'package:me_weather/domain/models/weather_model.dart';
import 'package:me_weather/domain/use_case/get_five_days_three_hours_forcast_data_by_location.dart';
import 'package:me_weather/domain/use_case/get_forcast_weather_by_country_name_use_case.dart';
import 'package:me_weather/domain/use_case/get_weather_by_country_name_use_case.dart';
import 'package:me_weather/domain/use_case/get_weather_data_by_location.dart';
import 'package:me_weather/gen/assets.gen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mit_x/mit_x.dart';

import '../../services/location_services.dart';

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

// city
  void changeCurrentCity(int index) {
    currentCity = index;
    _getListForcastByDaysWeather();
    emit(AppChangeCountryState());
  }

  String searchTextController = "";
  List<CityModel> searchCity = [];
  void searchForCity(String city) {
    emit(AppSearchCityState());
    searchCity = [];
    searchTextController = city;
    if (city.isEmpty) {
      searchCity = [];
      emit(AppSearchedCityState());
      return;
    }
    searchCity = citiesData
        .where((element) =>
            element.city.toLowerCase().contains(city) ||
            element.country.toLowerCase().contains(city))
        .toList();

    emit(AppSearchedCityState());
  }

// weather data
  void _getListForcastByDaysWeather() {
    listThreeDayWeather = [];
    listForcastByDaysWeather = [];
    int maxDays = 2;
    listThreeDayWeather.add(listWeather[currentCity]);
    listForcastByDaysWeather.add(listWeather[currentCity]);

    for (int days = 1; days <= maxDays; days++) {
      WeatherModel? nextDayWeather =
          listForcastWeather[currentCity]!.firstWhereOrNull((element) {
        return element.dateTime.day ==
                listWeather[currentCity].dateTime.day + days &&
            element.dateTime.hour == 11;
      });

      if (nextDayWeather != null) listThreeDayWeather.add(nextDayWeather);
    }
    maxDays = 4;
    // get Weather Three Days

    for (int days = 1; days <= maxDays; days++) {
      WeatherModel? nextDayWeather = listForcastWeather[currentCity]
          ?.firstWhereOrNull((element) =>
              element.dateTime.day ==
                  listWeather[currentCity].dateTime.day + days &&
              element.dateTime.hour == 11);

      if (nextDayWeather != null) listForcastByDaysWeather.add(nextDayWeather);
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
    emit(AppLoadDataState());
    if (listWeather.isEmpty) {
      try {
        Position yourPosition = await getGeoLocationPosition();
        var response = await _weatherByLocationUseCase.execute(
            GetWeatherDataByLocationUseCaseInput(
                yourPosition.longitude.toString(),
                yourPosition.latitude.toString()));
        response.fold((err) => emit(AppErrorState(err.messages)), (data) async {
          listWeather.add(data);
          var response1 = await _weatherForcastByLocationUseCase.execute(
              GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput(
                  yourPosition.longitude.toString(),
                  yourPosition.latitude.toString()));
          response1.fold(
            (error) => emit(
              AppErrorState(error.messages),
            ),
            (data) {
              listForcastWeather.addAll({listWeather.length - 1: data});
              _getListForcastByDaysWeather();
              emit(AppLoadedDataState());
            },
          );
        });
      } catch (ex) {
        emit(AppNeededLocationState());
      }
    }
  }

  void getWeatherDataByCounty(String country) async {
    emit(AppLoadDataState());
    if (listWeather.isEmpty) {
      try {
        var response = await _weatherByCountryNameUseCase
            .execute(GetWeatherByCountryNameUseCaseInput(country));
        response.fold((err) => emit(AppErrorState(err.messages)), (data) async {
          listWeather.add(data);
          var response1 = await _weatherForcastByCountryNameUseCase
              .execute(GetForcastWeatherByCountryNameUseCaseInput(country));
          response1.fold(
            (error) => emit(
              AppErrorState(error.messages),
            ),
            (data) {
              listForcastWeather.addAll({listWeather.length - 1: data});

              _getListForcastByDaysWeather();
              emit(AppLoadedDataState());
            },
          );
        });
      } catch (ex) {
        emit(AppErrorState(ex.toString()));
      }
    }
  }
}
