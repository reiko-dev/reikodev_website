import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final customThemeData = ThemeData(
  primarySwatch: Colors.red,
  backgroundColor: const Color(0xFF070d12),
  // hoverColor: const Color(0xFFc278b9),
  hoverColor: const Color(0xFF75cdfa),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 148, 147, 147)),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 238, 236, 236),
    space: 25,
    thickness: .3,
    endIndent: 3.5,
    indent: 3.5,
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoCondensed(color: Colors.white),
    headline2: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 20),
    headline3: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 16),
    headline5: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 14),
    subtitle1: GoogleFonts.robotoCondensed(
        color: const Color(0xFF9a9a9a), fontSize: 16),
  ),
);
