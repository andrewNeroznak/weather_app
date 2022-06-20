import 'coord.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });
  late final int id;
  late final String name;
  late final Coord coord;
  late final String country;
  late final int population;
  late final int timezone;
  late final DateTime sunrise;
  late final DateTime sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = Coord.fromJson(json['coord']);
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000);
    sunset = DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000);
  }
}
