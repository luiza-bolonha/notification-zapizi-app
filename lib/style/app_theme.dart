import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: textTheme,
);

const colorScheme = ColorScheme.light(
  background: Color(0xFFF5F5F5),
  onBackground: Color(0xFF0F0F0F),
  primary: Color(0xFFEBC42A),
  secondary: Color(0xFFF57777),
);

final textTheme = TextTheme(
  titleLarge: GoogleFonts.montserrat(
    fontSize: 40,
    color: colorScheme.onBackground,
    fontWeight: FontWeight.bold
  ),
  bodyLarge: GoogleFonts.montserrat(
      fontSize: 15,
      color: colorScheme.onBackground,
  ),
  bodyMedium: GoogleFonts.montserrat(
      fontSize: 12,
      color: colorScheme.onBackground
  ),
  bodySmall: GoogleFonts.montserrat(
      fontSize: 10,
      color: colorScheme.onBackground
  ),

);