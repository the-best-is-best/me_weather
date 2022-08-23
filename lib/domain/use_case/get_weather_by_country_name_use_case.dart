import 'package:dartz/dartz.dart';
import 'package:me_weather/domain/repository/weather_repositories.dart';
import '../../data/network/failure.dart';
import '../models/weather_model.dart';
import 'base_case.dart';

class GetWeatherByCountryNameUseCase
    extends BaseCase<GetWeatherByCountryNameUseCaseInput, WeatherModel> {
  final Repository _weatherRepository;

  GetWeatherByCountryNameUseCase(this._weatherRepository);
  @override
  Future<Either<Failure, WeatherModel>> execute(
      GetWeatherByCountryNameUseCaseInput input) async {
    return await _weatherRepository.getWetherByCityName(input.cityName);
  }
}

class GetWeatherByCountryNameUseCaseInput {
  final String cityName;
  GetWeatherByCountryNameUseCaseInput(this.cityName);
}
