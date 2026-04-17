import 'package:bloc_test/bloc_test.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit cubit;

    setUp(() => cubit = ThemeCubit());
    tearDown(() => cubit.close());

    test('initial state is dark', () {
      expect(cubit.state, const ThemeState());
      expect(cubit.state.isDark, isTrue);
      expect(cubit.state.mode, AppThemeMode.dark);
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits light when toggled from dark',
      build: ThemeCubit.new,
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [const ThemeState(mode: AppThemeMode.light)],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits dark when toggled twice',
      build: ThemeCubit.new,
      act: (cubit) {
        cubit.toggleTheme();
        cubit.toggleTheme();
      },
      expect: () => [
        const ThemeState(mode: AppThemeMode.light),
        const ThemeState(mode: AppThemeMode.dark),
      ],
    );
  });
}
