import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UNChazaTheme {
  UNChazaTheme._();

  /// Colors
  static const Color darkGrey = Color(0xFF767676);
  static const Color deepGrey = Color(0xFFafafaf);
  static const Color midGrey = Color(0xFFbfbdba);
  static const Color lightGrey = Color(0xFFdfdfdc);
  static const Color mainGrey = Color(0xFFf7f6f0);
  static const Color black = Color(0xFF262114);
  static const Color orange = Color(0xFFf27141);
  static const Color yellow = Color(0xFFffce00);
  static const Color blue = Color(0xFF3c62ad);
  static const Color green = Color(0xFF5fb643);
  static const Color red = Color(0xFFff5f5a);
  static const Color white = Color(0xFFFFFFFF);

  /// Material Color Scheme
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: orange,
    onPrimary: Colors.white,
    secondary: blue,
    onSecondary: Colors.white,
    error: red,
    onError: Colors.white,
    surface: lightGrey,
    onSurface: black,
  );

  /// Text Theme
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.merriweather(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: black,
    ),
    displayMedium: GoogleFonts.bricolageGrotesque(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    headlineMedium: GoogleFonts.bricolageGrotesque(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    headlineSmall: GoogleFonts.bricolageGrotesque(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    titleLarge: GoogleFonts.bricolageGrotesque(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    titleMedium: GoogleFonts.bricolageGrotesque(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    titleSmall: GoogleFonts.bricolageGrotesque(
      fontSize: 9,
      fontWeight: FontWeight.bold,
      color: black,
    ),
    // bodyLarge: GoogleFonts.bricolageGrotesque(
    //   fontSize: 16,
    //   fontWeight: FontWeight.normal,
    //   color: black,
    // ),
    bodyMedium: GoogleFonts.bricolageGrotesque(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: black,
    ),
    bodySmall: GoogleFonts.bricolageGrotesque(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      color: red,
    ),
    labelSmall: GoogleFonts.bricolageGrotesque(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: darkGrey,
    ),
  );
}
