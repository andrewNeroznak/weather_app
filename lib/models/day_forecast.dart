import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'temperature.dart';
import 'weather_params.dart';
import 'wind.dart';

class DayForecast {
  late final DateTime dt;
  late final WeatherParams weatherParams;
  late final Wind wind;
  late final Temperature temp;
  late final Temperature feelsLike;
  late final Temperature tempMin;
  late final Temperature tempMax;
  late final int pressure;
  late final int humidity;

  DayForecast(
      {required this.dt,
      required this.weatherParams,
      required this.wind,
      required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});

  DayForecast copyWith({
    DateTime? dt,
    WeatherParams? weatherParams,
    Wind? wind,
    Temperature? temp,
    Temperature? feelsLike,
    Temperature? tempMin,
    Temperature? tempMax,
    int? pressure,
    int? grndLevel,
    int? humidity,
  }) {
    return DayForecast(
        dt: dt ?? this.dt,
        weatherParams: weatherParams ?? this.weatherParams,
        wind: wind ?? this.wind,
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity);
  }

  DayForecast.fromJson(
    Map<String, dynamic> json,
  ) {
    dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    temp = Temperature(json['main']['temp'].toDouble());
    feelsLike = Temperature(json['main']['feels_like'].toDouble());
    tempMin = Temperature(json['main']['temp_min'].toDouble());
    tempMax = Temperature(json['main']['temp_max'].toDouble());
    pressure = json['main']['pressure'];
    humidity = json['main']['humidity'];
    weatherParams = WeatherParams.fromJson(json['weather'][0]);
    wind = Wind.fromJson(json['wind']);
  }

  String get _icon => weatherParams.icon;

  IconData get weatherIcon => _iconForWeather(_icon);

  String get description => weatherParams.main;
}

IconData _iconForWeather(String iconCode) {
  switch (iconCode) {
    case '01d':
      return WeatherIcons.day_sunny;
    case '01n':
      return WeatherIcons.night_clear;
    case '02d':
    case '03d':
    case '04d':
      return WeatherIcons.day_cloudy;

    case '02n':
    case '03n':
    case '04n':
      return WeatherIcons.night_cloudy;

    case '09d':
      return WeatherIcons.day_rain;
    case '09n':
      return WeatherIcons.night_rain;
    case '10d':
      return WeatherIcons.rain;
    case '10n':
      return WeatherIcons.rain;
    case '11d':
      return WeatherIcons.day_thunderstorm;
    case '11n':
      return WeatherIcons.night_thunderstorm;
    case '13d':
      return WeatherIcons.day_snow;
    case '13n':
      return WeatherIcons.night_snow;
    case '50d':
      return WeatherIcons.day_fog;
    case '50n':
      return WeatherIcons.night_fog;
    default:
      return WeatherIcons.day_sunny;
  }
}
