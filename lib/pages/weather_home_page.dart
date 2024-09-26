import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _weatherData;
  final WeatherService _weatherService = WeatherService();

  void _getWeather() async {
    String city = _controller.text;
    try {
      final data = await _weatherService.fetchWeather(city);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      print(e);
      setState(() {
        _weatherData = null;
      });
    }
  }

  // Method to get Lottie animation based on weather condition
  Widget _getLottieAnimation(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return Lottie.asset('assets/sunny.json', height: 200);
      case 'clouds':
        return Lottie.asset('assets/clouds.json', height: 200);
      case 'rain':
        return Lottie.asset('assets/rainy.json', height: 200);
      case 'snow':
        return Lottie.asset('assets/snow.json', height: 200);
      default:
        return Lottie.asset('assets/sunny.json',
            height: 200); // Default is sunny
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ), // Customize your AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: GoogleFonts.poppins(color: Colors.grey[300]),
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City',
                labelStyle: GoogleFonts.poppins(color: Colors.grey[300]),
                suffixIconColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _getWeather,
                ),
              ),
            ),
            const SizedBox(height: 100),
            _weatherData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Show the Lottie animation based on weather condition
                      _getLottieAnimation(_weatherData!['weather'][0]['main']),
                      const SizedBox(height: 20),
                      Text(
                        'Weather in ${_weatherData!['name']}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Temperature: ${_weatherData!['main']['temp']}°C',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Weather: ${_weatherData!['weather'][0]['description']}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Check the weather in your city.',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
