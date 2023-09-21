import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData{
  static const Color lightColor = Color(0xFF5D9CEC);
  static const Color greenColor = Color(0xFF61E757);
  static const Color lightGreenColor = Color(0xFFDFECDB);
  static const Color darkColor =Color(0xFF060E1E);
  static ThemeData lightTheme = ThemeData(
    primaryColor: lightColor,
    scaffoldBackgroundColor:  Colors.transparent,
    textTheme:  TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: lightColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
      bodySmall: GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      //day in task
      titleSmall: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkColor,
    scaffoldBackgroundColor:  Colors.transparent,
    textTheme:  TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: lightColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodySmall: GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: Colors.white,
      ),
    ),
  );
}