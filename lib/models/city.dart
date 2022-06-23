class City {
  late final int id;
  late final String name;
  late final DateTime sunrise;
  late final DateTime sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sunrise = DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000);
    sunset = DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000);
  }
}
