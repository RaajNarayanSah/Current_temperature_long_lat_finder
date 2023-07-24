class WeatherModel {
  final Location location;
  final Current current;

  WeatherModel({
    required this.location,
    required this.current,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        location: Location.fromMap(json["location"]),
        current: Current.fromMap(json["current"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "current": current.toMap(),
      };
}

class Current {
  final double tempC;
  final double tempF;

  Current({
    required this.tempC,
    required this.tempF,
  });

  factory Current.fromMap(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"],
        tempF: json["temp_f"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "temp_c": tempC,
        "temp_f": tempF,
      };
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
      };
}
