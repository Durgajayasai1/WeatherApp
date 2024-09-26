import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  //API key
  final String apiKey = '887d3609656908972a346524d67cc852';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
