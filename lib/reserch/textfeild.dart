import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfeild extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  const Textfeild(
      {super.key, required this.onSearch, required this.controller});

  @override
  State<Textfeild> createState() => _TextfeildState();
}

class _TextfeildState extends State<Textfeild> {
  //final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 30, 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      height: 52,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          // icon for add fonctio serch weather city
          suffixIcon: GestureDetector(
              onTap: widget.onSearch, child: const Icon(Icons.search)),
          hintText: 'Reserche',
          hintStyle: GoogleFonts.getFont('REM',
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 26, 25, 25),
              )),
        ),
      ),
    );
  }
}
