import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    background: HamzaSaleemColors.darkBackground,
    surface: HamzaSaleemColors.darkSurface,
    card: HamzaSaleemColors.darkCard,
    rule: HamzaSaleemColors.darkRule,
    text: HamzaSaleemColors.darkTextPrimary,
    secondaryText: HamzaSaleemColors.darkTextSecondary,
    accent: HamzaSaleemColors.sand,
    accentHover: HamzaSaleemColors.sandHover,
  );

  static ThemeData light() => _build(
    brightness: Brightness.light,
    background: HamzaSaleemColors.lightBackground,
    surface: HamzaSaleemColors.lightSurface,
    card: HamzaSaleemColors.lightCard,
    rule: HamzaSaleemColors.lightRule,
    text: HamzaSaleemColors.lightTextPrimary,
    secondaryText: HamzaSaleemColors.lightTextSecondary,
    accent: HamzaSaleemColors.sandDark,
    accentHover: HamzaSaleemColors.sandDarkHover,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color card,
    required Color rule,
    required Color text,
    required Color secondaryText,
    required Color accent,
    required Color accentHover,
  }) {
    final dark = brightness == Brightness.dark;
    final foreground = dark
        ? HamzaSaleemColors.darkBackground
        : HamzaSaleemColors.lightBackground;
    final primaryButton = dark ? accent : text;
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.tight),
    );

    return ThemeData(
      brightness: brightness,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryButton,
        onPrimary: foreground,
        secondary: accentHover,
        onSecondary: foreground,
        error: dark ? const Color(0xFFFFB4AB) : const Color(0xFF8C1D18),
        onError: dark ? const Color(0xFF690005) : Colors.white,
        surface: surface,
        onSurface: text,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: text,
          fontFamily: 'Noto Serif JP',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerColor: rule,
      focusColor: accent.withValues(alpha: 0.2),
      hoverColor: accent.withValues(alpha: 0.08),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
        selectionColor: accent.withValues(alpha: 0.25),
        selectionHandleColor: accent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(buttonShape),
          foregroundColor: WidgetStatePropertyAll(foreground),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return accent.withValues(alpha: 0.35);
            }
            if (states.contains(WidgetState.hovered)) {
              return dark ? accentHover : text.withValues(alpha: 0.88);
            }
            return primaryButton;
          }),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return accent.withValues(alpha: 0.24);
            }
            if (states.contains(WidgetState.hovered)) {
              return foreground.withValues(alpha: 0.08);
            }
            return null;
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(buttonShape),
          foregroundColor: WidgetStatePropertyAll(text),
          side: WidgetStateProperty.resolveWith((states) {
            return BorderSide(
              color: states.contains(WidgetState.focused) ? accent : rule,
              width: states.contains(WidgetState.focused) ? 2 : 1,
            );
          }),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused) ||
                states.contains(WidgetState.hovered)) {
              return accent.withValues(alpha: 0.12);
            }
            return null;
          }),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          foregroundColor: WidgetStatePropertyAll(text),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused) ||
                states.contains(WidgetState.hovered)) {
              return accent.withValues(alpha: 0.12);
            }
            return null;
          }),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: card,
        side: BorderSide(color: rule),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.tight),
        ),
        labelStyle: TextStyle(color: secondaryText, fontFamily: 'Poppins'),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
      useMaterial3: true,
    );
  }
}

extension ThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bgColor => isDark
      ? HamzaSaleemColors.darkBackground
      : HamzaSaleemColors.lightBackground;

  Color get surfaceColor =>
      isDark ? HamzaSaleemColors.darkSurface : HamzaSaleemColors.lightSurface;

  Color get cardColor =>
      isDark ? HamzaSaleemColors.darkCard : HamzaSaleemColors.lightCard;

  Color get ruleColor =>
      isDark ? HamzaSaleemColors.darkRule : HamzaSaleemColors.lightRule;

  Color get textPrimary => isDark
      ? HamzaSaleemColors.darkTextPrimary
      : HamzaSaleemColors.lightTextPrimary;

  Color get textSecondary => isDark
      ? HamzaSaleemColors.darkTextSecondary
      : HamzaSaleemColors.lightTextSecondary;

  Color get accent =>
      isDark ? HamzaSaleemColors.sand : HamzaSaleemColors.sandDark;

  Color get accentHover =>
      isDark ? HamzaSaleemColors.sandHover : HamzaSaleemColors.sandDarkHover;

  Color get accentForeground => isDark
      ? HamzaSaleemColors.darkBackground
      : HamzaSaleemColors.lightBackground;
}
