import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme _customTextTheme(TextTheme base) {
    return base.copyWith(
      // Define your custom text styles here for both light and dark themes.
      // For example:
      headline2: GoogleFonts.montserrat(
        color: Colors.black87,
      ),
      subtitle2: GoogleFonts.poppins(
        color: Colors.black54,
        fontSize: 24,
      ),
      // Add more custom text styles as needed.
    );
  }

  static TextTheme lightTextTheme = _customTextTheme(ThemeData.light().textTheme);

  static TextTheme darkTextTheme = _customTextTheme(ThemeData.dark().textTheme);
}
