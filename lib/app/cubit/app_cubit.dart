import 'dart:convert';
import 'dart:math';
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

  List<String> citiesUser = [];

  List<WeatherModel> listWeather = [];

  List<WeatherModel> listThreeDayWeather = [];

  Map<int, List<WeatherModel>> listForcastWeather = {};

  List<WeatherModel> listForcastByDaysWeather = [];

  int currentCity = 0;
  bool isFahrenheit = false;
  void changeToFahrenheit() {
    isFahrenheit = !isFahrenheit;
    box.write('isFahrenheit', isFahrenheit);
    emit(ChangeToFahrenheitState());
  }

// city
  void changeCurrentCity(int index) {
    currentCity = index;
    _getListForcastByDaysWeather();
    emit(AppChangeCountryState());
  }

  String searchTextController = "";
  List<CityModel> searchCity = [];
  void searchForCity(String city) {
    searchCity = [];
    if (city.length >= 3) {
      emit(AppSearchCityState());
      searchTextController = city;
      if (city.isEmpty) {
        searchCity = [];
        emit(AppSearchedCityState());
        return;
      }

      for (var element in citiesData) {
        if (element.city.toLowerCase().contains(city)) {
          if (citiesUser.isNotEmpty) {
            bool isExist = false;
            for (var e in citiesUser) {
              if (e.toLowerCase() == element.city.toLowerCase()) {
                isExist = true;
              }
              if (!isExist) searchCity.add(element);
            }
          } else {
            searchCity.add(element);
          }
        }
      }

      emit(AppSearchedCityState());
    }
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
      WeatherModel? nextDayWeather = listForcastWeather[currentCity]!
          .firstWhereOrNull((element) =>
              element.dateTime.day ==
                  listWeather[currentCity].dateTime.day + days &&
              element.dateTime.hour == 11);

      if (nextDayWeather != null) listForcastByDaysWeather.add(nextDayWeather);
    }
    searchTextController = "";
    searchCity = [];
  }

  void addMoreCites(String city) async {
    back();
    back();
    getWeatherDataByCounty(city);
  }

  void back() {
    MitX.back();
  }

  void loadDataUser() async {
    isFahrenheit = box.read('isFahrenheit') ?? false;
    if (citiesData.isEmpty) {
      emit(AppLoadAppDataState());

      List<dynamic> cityMapJson = json.decode(
          await DefaultAssetBundle.of(MitX.context!)
              .loadString('assets/json/en/city_map.json'));
      for (var city in cityMapJson) {
        citiesData.add(CityModel.fromJson(city));
      }
    }
    if (box.read('citiesUser') != null) {
      String citiesUserJson = box.read('citiesUser');
      List<dynamic> userCitiesList = jsonDecode(citiesUserJson);
      for (var e in userCitiesList) {
        citiesUser.add(e);

        await getWeatherDataByCounty(e, byCityUser: true);
      }
    }
    emit(AppLoadedState());
  }

  void getWeatherDataByYourLocation() async {
    if (citiesUser.isNotEmpty) {
      return;
    }
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
          citiesUser.add(data.cityName);

          var response1 = await _weatherForcastByLocationUseCase.execute(
              GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput(
                  yourPosition.longitude.toString(),
                  yourPosition.latitude.toString()));
          response1.fold(
            (error) => emit(
              AppErrorState(error.messages),
            ),
            (data) {
              listForcastWeather.addAll({0: data});
              indexWeather = 1;
              _getListForcastByDaysWeather();
              emit(AppLoadedDataState());
            },
          );
        });
      } catch (ex) {
        emit(AppNeededLocationState());
      }
    }
    box.write('citiesUser', jsonEncode(citiesUser));
  }

  int indexWeather = 0;
  Future getWeatherDataByCounty(String country,
      {bool byCityUser = false}) async {
    emit(AppLoadDataState());
    currentCity = 0;
    try {
      var response = await _weatherByCountryNameUseCase
          .execute(GetWeatherByCountryNameUseCaseInput(country));
      response.fold((err) => emit(AppErrorState(err.messages)), (data) async {
        listWeather.add(data);
        if (!byCityUser) {
          citiesUser.add(data.cityName);
        }
        var response1 = await _weatherForcastByCountryNameUseCase
            .execute(GetForcastWeatherByCountryNameUseCaseInput(country));
        response1.fold(
          (error) => emit(
            AppErrorState(error.messages),
          ),
          (data) {
            listForcastWeather.addAll({indexWeather: data});
            indexWeather++;
            _getListForcastByDaysWeather();
            emit(AppLoadedDataState());
          },
        );
      });
      box.write('citiesUser', jsonEncode(citiesUser));
    } catch (ex) {
      emit(AppErrorState(ex.toString()));
    }
  }

  void deleteWeather(String country) async {
    emit(AppLoadDataState());
    currentCity = 0;
    indexWeather = 0;
    listForcastByDaysWeather = [];
    listForcastWeather = {};
    listThreeDayWeather = [];
    listWeather = [];
    citiesUser.remove(country);

    if (citiesUser.isNotEmpty) {
      box.write('citiesUser', jsonEncode(citiesUser));
      for (var e in citiesUser) {
        await getWeatherDataByCounty(e, byCityUser: true);
      }
    }

    emit(AppLoadedDataState());
  }

  void getWeatherDataAfterLanguageChanged() {
    listForcastByDaysWeather = [];
    listForcastWeather = {};
    listForcastWeather = {};
    listThreeDayWeather = [];
    listWeather = [];
    emit(AppLoadDataState());
    for (var e in citiesUser) {
      getWeatherDataByCounty(e, byCityUser: true);
    }
    emit(AppLoadedDataState());
  }

  void changeListWeather(int oldIndex, int newIndex) async {
    MitX.back();
    currentCity = 0;
    indexWeather = 0;

    emit(AppLoadDataState());

    final itemCityUser = citiesUser.removeAt(oldIndex);
    citiesUser.insert(newIndex, itemCityUser);
    box.write('citiesUser', jsonEncode(citiesUser));
    listForcastByDaysWeather = [];
    listForcastWeather = {};
    listThreeDayWeather = [];
    listWeather = [];
    for (var e in citiesUser) {
      await getWeatherDataByCounty(e, byCityUser: true);
    }
    emit(AppLoadedDataState());
  }
}
