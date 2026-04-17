import 'package:bloc_test/bloc_test.dart';
import 'package:portfolio_website/core/widgets/cubit/hover_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('HoverCubit', () {
    late HoverCubit cubit;

    setUp(() => cubit = HoverCubit());
    tearDown(() => cubit.close());

    test('initial state is false', () {
      expect(cubit.state, isFalse);
    });

    blocTest<HoverCubit, bool>(
      'emits true on enter',
      build: HoverCubit.new,
      act: (cubit) => cubit.onEnter(),
      expect: () => [true],
    );

    blocTest<HoverCubit, bool>(
      'emits false on exit after enter',
      build: HoverCubit.new,
      act: (cubit) {
        cubit.onEnter();
        cubit.onExit();
      },
      expect: () => [true, false],
    );

    blocTest<HoverCubit, bool>(
      'does not emit when exiting from initial state',
      build: HoverCubit.new,
      act: (cubit) => cubit.onExit(),
      expect: () => <bool>[],
    );
  });
}
