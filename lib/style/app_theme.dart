import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores Básicas Compartilhadas
  static const Color primary = Color(0xFFEBC42A);
  static const Color secondary = Color(0xFFF57777);

  // -- Tema Claro --
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(
      background: Color(0xFFF5F5F5),
      onBackground: Color(0xFF0F0F0F),
      primary: primary,
      secondary: secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F5F5),
      foregroundColor: Color(0xFF0F0F0F),
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserrat(
        fontSize: 40,
        color: const Color(0xFF0F0F0F),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 15,
        color: const Color(0xFF0F0F0F),
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 12,
        color: const Color(0xFF0F0F0F),
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 10,
        color: const Color(0xFF0F0F0F),
      ),
    ),
  );

  // -- Tema Escuro --
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1E1E2C), // Cor de fundo escura
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF1E1E2C),
      onBackground: Color(0xFFFFFFFF), // Texto branco
      primary: primary,
      secondary: secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E2C),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserrat(
        fontSize: 40,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 15,
        color: const Color(0xFFFFFFFF),
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 12,
        color: const Color(0xFFFFFFFF),
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 10,
        color: const Color(0xFFFFFFFF),
      ),
    ),
  );
}