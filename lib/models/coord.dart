class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });
  late final double lat;
  late final double lon;

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
}
