import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:lottie/lottie.dart";
import 'package:weather/components/weather_tile.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService =
      WeatherService(apiKey: '2a12a239f5cac74c62862b1a1bf0ad29');
  Weather? _weather;

  String getWeatherAnimation(String condition) {
    if (condition == null) return "sunny";

    switch (condition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "partly";

      case "rain":
      case "drizzle":
      case "thunderstorm":
      case "shower rain":
        return "rainy";

      case "clear":
        return "sunny";

      case "snow":
        return "partly";
    }

    return "sunny";
  }

  _getWeather() async {
    try {
      final position = await weatherService.getCurrentLocationWeather();
      final weather = await weatherService.getWeather(position);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);

      if (e is DioException) {
        print(e.response!.data);
      }
    }
  }

  @override
  void initState() {
    _getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weather != null
          ? Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        Text(_weather!.city,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                        Lottie.asset(
                            'assets/${getWeatherAnimation(_weather!.condition)}.json'),
                        Text(
                          (_weather!.temperature - 273.15).round().toString() +
                              "°C",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        WeatherTile(title: "Wind", children: [
                          Transform.rotate(
                              angle: _weather!.windDirection.toDouble() *
                                  0.0175, // 0.0175 = pi/180
                              child: const Icon(Icons.arrow_upward,
                                  color: Colors.grey)),
                          const SizedBox(height: 5),
                          Text("${_weather!.windSpeed} m/s"),
                        ]),
                        SizedBox(width: 16),
                        WeatherTile(title: "Humidity", children: [
                          const Icon(Icons.water_drop, color: Colors.grey),
                          const SizedBox(height: 5),
                          Text("${_weather!.humidity}%"),
                        ]),
                        SizedBox(width: 16),
                        WeatherTile(title: "Pressure", children: [
                          const Icon(Icons.speed, color: Colors.grey),
                          const SizedBox(height: 5),
                          Text("${_weather!.pressure} hPa"),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
