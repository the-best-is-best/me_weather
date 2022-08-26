import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/domain/models/city_model.dart';
import 'package:timezone/standalone.dart' as tz;

extension ExtensionInt on int {
  DateTime toDateTime(String city) {
    CityModel cityData =
        AppCubit.citiesData.firstWhere((element) => element.city == city);
    final detroit = tz.getLocation(cityData.timezone);
    print(cityData.timezone);
    Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(this);
    // Location timeZone = tz.getLocation(location);
    var time = tz.TZDateTime.from(timestamp.toDate(), detroit);

    return time;
  }
}
