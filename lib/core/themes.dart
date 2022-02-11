import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Themes {
  static Color darkPrimaryColor = Color(0xFF1d1c21);
  static Color darkPrimaryColorLight = Color(0xFF444348);
  static Color darkPrimaryColorDark = Color(0xFF000000);
  static Color darkAccentColor = Color(0xFFff9800);

  static ThemeData getDarkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        secondary: Themes.darkAccentColor,
        primary: Themes.darkPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Themes.darkPrimaryColor,
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      primaryColor: Themes.darkPrimaryColor,
      primaryColorLight: Themes.darkPrimaryColorLight,
      primaryColorDark: Themes.darkPrimaryColorDark,
      iconTheme: IconThemeData(
        color: Themes.darkAccentColor,
      ),
      cardColor: Themes.darkPrimaryColorLight,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Themes.darkPrimaryColorLight,
      ),
      scaffoldBackgroundColor: Themes.darkPrimaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(
            Themes.darkAccentColor,
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
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: Themes.darkAccentColor,
        ),
        hintStyle: TextStyle(
          color: Themes.darkAccentColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Themes.darkPrimaryColorLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Themes.darkPrimaryColorLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Themes.darkAccentColor,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.roboto(
            fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: GoogleFonts.roboto(
            fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headline3:
            GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
        headline4: GoogleFonts.roboto(
            fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5:
            GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
        headline6: GoogleFonts.roboto(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        subtitle2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyText2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        caption: GoogleFonts.roboto(
            fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        overline: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      ),
    );
  }

  static Color primaryColor = Color(0xFFfafafa);
  static Color primaryColorLight = Color(0xFFffffff);
  static Color primaryColorDark = Color(0xFFc7c7c7);
  static Color accentColor = Color(0xFFff9800);

  static ThemeData getLightTheme() {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Themes.primaryColor,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: ColorScheme.dark(
          secondary: Themes.accentColor,
          primary: Themes.primaryColor,
        ),
        primaryColor: Themes.primaryColor,
        primaryColorLight: Themes.primaryColorLight,
        primaryColorDark: Themes.primaryColorDark,
        iconTheme: IconThemeData(
          color: Themes.accentColor,
        ),
        cardColor: Themes.primaryColorLight,
        textSelectionTheme: TextSelectionThemeData(),
        scaffoldBackgroundColor: Themes.primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(
              Themes.accentColor,
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Themes.primaryColor,
          ),
          hintStyle: TextStyle(
            color: Themes.accentColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Themes.darkPrimaryColorLight.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Themes.darkPrimaryColorLight.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Themes.accentColor,
            ),
          ),
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.roboto(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.roboto(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.roboto(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ));
  }
}
