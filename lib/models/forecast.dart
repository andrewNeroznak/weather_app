import 'city.dart';
import 'day_forecast.dart';

class Forecast {
  Forecast({
    required this.daysForecast,
    required this.city,
  });

  late final int cnt;
  late final List<DayForecast> daysForecast;
  late final City city;

  Forecast.fromJson(Map<String, dynamic> json) {
    daysForecast = List.from(
      json['list'].map(
        (e) => DayForecast.fromJson(e),
      ),
    );
    city = City.fromJson(json['city']);
  }
}
