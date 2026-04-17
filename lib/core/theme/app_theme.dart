import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: KageMichiColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: KageMichiColors.sand,
          secondary: KageMichiColors.sandHover,
          surface: KageMichiColors.darkSurface,
          onSurface: KageMichiColors.darkTextPrimary,
        ),
        dividerColor: KageMichiColors.darkRule,
        useMaterial3: true,
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: KageMichiColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: KageMichiColors.sandDark,
          secondary: KageMichiColors.sandDarkHover,
          surface: KageMichiColors.lightSurface,
          onSurface: KageMichiColors.lightTextPrimary,
        ),
        dividerColor: KageMichiColors.lightRule,
        useMaterial3: true,
      );
}

extension ThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bgColor =>
      isDark ? KageMichiColors.darkBackground : KageMichiColors.lightBackground;

  Color get surfaceColor =>
      isDark ? KageMichiColors.darkSurface : KageMichiColors.lightSurface;

  Color get cardColor =>
      isDark ? KageMichiColors.darkCard : KageMichiColors.lightCard;

  Color get ruleColor =>
      isDark ? KageMichiColors.darkRule : KageMichiColors.lightRule;

  Color get textPrimary => isDark
      ? KageMichiColors.darkTextPrimary
      : KageMichiColors.lightTextPrimary;

  Color get textSecondary => isDark
      ? KageMichiColors.darkTextSecondary
      : KageMichiColors.lightTextSecondary;

  Color get accent =>
      isDark ? KageMichiColors.sand : KageMichiColors.sandDark;

  Color get accentHover =>
      isDark ? KageMichiColors.sandHover : KageMichiColors.sandDarkHover;

  Color get accentForeground => isDark
      ? KageMichiColors.darkBackground
      : KageMichiColors.lightBackground;
}
