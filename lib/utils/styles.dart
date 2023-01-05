
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  Styles._();

  static normalTextStyle(double fontSize, Color textColor) =>
      GoogleFonts.montserrat(
          textStyle: TextStyle(color: textColor, fontSize: fontSize));

}