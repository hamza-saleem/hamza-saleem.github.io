import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Font families (all bundled as local assets) ────────────────────────────
  static const _bodyFamily = 'Poppins';
  static const _serifFamily = 'Noto Serif JP';

  // ── Display & Headings (Noto Serif JP — bundled) ────────────────────────────

  static TextStyle display(Color color, {double fontSize = 56}) => TextStyle(
        fontFamily: _serifFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle heading1(Color color, {double fontSize = 36}) => TextStyle(
        fontFamily: _serifFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle heading2(Color color, {double fontSize = 24}) => TextStyle(
        fontFamily: _serifFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      );

  // ── Body text (Poppins — bundled) ─────────────────────────────────────────

  static TextStyle body(Color color) => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.7,
      );

  static TextStyle label(Color color) => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 1.5,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle navItem(Color color) => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.8,
      );

  static TextStyle button(Color color) => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 1.2,
      );
}
