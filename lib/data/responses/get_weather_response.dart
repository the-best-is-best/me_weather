import 'package:json_annotation/json_annotation.dart';
part 'get_weather_response.g.dart';

@JsonSerializable()
class GetWeatherResponse {
  final int? cod;
  //final String? message;

  final int? id;
  @JsonKey(name: "name")
  final String? cityName;
  final List<Weather>? weather;
  final Wind? wind;
  final Main? main;
  @JsonKey(name: "dt")
  final int? dateTime;
  @JsonKey(name: "sys")
  final CountryData? countryData;
  GetWeatherResponse({
    this.id,
    this.cityName,
    this.weather,
    this.main,
    this.wind,
    required this.dateTime,
    this.cod,
    this.countryData,
  });
  factory GetWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWeatherResponseFromJson(json);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: "main")
  final String? status;
  final String? description;
  final String icon;

  Weather(this.status, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return _$WeatherFromJson(json);
  }
}

@JsonSerializable()
class Wind {
  final num? speed;
  final num? deg;
  Wind({this.speed, this.deg});
  factory Wind.fromJson(Map<String, dynamic> json) {
    return _$WindFromJson(json);
  }
}

@JsonSerializable()
class Main {
  final num? pressure;
  final num? temp;
  @JsonKey(name: "temp_min")
  final num? tempMin;
  @JsonKey(name: "temp_max")
  final num? tempMax;
  @JsonKey(name: "feels_like")
  final num? feelsLike;
  final num? humidity;

  Main(this.pressure, this.temp, this.feelsLike, this.humidity, this.tempMin,
      this.tempMax);
  factory Main.fromJson(Map<String, dynamic> json) {
    return _$MainFromJson(json);
  }
}

@JsonSerializable()
class CountryData {
  final String? country;
  final int? sunrise;
  final int? sunset;

  CountryData(this.sunrise, this.sunset, this.country);
  factory CountryData.fromJson(Map<String, dynamic> json) {
    return _$CountryDataFromJson(json);
  }
}
