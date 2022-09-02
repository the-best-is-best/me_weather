import 'package:me_weather/app/extensions.dart';
import 'package:me_weather/app/extensions/extension_int.dart';

import '../../domain/models/weather_model.dart';
import '../responses/forcast_weather_response.dart';

extension HomeResponseMapper on ForcastWeatherResponse? {
  List<WeatherModel> toDomain() {
    return <WeatherModel>[
      for (WeatherDataResponse item
          in this?.forcastWeather ?? [].cast<WeatherDataResponse>())
        WeatherModel(
          id: item.id?.orEmpty() ?? 0,
          cityName: this!.city!.name.orEmpty(),
          description: item.weather?[0].description?.orEmpty() ?? "",
          pressure: item.main?.pressure?.orEmpty() ?? 0,
          status: item.weather?[0].status?.orEmpty() ?? "",
          feelsLike: item.main?.feelsLike?.orEmpty() ?? 0,
          temp: item.main?.temp.orEmpty().round() ?? 0,
          tempMin: item.main?.tempMin?.orEmpty() ?? 0,
          tempMax: item.main?.tempMax?.orEmpty() ?? 0,
          humidity: item.main?.humidity.orEmpty() ?? 0,
          windSpeed: item.wind?.speed.orEmpty() ?? 0,
          windDeg: item.wind?.deg.orEmpty() ?? 0,
          dateTime: item.dateTime!.toDateTime(this!.city!.name!),
          iconImage:
              "http://openweathermap.org/img/w/${item.weather![0].icon}.png",
          sunrise: this!.city!.sunset!.toDateTime(this!.city!.name!),
          sunset: this!.city!.sunset!.toDateTime(this!.city!.name!),
        ),
    ];
  }
}
