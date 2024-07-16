import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/reserch/textfeild.dart';

class Hompage extends StatefulWidget {
  const Hompage({super.key});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //column nember 1 for add image weather and degre
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
              child: Column(children: [
                //textfeild for rocherch
                const Textfeild(),
                //text city
                Text(
                  'New Yourk',
                  style: GoogleFonts.getFont('REM',
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                // text date of tuday
                Text(
                  '06 subtember 2024',
                  style: GoogleFonts.getFont('REM',
                      textStyle: const TextStyle(
                          color: Color.fromARGB(225, 255, 255, 255),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                // image for now weather
                Image.asset('p1.jpg'),
                // degre
                Text(
                  '15°C',
                  style: GoogleFonts.getFont('REM',
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 60,
                          fontWeight: FontWeight.bold)),
                )
              ]),
            ),
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
                        '45%',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        '15 km/h',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        '1.5 km',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Snowing',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'Air',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'Visibility',
                        style: GoogleFonts.getFont('REM',
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      )
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
