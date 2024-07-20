import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/reserch/textfeild.dart'; // Ensure this import is correct
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
  String city = 'New York';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    setState(() {
      isLoading = true;
    });
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
      // Handle error (e.g., show a message to the user)
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
                  const Textfeild(),
                  if (isLoading)
                    CircularProgressIndicator()
                  else if (weatherData != null) ...[
                    Text(
                      weatherData!['name'],
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      '06 September 2024', // Replace with dynamic date if needed
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(225, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    Image.asset(
                        'assets/p1.jpg'), // Ensure image path is correct
                    Text(
                      '${weatherData!['main']['temp']}°C',
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                    ),
                  ] else
                    const Text(
                      'Failed to load weather data',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            if (weatherData != null)
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(15),
                width: 500,
                height: 130,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 255, 213),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.cloudy_snowing,
                          size: 30,
                        ),
                        Icon(
                          Icons.air,
                          size: 30,
                        ),
                        Icon(
                          Icons.visibility,
                          size: 30,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${weatherData!['main']['humidity']}%',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          '${weatherData!['wind']['speed']} km/h',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          '${weatherData!['visibility'] / 1000} km',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
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
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          'Air',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          'Visibility',
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
