import 'unit.dart';

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });
  late final WindSpeed speed;
  late final int deg;
  late final double gust;

  Wind.fromJson(Map<String, dynamic> json) {
    speed = WindSpeed(json['speed'].toDouble());
    deg = json['deg'];
    gust = json['gust'].toDouble();
  }
}

class WindSpeed {
  final double _meterPerSecond;

  WindSpeed(this._meterPerSecond);

  double get metersPerSecond => _meterPerSecond;
  double get kilometersPerHour => metersPerSecond * 3.6;

  double get milesPerHour => metersPerSecond * 2.237;

  String value(Unit unit, {int fractionDigits = 0}) {
    switch (unit) {
      case Unit.metric:
        return '${kilometersPerHour.toStringAsFixed(fractionDigits)} km/h';
      case Unit.imperial:
        return '${milesPerHour.toStringAsFixed(fractionDigits)} mph';
    }
  }
}
