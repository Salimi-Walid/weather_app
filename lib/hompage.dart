// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/reserch/textfeild.dart';
import 'package:weather_app/survice/wather_survice.dart';

class Hompage extends StatefulWidget {
  const Hompage({super.key});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  final WeatherService weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  List<Map<String, dynamic>>? fiveDayForecast;
  String city = 'Sidi Slimane';
  bool isLoading = true;
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeather(city);
  }

  void fetchWeather(String cityName) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await weatherService.fetchWeather(cityName);
      final forecast = await weatherService.fetchFiveDayForecast(cityName);
      setState(() {
        weatherData = data;
        fiveDayForecast = forecast;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearch() {
    String searchCity = cityController.text.trim();
    if (searchCity.isNotEmpty) {
      fetchWeather(searchCity);
    }
  }

  String getAnimationForWeather(String? weatherCondition) {
    if (weatherCondition == null) return 'assets/Thunder and winter.json';
    switch (weatherCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/Thunder and winter.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/mist.json';
      case 'haze':
        return 'assets/the clouds.json';
      case 'fog':
        return 'assets/the clouds.json';
      case 'rain':
        return 'assets/Thunder and winter.json';
      case 'shower rain':
        return 'assets/sun and winterr.json';
      case 'clear':
        return 'assets/Sun.json';
      default:
        return 'assets/Sun.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(111, 1, 120, 255),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/cloud-in-blue-sky.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  // textfeild for reserching city
                  Textfeild(
                    onSearch: onSearch,
                    controller: cityController,
                  ),
                  // name and date and image
                  if (isLoading)
                    const CircularProgressIndicator()
                  else if (weatherData != null) ...[
                    Text(
                      weatherData!['name'],
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    // day
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(225, 255, 255, 255),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // image for weather
                    Lottie.asset(
                      getAnimationForWeather(
                          weatherData!['weather'][0]['main']),
                    ),
                    // darajat lharara in city
                    Text(
                      '${weatherData!['main']['temp']}°C',
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              backgroundColor: Color.fromARGB(72, 0, 0, 0),
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                    ),
                    Card(
                      color: Colors.transparent,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Icon(
                                    Icons.cloudy_snowing,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.air,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.visibility,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    '${weatherData!['main']['humidity']}%',
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${weatherData!['wind']['speed']} km/h',
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${weatherData!['visibility'] / 1000} km',
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  weatherData!['weather'][0]['description'],
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: Text(
                                    'Air',
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Visibility',
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ] else
                    // ila malgach city return this
                    const Text(
                      'NAme of the city is not correct',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            if (fiveDayForecast != null)
              Card(
                color: const Color.fromARGB(72, 1, 1, 1),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.all(15),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Text(
                        'Forecast for the next 5 days',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: fiveDayForecast!.map((day) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EE dd/MM ')
                                      .format(DateTime.parse(day['dt_txt'])),
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Lottie.asset(
                                  getAnimationForWeather(
                                      day['weather'][0]['main']),
                                  width: 50,
                                  height: 50,
                                ),
                                // temps for next day
                                Text(
                                  '${day['main']['temp_max']}°C',
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ])),
              ),
          ],
        )));
  }
}
