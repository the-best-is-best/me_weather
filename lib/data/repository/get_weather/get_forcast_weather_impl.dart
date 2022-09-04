import 'package:dartz/dartz.dart';
import 'package:me_weather/data/mapper/forcast_weather_response_mapper.dart';
import '../../../domain/models/weather_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';

Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityNameImpl({
  required NetworkInfo networkInfo,
  required RemoteDataSrc remoteDataSrc,
  required String cityName,
}) async {
  if (await networkInfo.isConnected) {
    //  try {
    var response =
        await remoteDataSrc.getFiveDaysThreeHoursForcastData(cityName);

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
    //} catch (error) {
    //   return Left(ErrorHandler.handle(error).failure);
    // }
  } else {
    //failure
    // return either left
    return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
  }
}
