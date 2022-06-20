enum Routes { home }

extension Name on Routes {
  String get path {
    switch (this) {
      case Routes.home:
        return '/';
    }
  }
}
