extension ExtensionDouble on num {
  String kelvinToCelsiusString() {
    return "${(this - 273.15).toStringAsFixed(0)} \u00B0C";
  }

  num kelvinToCelsius() {
    return this - 273.15;
  }
}
