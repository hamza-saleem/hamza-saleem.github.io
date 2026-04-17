enum AppThemeMode { dark, light }

class ThemeState {
  const ThemeState({this.mode = AppThemeMode.dark});

  final AppThemeMode mode;

  bool get isDark => mode == AppThemeMode.dark;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ThemeState && other.mode == mode;

  @override
  int get hashCode => mode.hashCode;
}
