import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/style/const.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightColor,
    primaryColorDark: black,
    unselectedWidgetColor: black,
    scaffoldBackgroundColor: white,
    textTheme: TextTheme(
      //today
      headlineLarge: GoogleFonts.quicksand(
          fontWeight: FontWeight.w900, fontSize: 20, color: black),
      //add&&edit task
      headlineMedium: GoogleFonts.quicksand(
        fontWeight: FontWeight.w900,
        color: black,
        fontSize: 18,
      ),
      //choose
      headlineSmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.w900,
        fontSize: 16,
        color: black,
      ),
      //task title
      bodyLarge: GoogleFonts.poppins(
        color: lightColor,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      //task des
      bodySmall: GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          GoogleFonts.quicksand(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(
          lightColor,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: black,
    ),
    cardColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkColor,
    primaryColorDark: white,
    scaffoldBackgroundColor: black,
    textTheme: TextTheme(
      //today
      headlineLarge: GoogleFonts.quicksand(
          fontWeight: FontWeight.w900, fontSize: 20, color: white),
      //add&&edit task
      headlineMedium: GoogleFonts.quicksand(
        fontWeight: FontWeight.w900,
        color: white,
        fontSize: 18,
      ),
      //choose
      headlineSmall: GoogleFonts.quicksand(
        fontWeight: FontWeight.w900,
        fontSize: 16,
        color: white,
      ),
      //task title
      bodyLarge: GoogleFonts.poppins(
        color: darkColor,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      //task des
      bodySmall: GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          GoogleFonts.quicksand(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(
          darkColor,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: white,
    ),
    cardColor: Colors.white,
  );

}
