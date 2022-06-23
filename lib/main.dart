import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/network/config.dart';
import 'package:weather_app/weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final brightness = SchedulerBinding.instance.window.platformBrightness;

  final pref = await SharedPreferences.getInstance();

  final selectedThemeMode = ThemeModeValue.values.firstWhereOrNull(
    (element) => element.name == pref.getString(Config.themeModePrefKey),
  );

  runApp(
    WeatherApp(
        themeModeProvider: ThemeModeProvider(
      selectedThemeMode ??
          (brightness == Brightness.dark
              ? ThemeModeValue.dark
              : ThemeModeValue.light),
    )),
  );
}
