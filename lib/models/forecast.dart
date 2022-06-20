import 'city.dart';
import 'forecast_data.dart';

class Forecast {
  Forecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });
  late final String cod;
  late final int message;
  late final int cnt;
  late final List<ForecastData> list;
  late final City city;

  Forecast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    list = List.from(
      json['list'].map(
        (e) => ForecastData.fromJson(e),
      ),
    );
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    data['list'] = list.map((e) => e.toJson()).toList();
    data['city'] = city.toJson();
    return data;
  }
}
