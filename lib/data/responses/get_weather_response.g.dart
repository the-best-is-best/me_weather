// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWeatherResponse _$GetWeatherResponseFromJson(Map<String, dynamic> json) =>
    GetWeatherResponse(
      id: json['id'] as int?,
      cityName: json['name'] as String?,
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
      cod: json['cod'] as int?,
      countryData: json['sys'] == null
          ? null
          : CountryData.fromJson(json['sys'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetWeatherResponseToJson(GetWeatherResponse instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'id': instance.id,
      'name': instance.cityName,
      'weather': instance.weather,
      'wind': instance.wind,
      'main': instance.main,
      'dt': instance.dateTime,
      'sys': instance.countryData,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['main'] as String?,
      json['description'] as String?,
      json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.status,
      'description': instance.description,
      'icon': instance.icon,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      speed: json['speed'] as num?,
      deg: json['deg'] as num?,
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      json['pressure'] as num?,
      json['temp'] as num?,
      json['feels_like'] as num?,
      json['humidity'] as num?,
      json['temp_min'] as num?,
      json['temp_max'] as num?,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'pressure': instance.pressure,
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      json['sunrise'] as int?,
      json['sunset'] as int?,
      json['country'] as String?,
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
