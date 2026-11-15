import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/models/project_model.dart';

void main() {
  for (final width in [375.0, 768.0, 900.0, 1024.0, 1440.0]) {
    testWidgets('portfolio hierarchy fits at $width pixels', (tester) async {
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

      expect(
        find.text('Mobile engineer.\nThoughtful systems,\ncarefully built.'),
        findsOneWidget,
      );
      expect(find.text('Explore mobile work  →'), findsOneWidget);
      expect(find.text('Get in touch  →'), findsOneWidget);
      expect(find.text('Resume'), findsNothing);
      expect(
        PortfolioData.projects
            .where((project) => project.track == ProjectTrack.mobile)
            .map((project) => project.slug)
            .toList(),
        ['nuex', 'grounds'],
      );
      expect(find.text('Nuex'), findsWidgets);
      expect(find.text('Grounds'), findsWidgets);
      expect(find.text('Shadow Hills\nManor'), findsWidgets);
      expect(find.text('Odds & Edges'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [375.0, 768.0, 1440.0]) {
    testWidgets('mobile and game cards show store captures at $width pixels', (
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

      final assetNames = tester
          .widgetList<Image>(find.byType(Image))
          .map((image) => image.image)
          .whereType<AssetImage>()
          .map((image) => image.assetName);
      expect(
        assetNames,
        containsAll([
          'assets/images/projects/nuex/hero.png',
          'assets/images/projects/shadow-hills-manor/steam-store-capture.png',
        ]),
      );
      expect(find.text('Nuex — public Google Play listing'), findsOneWidget);
      expect(
        find.text('Shadow Hills Manor — public Steam store listing'),
        findsOneWidget,
      );
      expect(find.text('Public store capture unavailable'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [768.0, 900.0, 1024.0, 1440.0]) {
    testWidgets('Grounds feature preserves natural height at $width pixels', (
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

      expect(
        find.text('Authentication & user-state lifecycle'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('theme toggle is available and switches the page theme', (
    tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider(create: (_) => ThemeCubit(), child: const HamzaSaleemApp()),
    );
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
    final toggle = find.bySemanticsLabel('Switch to light theme');
    expect(toggle, findsOneWidget);
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.light,
    );
  });
}
