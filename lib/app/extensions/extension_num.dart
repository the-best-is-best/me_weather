extension ExtensionDouble on num {
  String kelvinToCelsiusString() {
    return "${(this - 273.15).toStringAsFixed(0)} \u00B0C";
  }

  String kelvinToFahrenheitString() {
    double celsius = this - 273.15;

    return "${(1.8 * celsius + 32).toStringAsFixed(0)} \u00B0F";
  }

  num kelvinToCelsius() {
    return this - 273.15;
  }

  num kelvinTFahrenheit() {
    double celsius = this - 273.15;

    return 1.8 * celsius + 32;
  }

  String msToKM() {
    return '${(this / 1000 * 60 * 60).round()} km/h';
  }
}
