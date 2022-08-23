import '../network/app_api.dart';
import '../responses/forcast_weather_response.dart';
import '../responses/get_weather_response.dart';

abstract class RemoteDataSrc {
  Future<GetWeatherResponse> getWeatherByCityName(String cityName);
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastData(
      String cityName);
  Future<GetWeatherResponse> getWeatherDataByLocation(String lon, String lat);
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastDataByLocation(
      String lon, String lat);
}

class RemoteDataSrcImpl extends RemoteDataSrc {
  final AppServicesClient _appServicesClient;

  RemoteDataSrcImpl(this._appServicesClient);

  @override
  Future<GetWeatherResponse> getWeatherByCityName(String cityName) async {
    return _appServicesClient.getWeatherByCountry(cityName: cityName);
  }

  @override
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastData(
      String cityName) async {
    return _appServicesClient.getFiveDaysThreeHoursForcastDataByCountry(
        cityName: cityName);
  }

  @override
  Future<GetWeatherResponse> getWeatherDataByLocation(
      String lon, String lat) async {
    return _appServicesClient.getWeatherDataByLocation(lat: lat, lon: lon);
  }

  @override
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastDataByLocation(
      String lon, String lat) async {
    return _appServicesClient.getFiveDaysThreeHoursForcastDataByLocation(
        lat: lat, lon: lon);
  }
}
