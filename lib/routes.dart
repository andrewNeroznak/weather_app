enum Routes { weatherOverview }

extension Name on Routes {
  String get path {
    switch (this) {
      case Routes.weatherOverview:
        return '/';
    }
  }
}
