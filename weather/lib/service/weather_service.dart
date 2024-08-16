import "package:dio/dio.dart";
import "package:geolocator/geolocator.dart";
import "package:weather/models/weather_model.dart";

class WeatherService {
  // https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&appid={API key}
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final dio = Dio();
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(Position position) async {
    final response = await dio.get(BASE_URL, queryParameters: {
      'lat': position.latitude,
      'lon': position.longitude,
      'appid': apiKey,
    });

    print(response.data);

    return Weather(
      temperature: response.data['main']['temp'],
      condition: response.data['weather'][0]['main'],
      city: response.data['name'],
      feelsLike: response.data['main']['feels_like'],
      humidity: response.data['main']['humidity'],
      windSpeed: response.data['wind']['speed'],
      windDirection: response.data['wind']['deg'],
      pressure: response.data['main']['pressure'],
    );
  }

  Future getCurrentLocationWeather() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );

    // List<Placemark> placemarks = placemarkFromCoordinates();

    return position;
  }
}
