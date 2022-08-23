import 'package:dartz/dartz.dart';
import 'package:me_weather/domain/repository/weather_repositories.dart';
import '../../data/network/failure.dart';
import '../models/weather_model.dart';
import 'base_case.dart';

class GetFiveDaysThreeHoursForcastDataByLocationUseCase extends BaseCase<
    GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput,
    List<WeatherModel>> {
  final Repository _weatherRepository;

  GetFiveDaysThreeHoursForcastDataByLocationUseCase(this._weatherRepository);
  @override
  Future<Either<Failure, List<WeatherModel>>> execute(
      GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput input) async {
    return await _weatherRepository.getFiveDaysThreeHoursForcastDataByLocation(
        input.lon, input.lat);
  }
}

class GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput {
  final String lon;
  final String lat;

  GetFiveDaysThreeHoursForcastDataByLocationUseCaseInput(this.lon, this.lat);
}
