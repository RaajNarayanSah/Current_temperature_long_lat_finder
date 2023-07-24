import '../models/location_model.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class ApiServices {
  // TO GET LOCATION
  Future<LocationModel?> getLocation(int pincode) async {
    var url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse[0]['Status'] == "Success") {
        var result = jsonResponse[0]['PostOffice'][0];
        var locationData = LocationModel.fromMap(result);
        return locationData;
      } else {
        return null;
      }
    }
    return null;
  }

  // TO GET WEATHER

  Future<WeatherModel?> getWeather(String city) async {
    var url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=35c9f92ac5bf4df0811144140212307&q=$city&aqi=no');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var result = jsonResponse;
      var weatherData = WeatherModel.fromMap(result);
      return weatherData;
    }
    return null;
  }
}
