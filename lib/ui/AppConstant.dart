import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  static Color backgroundcolor = const Color.fromARGB(255, 128, 234, 255);
  static TextStyle fancyheader =
      GoogleFonts.flavors(fontSize: 40, color: Colors.deepPurple[300]);
  static TextStyle fancyheader2 =
      GoogleFonts.flavors(fontSize: 30, color: Colors.deepPurple[300]);
  static TextStyle textBody =
      GoogleFonts.flavors(fontSize: 16, color: Colors.deepPurple[300]);
  static TextStyle textBodyfocus =
      GoogleFonts.lato(fontSize: 20, color: Colors.deepPurple[300]);
  static TextStyle texterror = TextStyle(
      color: Colors.red[300], fontSize: 16, fontStyle: FontStyle.italic);
  static TextStyle link = TextStyle(color: Colors.purple[300], fontSize: 16);
  // static  appbarcolor =
  //     GoogleFonts.flavors(fontSize: 40, color: Colors.deepPurple[300]);
}
