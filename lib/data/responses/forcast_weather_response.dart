import 'package:json_annotation/json_annotation.dart';

import 'get_weather_response.dart';
part 'forcast_weather_response.g.dart';

@JsonSerializable()
class ForcastWeatherResponse {
  final String? cod;
  // final String? message;
  @JsonKey(name: "list")
  final List<WeatherDataResponse>? forcastWeather;
  final City? city;

  ForcastWeatherResponse(
    this.forcastWeather,
    this.cod,
    this.city,
  );
  factory ForcastWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$ForcastWeatherResponseFromJson(json);
}

@JsonSerializable()
class WeatherDataResponse {
  final int? id;
  final List<Weather>? weather;
  final Wind? wind;
  final Main? main;
  @JsonKey(name: "dt")
  final int? dateTime;

  WeatherDataResponse({
    this.id,
    this.weather,
    this.main,
    this.wind,
    required this.dateTime,
  });
  factory WeatherDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataResponseFromJson(json);
}

@JsonSerializable()
class City {
  final String? name;
  final String? country;
  final int? sunrise;
  final int? sunset;
  City(this.sunrise, this.sunset, {required this.country, this.name});
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
