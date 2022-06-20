class TempConverter {
  static const double _zeroCelsium = 273.15;
  static double celsiusFromKelvin(double kelvin) {
    return kelvin - _zeroCelsium;
  }

  static fahrenheitFromCelsius(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  static fahrenheitFromKelvin(double kelvin) {
    final celsius = kelvin - _zeroCelsium;

    return fahrenheitFromCelsius(celsius);
  }
}
