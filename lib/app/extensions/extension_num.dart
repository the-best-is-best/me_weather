extension ExtensionDouble on num {
  String kelvinToCelsiusString() {
    return "${(this - 273.15).toStringAsFixed(0)} \u00B0C";
  }

  num kelvinToCelsius() {
    return this - 273.15;
  }

  String msToKM() {
    return '${(this / 1000 * 60 * 60).round()} km/h';
  }
}
