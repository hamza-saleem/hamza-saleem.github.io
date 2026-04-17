import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

export 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggleTheme() {
    emit(ThemeState(
      mode: state.isDark ? AppThemeMode.light : AppThemeMode.dark,
    ));
  }
}
