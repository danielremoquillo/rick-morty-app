import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle characterTileHeader = GoogleFonts.poppins(
    color: const Color(0xFFF5F4F4),
    fontWeight: FontWeight.w600,
  );
  static TextStyle pageTileHeader = GoogleFonts.poppins(
    color: const Color(0xFFF5F4F4),
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static TextStyle characterTileText = GoogleFonts.poppins(
    color: const Color(0xFFF5F4F4),
    fontSize: 12,
  );
  static TextStyle characterTileTextHeader = GoogleFonts.poppins(
    color: const Color.fromARGB(110, 245, 244, 244),
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static TextStyle pageNumberText = GoogleFonts.poppins(
    color: const Color(0xFFF5F4F4),
  );
  static TextStyle appBarTitleText = GoogleFonts.poppins(
    color: const Color(0xFF262B32),
    fontSize: 21,
    fontWeight: FontWeight.w500,
  );
  static TextStyle appBarText = GoogleFonts.poppins(
    color: const Color(0xFF262B32),
    fontSize: 16,
  );

  static const Color characterTileColor = Color(0xFF3D3E45);
  static const Color characterTextColor = Color(0xFFF5F4F4);
  static const Color scaffoldBackgroundColor = Color(0xFF262B32);
  static const Color appBarBackgroundColor = Color(0xFFFFFEFE);
  static const Color appBarTextColor = Color(0xFF262B32);
  static const Color pageTitleColor = Color(0xFFF5F4F4);
  static const Color contrastColor = Color(0xFFF5F4F4);
  static const Color limitIconColor = Color(0xFF3D3E45);
}
