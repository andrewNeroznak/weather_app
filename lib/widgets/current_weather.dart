import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/day_forecast.dart';
import 'package:weather_app/models/unit.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentWeather extends StatelessWidget {
  final DayForecast weather;
  final String selectedCity;
  final Unit selectedUnit;
  final DateTime sunset;
  final DateTime sunrise;

  const CurrentWeather({
    super.key,
    required this.weather,
    required this.selectedCity,
    required this.selectedUnit,
    required this.sunset,
    required this.sunrise,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            letterSpacing: 5,
            fontSize: 16,
          ),
      textAlign: TextAlign.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              selectedCity.toUpperCase(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              weather.weatherParams.description,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: BoxedIcon(
                weather.weatherIcon,
                size: 100,
              ),
            ),
            Text(
              weather.temp.value(selectedUnit),
              style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildWeatherConditionColumn(
                          'Min',
                          weather.tempMin.value(selectedUnit),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10)
                              // letter spacing
                              .copyWith(right: 14),
                          width: 2,
                          color: Theme.of(context).dividerColor,
                        ),
                        _buildWeatherConditionColumn(
                          'Max',
                          weather.tempMax.value(selectedUnit),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      _buildWeatherConditionColumn(
                        'Sunset',
                        DateFormat.jm().format(
                          sunset,
                        ),
                      ),
                      _buildWeatherConditionColumn(
                        'Sunrise',
                        DateFormat.jm().format(
                          sunrise,
                        ),
                      ),
                      _buildWeatherConditionColumn(
                          'Pressure', '${weather.pressure} hPa'),
                      _buildWeatherConditionColumn(
                          'Wind speed', weather.wind.speed.value(selectedUnit))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherConditionColumn(String top, String bottom) {
    return Column(
      children: [
        Text(
          top,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(bottom)
      ],
    );
  }
}
