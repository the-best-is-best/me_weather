import 'package:me_weather/domain/repository/weather_repositories.dart';
import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../models/weather_model.dart';
import 'base_case.dart';

class GetForcastWeatherByCountryNameUseCase extends BaseCase<
    GetForcastWeatherByCountryNameUseCaseInput, List<WeatherModel>> {
  final Repository _weatherRepository;

  GetForcastWeatherByCountryNameUseCase(this._weatherRepository);
  @override
  Future<Either<Failure, List<WeatherModel>>> execute(
      GetForcastWeatherByCountryNameUseCaseInput input) async {
    return await _weatherRepository.getForcastWeatherByCityName(input.cityName);
  }
}

class GetForcastWeatherByCountryNameUseCaseInput {
  final String cityName;

  GetForcastWeatherByCountryNameUseCaseInput(this.cityName);
}
