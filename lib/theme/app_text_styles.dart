import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle display(Color color) => GoogleFonts.notoSerifJp(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle heading1(Color color) => GoogleFonts.notoSerifJp(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle heading2(Color color) => GoogleFonts.notoSerifJp(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      );

  static TextStyle body(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.7,
      );

  static TextStyle label(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 1.5,
      );

  static TextStyle caption(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle navItem(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.8,
      );

  static TextStyle button(Color color) => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 1.2,
      );
}
