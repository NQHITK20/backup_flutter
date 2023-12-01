import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static Color backgroundcolor = const Color.fromARGB(255, 128, 234, 255);
  static TextStyle fancyheader =
      GoogleFonts.flavors(fontSize: 40, color: Colors.deepPurple[300]);
  static TextStyle fancyheader2 =
      GoogleFonts.flavors(fontSize: 30, color: Colors.deepPurple[300]);
  static TextStyle textBody =
      GoogleFonts.flavors(fontSize: 16, color: Colors.deepPurple[300]);
  static TextStyle textBodywhite =
      GoogleFonts.flavors(fontSize: 16, color: Colors.white);
  static TextStyle textBodyfocus =
      GoogleFonts.lato(fontSize: 20, color: Colors.deepPurple[300]);
  static TextStyle textBodyfocuswhite =
      GoogleFonts.lato(fontSize: 20, color: Colors.white);
  static TextStyle textBodyfocuswhitebold = GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle texterror = TextStyle(
      color: Colors.red[300], fontSize: 16, fontStyle: FontStyle.italic);
  static TextStyle link = TextStyle(color: Colors.purple[300], fontSize: 16);
  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/mm/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
