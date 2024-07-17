import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.nunito(
        fontSize: 64,
        fontWeight: FontWeight.w200,
        color: Colors.deepOrange[900],
      ),
    ));

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepOrange,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
      fontSize: 64,
      fontWeight: FontWeight.w200,
      color: Colors.deepOrange[900],
    ),
  ),
);
