import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';
import 'package:portfolio_website/features/portfolio/presentation/pages/portfolio_page.dart';

void main() {
  for (final width in [375.0, 1440.0]) {
    testWidgets('design system preview renders at $width pixels', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        BlocProvider(
          create: (_) => ThemeCubit(),
          child: const HamzaSaleemApp(),
        ),
      );
      await tester.pumpAndSettle();
      Navigator.of(
        tester.element(find.byType(PortfolioPage)),
      ).pushNamed('/design-system');
      await tester.pumpAndSettle();

      expect(find.text('Design system'), findsOneWidget);
      expect(find.text('Color palette'), findsOneWidget);
      expect(find.text('Typography'), findsOneWidget);
      expect(find.text('Spacing scale'), findsOneWidget);
      expect(find.text('Project card'), findsOneWidget);
      expect(find.text('Focus & hover'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
