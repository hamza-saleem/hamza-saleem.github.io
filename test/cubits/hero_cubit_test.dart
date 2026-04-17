import 'package:bloc_test/bloc_test.dart';
import 'package:portfolio_website/features/portfolio/cubit/hero_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('HeroCubit', () {
    late HeroCubit cubit;

    setUp(() => cubit = HeroCubit());
    tearDown(() => cubit.close());

    test('initial state has null nameWidth', () {
      expect(cubit.state, const HeroState());
      expect(cubit.state.nameWidth, isNull);
    });

    blocTest<HeroCubit, HeroState>(
      'emits measured width on setNameWidth',
      build: HeroCubit.new,
      act: (cubit) => cubit.setNameWidth(320.5),
      expect: () => [const HeroState(nameWidth: 320.5)],
    );

    blocTest<HeroCubit, HeroState>(
      'does not emit when same width is set twice',
      build: HeroCubit.new,
      act: (cubit) {
        cubit.setNameWidth(320.5);
        cubit.setNameWidth(320.5);
      },
      expect: () => [const HeroState(nameWidth: 320.5)],
    );
  });
}
