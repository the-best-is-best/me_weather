import 'package:intl/intl.dart';

extension ExtensionDouble on DateTime {
  String toTime() {
    String date = DateFormat("HH:mm a").format(this);
    return date;
  }

  String toTimeString() {
    return DateFormat('hh:MM:ss').format(this);
  }
}
