class CityModel {
  final String city;

  final String timezone;

  CityModel({
    required this.city,
    required this.timezone,
  });

  factory CityModel.fromJson(json) {
    return CityModel(
      city: json['city'],
      timezone: json['timezone'] ?? "",
    );
  }
}
