import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../models/weather_model.dart';

abstract class Repository {
  Future<Either<Failure, WeatherModel>> getWetherByCityName(String cityName);
  Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityName(
      String cityName);
  Future<Either<Failure, WeatherModel>> getWeatherDataByLocation(
      String lon, String lat);
  Future<Either<Failure, List<WeatherModel>>>
      getFiveDaysThreeHoursForcastDataByLocation(String lon, String lat);
}
