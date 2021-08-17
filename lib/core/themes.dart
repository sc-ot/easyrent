import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData darkTheme = ThemeData(
      primaryColor: Color(0xFF1d1c21),
      primaryColorLight: Color(0xFF444348),
      primaryColorDark: Color(0xFF000000),
      accentColor: Color(0xFFff9800),
      iconTheme: IconThemeData(
        color: Color(0xFFff9800),
      ),
      cardColor: Color(0xFF444348),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Color(0xFF444348),
      ),
      scaffoldBackgroundColor: Color(0xFF1d1c21),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(
           Color(0xFFff9800),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: Color(0xFF1d1c21),
        ),
        hintStyle: TextStyle(
          color: Color(0xFFff9800),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF444348),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF444348),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFff9800),
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.roboto(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: Colors.white,
        ),
        headline2: GoogleFonts.roboto(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        headline3: GoogleFonts.roboto(
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headline4: GoogleFonts.roboto(
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: Colors.white,
        ),
        headline5: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headline6: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: Colors.white,
        ),
        subtitle1: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: Colors.white,
        ),
        subtitle2: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        bodyText2: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: Colors.white,
        ),
        button: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          color: Colors.white,
        ),
        caption: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: Colors.white,
        ),
        overline: GoogleFonts.roboto(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ));
}
