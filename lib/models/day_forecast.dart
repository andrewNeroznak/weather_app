import 'package:weather_app/models/day_data.dart';

import 'clouds.dart';
import 'weather.dart';
import 'wind.dart';

class DayForecast {
  DayForecast({
    required this.dt,
    required this.dayData,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
  });
  late final DateTime dt;
  late final DayData dayData;
  late final List<Weather> weather;
  late final Clouds clouds;
  late final Wind wind;
  late final int visibility;
  late final double pop;
  late final String dtTxt;

  DayForecast.fromJson(Map<String, dynamic> json) {
    dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    dayData = DayData.fromJson(json['main']);
    weather = List.from(
      json['weather'].map(
        (e) => Weather.fromJson(e),
      ),
    );

    clouds = Clouds.fromJson(json['clouds']);
    wind = Wind.fromJson(json['wind']);
    visibility = json['visibility'];
    pop = json['pop'].toDouble();
    dtTxt = json['dt_txt'];
  }
}
