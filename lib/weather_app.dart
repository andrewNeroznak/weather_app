import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_theme.dart';
import 'package:weather_app/routes.dart';

import 'pages/weather_overview_page.dart';

class WeatherApp extends StatelessWidget {
  final ThemeModeProvider themeModeProvider;
  const WeatherApp({Key? key, required this.themeModeProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModeProvider>.value(
      value: themeModeProvider,
      child: Consumer<ThemeModeProvider>(
        builder: ((context, provider, child) => MaterialApp(
              title: 'WeatherApp',
              theme: AppTheme.lightThemeData,
              darkTheme: AppTheme.darkThemeData,
              themeMode: provider.value == ThemeModeValue.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routes: {
                for (final route in Routes.values)
                  route.path: (context) => _pageForRoute(context, route)
              },
            )),
      ),
    );
  }

  Widget _pageForRoute(BuildContext context, Routes route) {
    switch (route) {
      case Routes.weatherOverview:
        return const WeatherOverviewPage();
    }
  }
}

class ThemeModeProvider extends ValueNotifier<ThemeModeValue> {
  ThemeModeProvider(super.value);
}

enum ThemeModeValue { dark, light }
