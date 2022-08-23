import 'package:intl/intl.dart';

extension ExtensionDouble on DateTime {
  // Sunrise or sunset
  bool isSunsetOrSunrise(DateTime sunrise) {
    if (isAfter(sunrise)) {
      // return "Moon: $date";
      return false;
    } else {
      // return "Sun: $date";
      return true;
    }
  }

  String toTime() {
    String date = DateFormat("HH:mm a").format(this);
    return date;
  }

  String toTimeString() {
    return DateFormat('hh:MM:ss').format(this);
  }
}
