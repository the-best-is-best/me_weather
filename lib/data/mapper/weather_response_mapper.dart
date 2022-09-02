import 'package:me_weather/app/extensions.dart';
import 'package:me_weather/app/extensions/extension_int.dart';

import '../../domain/models/weather_model.dart';
import '../responses/get_weather_response.dart';

extension HomeResponseMapper on GetWeatherResponse? {
  WeatherModel toDomain() {
    return WeatherModel(
      id: this?.id?.orEmpty() ?? 0,
      cityName: this?.cityName.orEmpty() ?? "",
      description: this?.weather?[0].description?.orEmpty() ?? "",
      pressure: this?.main?.pressure?.orEmpty() ?? 0,
      status: this?.weather?[0].status?.orEmpty() ?? "",
      feelsLike: this?.main?.feelsLike?.orEmpty() ?? 0,
      temp: this?.main?.temp.orEmpty() ?? 0,
      tempMin: this?.main?.tempMin?.orEmpty() ?? 0,
      tempMax: this?.main?.tempMax?.orEmpty() ?? 0,
      humidity: this?.main?.humidity.orEmpty() ?? 0,
      windSpeed: this?.wind?.speed.orEmpty() ?? 0,
      windDeg: this?.wind?.deg.orEmpty() ?? 0,
      dateTime: this!.dateTime!.toDateTime(this!.cityName!),
      sunrise: this?.countryData?.sunrise?.toDateTime(this!.cityName!),
      sunset: this?.countryData?.sunset?.toDateTime(this!.cityName!),
      iconImage:
          "http://openweathermap.org/img/w/${this!.weather![0].icon}.png",
    );
  }
}
