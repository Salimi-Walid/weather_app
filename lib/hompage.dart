// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/reserch/textfeild.dart';
import 'package:weather_app/survice/wather_survice.dart';

// Import your WeatherService

class Hompage extends StatefulWidget {
  const Hompage({super.key});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  final WeatherService weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  String city = 'Sidi Slimane';
  bool isLoading = true;
  TextEditingController cityController = TextEditingController();

  //animatin image

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    //normal data if entre 1er fois citi <sidi slimane> hit diclaration in top
    try {
      final data = await weatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
    // data for secherching in textfeild
    try {
      city = cityController.text;
      final data = await weatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //animatin image
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(155, 0, 105, 243),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  // textfeild for reserching city
                  Textfeild(
                    onSearch: fetchWeather,
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                    ),
                  ] else
                    // ila malgach city return this
                    const Text(
                      'Failed to load weather data',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            if (weatherData != null)
              Card(
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
                            child: Icon(Icons.cloudy_snowing, size: 30),
                          ),
                          Icon(Icons.air, size: 30),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(Icons.visibility, size: 30),
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
                                  color: Colors.black,
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
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${weatherData!['visibility'] / 1000} km',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
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
                                color: Colors.black,
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
                                  color: Colors.black,
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
                                color: Colors.black,
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
          ],
        ),
      ),
    );
  }
}
