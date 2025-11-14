import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,

    seedColor: const Color.fromARGB(255, 105, 6, 247),
    // surface: const Color.fromARGB(255, 56, 49, 66),
  );

  static final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: colorScheme.onSecondary,
    colorScheme: colorScheme,

    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    ),
  );
}
