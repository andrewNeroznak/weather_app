import 'package:weather_app/models/main_data.dart';

import 'clouds.dart';
import 'weather.dart';
import 'wind.dart';

class ForecastData {
  ForecastData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
  });
  late final int dt;
  late final MainData main;
  late final List<Weather> weather;
  late final Clouds clouds;
  late final Wind wind;
  late final int visibility;
  late final double pop;
  late final String dtTxt;

  ForecastData.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = MainData.fromJson(json['main']);
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dt'] = dt;
    data['main'] = main.toJson();
    data['weather'] = weather.map((e) => e.toJson()).toList();
    data['clouds'] = clouds.toJson();
    data['wind'] = wind.toJson();
    data['visibility'] = visibility;
    data['pop'] = pop;
    data['dt_txt'] = dtTxt;
    return data;
  }
}
