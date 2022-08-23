import 'package:dartz/dartz.dart';
import 'package:me_weather/data/mapper/weather_response_mapper.dart';

import '../../../domain/models/weather_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';

Future<Either<Failure, WeatherModel>> getWeatherByCityNameImpl({
  required NetworkInfo networkInfo,
  required RemoteDataSrc remoteDataSrc,
  required String cityName,
}) async {
  if (await networkInfo.isConnected) {
    try {
      var response = await remoteDataSrc.getWeatherByCityName(cityName);
      if (response.cod!.toInt() >= 200 && response.cod!.toInt() <= 299) {
        //success
        // return either right
        // return data
        return Right(response.toDomain());
      } else {
        // return either left
        // return error
        return Left(Failure(response.cod!.toInt(), "Error server"));
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
