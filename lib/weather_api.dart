import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skycast/weather_model.dart';

class WeatherApi {
  Future<Weather> fetchWeather(String cityName) async {
    final apiKey = '127d4cd7cb143a28e41e762852089ae9';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
