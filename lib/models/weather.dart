import 'package:collection/collection.dart';
import 'package:weather_app/extensions/date_time.dart';

import 'city.dart';
import 'day_forecast.dart';

class Weather {
  late final List<DayForecast> forecasts;
  late final City city;

  Weather.fromJson(Map<String, dynamic> json) {
    final list = List<DayForecast>.from(
      json['list'].map(
        (e) => DayForecast.fromJson(e),
      ),
    );

    final groupedByDays = list.groupListsBy((element) => element.dt.ymd);

    forecasts = groupedByDays.entries.map((e) {
      final min = e.value
          .sortedBy<num>((element) => element.tempMin.celsius)
          .first
          .tempMin;
      final max = e.value
          .sortedBy<num>((element) => element.tempMax.celsius)
          .last
          .tempMax;

      return e.value
          .firstWhere(
            (element) => element.dt.hour >= 12 && element.dt.hour <= 15,
            orElse: () => list.first,
          )
          .copyWith(tempMax: max, tempMin: min);
    }).toList(
      growable: false,
    );
    city = City.fromJson(json['city']);
  }
}
