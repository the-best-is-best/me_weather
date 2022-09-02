import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../app/resources/constants.dart';
import '../responses/forcast_weather_response.dart';
import '../responses/get_weather_response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) =
      _AppServicesClient; // factory
  @GET(Constants.endPointWeather)
  Future<GetWeatherResponse> getWeatherDataByLocation({
    @Query('lat') required String lat,
    @Query('lon') required String lon,
    @Query('lang') required String lang,
    @Query("appid") String appId = Constants.token,
  });
  @GET(Constants.endPointWeather)
  Future<GetWeatherResponse> getWeatherByCountry({
    @Query('q') required String cityName,
    @Query('lang') required String lang,
    @Query("appid") String appId = Constants.token,
  });
  @GET(Constants.endPointForcast)
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastDataByLocation({
    @Query('lat') required String lat,
    @Query('lon') required String lon,
    @Query('lang') required String lang,
    @Query("appid") String appId = Constants.token,
  });
  @GET(Constants.endPointForcast)
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastDataByCountry({
    @Query('q') required String cityName,
    @Query('lang') required String lang,
    @Query("appid") String appId = Constants.token,
  });
}
