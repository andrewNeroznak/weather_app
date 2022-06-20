import 'package:flutter/material.dart';
import 'package:weather_app/routes.dart';

import 'pages/weather_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      routes: {
        for (final route in Routes.values)
          route.path: (context) => _pageForRoute(context, route)
      },
    );
  }

  Widget _pageForRoute(BuildContext context, Routes route) {
    switch (route) {
      case Routes.home:
        return const WeatherPage();
    }
  }
}
