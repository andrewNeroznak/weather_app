import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/day_data.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/network/api_client.dart';
import 'package:weather_app/utility/temp_converter.dart';

import '../models/day_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<Forecast>? _future;
  @override
  void initState() {
    super.initState();
    _future = ApiClient().fetchWeather('oslo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Forecast>(
          future: _future,
          builder: (context, snapshot) {
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              final Forecast forecast = snapshot.data!;
              final DayForecast nowForecast = forecast.daysForecast.removeAt(0);

              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(forecast.city.name),
                        Text(
                          DateFormat.Hm().format(nowForecast.dt),
                        ),
                        _buildTemp(nowForecast.dayData),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _buildTemp(DayData dayData) {
    final feelsLike = TempConverter.celsiusFromKelvin(dayData.feelsLike);
    final temp = TempConverter.celsiusFromKelvin(dayData.temp);
    return Column(
      children: [
        Text(
          '${temp.isNegative ? '' : '+'}${temp.toStringAsFixed(1)}' ' C°',
        ),
        Text(
          'Feels like ${feelsLike.isNegative ? '' : '+'}${feelsLike.toStringAsFixed(1)}'
          ' C°',
        ),
      ],
    );
  }
}
