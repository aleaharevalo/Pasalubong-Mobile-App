import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color mangoPulse = Color(0xFFFFB100);
  static const Color massKaraPink = Color(0xFFFF007A);
  static const Color deepCharcoal = Color(0xFF2D2D2D); // High contrast text

  static ThemeData get festiveTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mangoPulse,
        primary: mangoPulse,
        secondary: massKaraPink,
      ),
      textTheme: GoogleFonts.montserratTextTheme().copyWith(
        displayLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: deepCharcoal,
        ),
        bodyLarge: GoogleFonts.openSans(color: deepCharcoal),
      ),
    );
  }
}