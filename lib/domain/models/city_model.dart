class CityModel {
  final String city;
  final String country;
  final String iso2;
  final String timezone;

  CityModel({
    required this.city,
    required this.country,
    required this.iso2,
    required this.timezone,
  });

  factory CityModel.fromJson(json) {
    return CityModel(
      city: json['city'],
      country: json['country'],
      iso2: json['iso2'].toString(),
      timezone: json['timezone'] ?? "",
    );
  }
}
