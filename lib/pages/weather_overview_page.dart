import 'dart:convert';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/icons/unit_icons.dart';
import 'package:weather_app/models/unit.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/network/api_client.dart';
import 'package:weather_app/network/config.dart';
import 'package:weather_app/weather_app.dart';
import 'package:weather_app/widgets/current_weather.dart';
import 'package:weather_app/widgets/notifcation_view.dart';
import 'package:weather_icons/weather_icons.dart';

import '../features/weather_search_delegate.dart';
import '../models/day_forecast.dart';

class _Data {
  final Weather weather;
  final List<String> cities;

  _Data copyWith({Weather? weather, List<String>? cities}) {
    return _Data(weather ?? this.weather, cities ?? this.cities);
  }

  _Data(this.weather, this.cities);
}

class WeatherOverviewPage extends StatefulWidget {
  const WeatherOverviewPage({Key? key}) : super(key: key);

  @override
  State<WeatherOverviewPage> createState() => _WeatherOverviewPageState();
}

class _WeatherOverviewPageState extends State<WeatherOverviewPage> {
  CancelableOperation<_Data>? _future;
  String _selectedCity = 'Oslo';
  DayForecast? _selectedDayForecast;
  _Data? _data;
  List<String>? _cities;
  Unit _selectedUnit = Unit.metric;

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(
      _fetchData(_selectedCity),
    );
  }

  @override
  void dispose() {
    _future?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<_Data>(
          future: _future?.value,
          initialData: _data,
          builder: (context, snapshot) {
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;

            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: NotificationView.fromError(
                  snapshot.error!,
                  context: context,
                  onRetry: () {
                    setState(() {
                      _future = CancelableOperation.fromFuture(
                          _fetchData(_selectedCity));
                    });
                  },
                ),
              );
            } else {
              final Weather weather = snapshot.data!.weather;

              return SafeArea(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () async {
                    final data = await _fetchData(_selectedCity);

                    setState(() {
                      _data = data;
                    });
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () {
                    _refreshController.loadComplete();
                  },
                  enablePullDown: true,
                  child: CustomScrollView(
                    slivers: [
                      _buildSliverAppBar(snapshot.data!.cities),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CurrentWeather(
                                  selectedCity: _selectedCity,
                                  weather: _selectedDayForecast!,
                                  selectedUnit: _selectedUnit,
                                  sunrise: weather.city.sunrise,
                                  sunset: weather.city.sunset,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _buildForecastDays(weather.forecasts),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _buildSliverAppBar(List<String> cities) {
    return SliverAppBar(backgroundColor: Colors.transparent, actions: [
      IconButton(
        onPressed: () async {
          final result = await showSearch(
            context: context,
            delegate: WeatherSearchDelegate(
              cities,
            ),
          );
          if (result == null) {
            return;
          }

          setState(() {
            _selectedCity = result;
            _future = CancelableOperation.fromFuture(
              _fetchData(result),
            );
          });
        },
        icon: const Icon(
          Icons.search,
        ),
      ),
      IconButton(
        onPressed: () {
          setState(() {
            _selectedUnit =
                _selectedUnit == Unit.imperial ? Unit.metric : Unit.imperial;
          });
        },
        icon: Icon(
          _selectedUnit != Unit.metric
              ? UnitIcons.celcius
              : UnitIcons.fahrenheit,
          size: 40,
        ),
      ),
      Consumer<ThemeModeProvider>(builder: (context, provider, _) {
        return IconButton(
          onPressed: () {
            provider.value = provider.value == ThemeModeValue.dark
                ? ThemeModeValue.light
                : ThemeModeValue.dark;

            SharedPreferences.getInstance().then((value) =>
                value.setString(Config.themeModePrefKey, provider.value.name));
          },
          icon: Icon(provider.value == ThemeModeValue.dark
              ? Icons.dark_mode
              : Icons.light_mode),
        );
      })
    ]);
  }

  Widget _buildForecastDays(List<DayForecast> data) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final dayForecast = data[index];

          return AspectRatio(
            aspectRatio: 9 / 12,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () => _setSelectedDay(dayForecast),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14,
                  ),
                  child: Column(
                    children: [
                      Text(DateFormat.EEEE().format(dayForecast.dt)),
                      const SizedBox(
                        height: 20,
                      ),
                      BoxedIcon(dayForecast.weatherIcon),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        dayForecast.temp.value(_selectedUnit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  Future<List<String>> _parseCities() async {
    final String response = await rootBundle.loadString('data/cities.json');
    final decoded = json.decode(response);
    return List<String>.from(
      decoded.map(
        (e) => e['name'],
      ),
    );
  }

  Future<_Data> _fetchData(String city) async {
    final ApiClient apiClient = ApiClient();
    final getForecastFuture = apiClient.fetchForecast(city);
    final getCitiesFuture =
        _cities != null ? Future.value(_cities) : _parseCities();
    return Future.wait([getForecastFuture, getCitiesFuture], eagerError: true)
        .then((data) {
      final weather = data[0] as Weather;
      final cities = data[1] as List<String>;
      if (mounted) {
        final firstDay = weather.forecasts.firstOrNull;

        setState(() {
          _cities = cities;
          _selectedDayForecast ??= firstDay;
        });
      }
      return _Data(weather, cities);
    });
  }

  void _setSelectedDay(DayForecast dayForecast) {
    setState(() {
      _selectedDayForecast = dayForecast;
    });
  }
}
