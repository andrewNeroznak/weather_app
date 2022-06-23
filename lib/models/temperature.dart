import 'package:weather_app/models/unit.dart';

class Temperature {
  static const double _absoluteZero = 273.15;
  final double _celvin;

  Temperature(this._celvin);

  double get celsius => _celvin - _absoluteZero;

  double get farhenheit => celsius * 1.8 + 32;

  String value(Unit unit, {int fractionDigits = 0}) {
    switch (unit) {
      case Unit.imperial:
        return '${farhenheit.toStringAsFixed(fractionDigits)} F°';
      case Unit.metric:
        return '${celsius.toStringAsFixed(fractionDigits)} C°';
    }
  }
}
