class WeatherModel {
  final int id;
  final String cityName;
  final String iconImage;
  final String status;
  final String description;
  final num temp;
  final num tempMin;
  final num tempMax;
  final num feelsLike;
  final num pressure;
  final num humidity;
  final num windSpeed;
  final num windDeg;
  final DateTime dateTime;
  final DateTime? sunrise;
  final DateTime? sunset;
  WeatherModel({
    required this.id,
    required this.cityName,
    required this.status,
    required this.description,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.dateTime,
    required this.iconImage,
    required this.sunrise,
    required this.sunset,
  });
}
