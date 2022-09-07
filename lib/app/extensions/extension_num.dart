extension ExtensionDouble on num {
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
