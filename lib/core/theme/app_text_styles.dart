import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // JetBrains Mono is bundled as a font asset in pubspec.yaml.
  // Noto Sans (also bundled) covers glyphs JetBrains Mono lacks: ★, ©, em-dash, etc.
  static const _monoFamily = 'JetBrains Mono';
  static const _notoSansFallback = ['Noto Sans'];

  // ── Serif headings (Noto Serif JP — network via google_fonts CDN) ───────────
  // Kept on the CDN because the full CJK font file is ~13 MB; Google serves
  // a tiny language-subsetted WOFF2 (~50–80 KB) instead.

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

  // ── Monospace body copy (JetBrains Mono — bundled asset) ───────────────────

  static TextStyle body(Color color) => TextStyle(
        fontFamily: _monoFamily,
        fontFamilyFallback: _notoSansFallback,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.7,
      );

  static TextStyle label(Color color) => TextStyle(
        fontFamily: _monoFamily,
        fontFamilyFallback: _notoSansFallback,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 1.5,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontFamily: _monoFamily,
        fontFamilyFallback: _notoSansFallback,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle navItem(Color color) => TextStyle(
        fontFamily: _monoFamily,
        fontFamilyFallback: _notoSansFallback,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.8,
      );

  static TextStyle button(Color color) => TextStyle(
        fontFamily: _monoFamily,
        fontFamilyFallback: _notoSansFallback,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 1.2,
      );
}
