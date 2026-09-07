import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: HamzaSaleemColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: HamzaSaleemColors.sand,
          secondary: HamzaSaleemColors.sandHover,
          surface: HamzaSaleemColors.darkSurface,
          onSurface: HamzaSaleemColors.darkTextPrimary,
        ),
        dividerColor: HamzaSaleemColors.darkRule,
        useMaterial3: true,
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: HamzaSaleemColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: HamzaSaleemColors.sandDark,
          secondary: HamzaSaleemColors.sandDarkHover,
          surface: HamzaSaleemColors.lightSurface,
          onSurface: HamzaSaleemColors.lightTextPrimary,
        ),
        dividerColor: HamzaSaleemColors.lightRule,
        useMaterial3: true,
      );
}

extension ThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bgColor =>
      isDark ? HamzaSaleemColors.darkBackground : HamzaSaleemColors.lightBackground;

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
