// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forcast_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForcastWeatherResponse _$ForcastWeatherResponseFromJson(
        Map<String, dynamic> json) =>
    ForcastWeatherResponse(
      (json['list'] as List<dynamic>?)
          ?.map((e) => WeatherDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['cod'] as String?,
      json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForcastWeatherResponseToJson(
        ForcastWeatherResponse instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'list': instance.forcastWeather,
      'city': instance.city,
    };

WeatherDataResponse _$WeatherDataResponseFromJson(Map<String, dynamic> json) =>
    WeatherDataResponse(
      id: json['id'] as int?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      dateTime: json['dt'] as int?,
    );

Map<String, dynamic> _$WeatherDataResponseToJson(
        WeatherDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather': instance.weather,
      'wind': instance.wind,
      'main': instance.main,
      'dt': instance.dateTime,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      json['sunrise'] as int?,
      json['sunset'] as int?,
      country: json['country'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
