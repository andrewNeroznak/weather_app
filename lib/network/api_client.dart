import 'dart:convert';

import 'package:http/io_client.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/network/config.dart';
import 'package:weather_app/network/interceptor_mixin.dart';

class ApiClient with Interceptor {
  final _Client _client = _Client();
  Future<Weather> fetchForecast(String city, {int days = 5}) {
    final Map<String, String> params = {
      'q': city,
      'appid': Config.apiKey,
      // API returns data points in 3-hour intervals -> 1 day = 8 intervals
      'cnt': (8 * days).toString(),
    };

    final Uri uri = Uri.https(Config.host, '/data/2.5/forecast', params);

    return _client.get(uri).then(interceptor).then((response) {
      final decoded = json.decode(response.body);
      return Weather.fromJson(decoded);
    });
  }
}

class _Client extends IOClient {}
