import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // Bundled font asset (declared in pubspec.yaml).
  // Covers characters JetBrains Mono lacks: ★, ©, em-dash, CJK, etc.
  static const _notoSansFallback = ['Noto Sans'];

  // ── Serif headings (Noto Serif JP — supports CJK + Latin) ──────────────────

  static TextStyle display(Color color, {double fontSize = 56}) =>
      GoogleFonts.notoSerifJp(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle heading1(Color color, {double fontSize = 36}) =>
      GoogleFonts.notoSerifJp(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle heading2(Color color, {double fontSize = 24}) =>
      GoogleFonts.notoSerifJp(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      );

  // ── Monospace body copy (JetBrains Mono + Noto Sans fallback) ──────────────

  static TextStyle body(Color color) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.7,
      ).copyWith(fontFamilyFallback: _notoSansFallback);

  static TextStyle label(Color color) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 1.5,
      ).copyWith(fontFamilyFallback: _notoSansFallback);

  static TextStyle caption(Color color) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      ).copyWith(fontFamilyFallback: _notoSansFallback);

  static TextStyle navItem(Color color) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.8,
      ).copyWith(fontFamilyFallback: _notoSansFallback);

  static TextStyle button(Color color) =>
      GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 1.2,
      ).copyWith(fontFamilyFallback: _notoSansFallback);
}
