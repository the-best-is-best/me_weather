import 'package:dartz/dartz.dart';
import 'package:me_weather/domain/repository/weather_repositories.dart';
import '../../data/network/failure.dart';
import '../models/weather_model.dart';
import 'base_case.dart';

class GetWeatherDataByLocationUseCase
    extends BaseCase<GetWeatherDataByLocationUseCaseInput, WeatherModel> {
  final Repository _weatherRepository;

  GetWeatherDataByLocationUseCase(this._weatherRepository);
  @override
  Future<Either<Failure, WeatherModel>> execute(
      GetWeatherDataByLocationUseCaseInput input) async {
    return await _weatherRepository.getWeatherDataByLocation(
        input.lon, input.lat);
  }
}

class GetWeatherDataByLocationUseCaseInput {
  final String lon;
  final String lat;

  GetWeatherDataByLocationUseCaseInput(this.lon, this.lat);
}
