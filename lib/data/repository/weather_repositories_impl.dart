import 'package:dartz/dartz.dart';
import 'package:me_weather/data/mapper/forcast_weather_response_mapper.dart';
import 'package:me_weather/data/mapper/weather_response_mapper.dart';
import '../../domain/models/weather_model.dart';
import '../../domain/repository/weather_repositories.dart';
import '../data_src/remote_data_src.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import 'get_weather/get_forcast_weather_impl.dart';
import 'get_weather/get_current_weather_impl.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSrc _remoteDataSrc;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSrc, this._networkInfo);
  @override
  Future<Either<Failure, WeatherModel>> getWetherByCityName(
      String cityName) async {
    return await getWeatherByCityNameImpl(
      cityName: cityName,
      networkInfo: _networkInfo,
      remoteDataSrc: _remoteDataSrc,
    );
  }

  @override
  Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityName(
      String cityName) async {
    return await getForcastWeatherByCityNameImpl(
      cityName: cityName,
      networkInfo: _networkInfo,
      remoteDataSrc: _remoteDataSrc,
    );
  }

  @override
  Future<Either<Failure, WeatherModel>> getWeatherDataByLocation(
      String lon, String lat) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _remoteDataSrc.getWeatherDataByLocation(lon, lat);
        if ((response.cod ?? 500) >= 200 && (response.cod ?? 500) <= 299) {
          //success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // return either left
          // return error
          return Left(Failure(response.cod ?? 500, "Error server"));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<WeatherModel>>>
      getFiveDaysThreeHoursForcastDataByLocation(String lon, String lat) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _remoteDataSrc
            .getFiveDaysThreeHoursForcastDataByLocation(lon, lat);
        if (int.tryParse(response.cod ?? "500")! >= 200 &&
            int.tryParse(response.cod ?? "500")! <= 299) {
          //success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // return either left
          // return error
          return Left(
              Failure(int.tryParse(response.cod ?? "500")!, "Error server"));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
