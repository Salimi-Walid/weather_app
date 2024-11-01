import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'apikey';
  final String apiUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Map<String, dynamic>>> fetchFiveDayForecast(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> forecastList = data['list'];

      // استخراج التوقعات اليومية
      final Map<String, Map<String, dynamic>> dailyForecasts = {};

      for (var forecast in forecastList) {
        String date = forecast['dt_txt'].split(' ')[0];
        if (!dailyForecasts.containsKey(date)) {
          dailyForecasts[date] = forecast;
        } else {
          // تحديث الحد الأقصى لدرجة الحرارة إذا كانت درجة الحرارة الحالية أعلى
          if (forecast['main']['temp_max'] >
              dailyForecasts[date]!['main']['temp_max']) {
            dailyForecasts[date]!['main']['temp_max'] =
                forecast['main']['temp_max'];
          }
        }
      }

      return dailyForecasts.values.toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
