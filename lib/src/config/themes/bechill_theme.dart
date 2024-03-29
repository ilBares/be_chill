import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeChillTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: lightTextTheme,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: lightTextTheme.titleMedium,
      elevation: 0.0,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(lightColorScheme.secondary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(width: 2.0, color: Colors.black87),
        ),
        textStyle: MaterialStateProperty.all(lightTextTheme.bodyLarge),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
      isDense: true,
    ),
  );

  static ColorScheme lightColorScheme = ColorScheme.light(
    primary: Colors.black87,
    secondary: Colors.blueGrey.shade100,
    tertiary: Colors.blueGrey,
    background: Colors.blueGrey.shade50,
    error: Colors.red.shade500,
  );

  static TextTheme lightTextTheme = TextTheme(
    titleLarge: GoogleFonts.roboto(
      fontSize: 40.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 36.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 24.0,
      fontWeight: FontWeight.w200,
      color: Colors.black87,
    ),
    displayLarge: GoogleFonts.roboto(
      fontSize: 28.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14.0,
      color: Colors.black87,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12.0,
      color: Colors.black87,
    ),
  );
}
