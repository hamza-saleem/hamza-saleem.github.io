import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/models/project_model.dart';
import 'package:portfolio_website/features/portfolio/presentation/pages/project_case_study_page.dart';
import 'package:portfolio_website/features/portfolio/presentation/sections/projects_section.dart';
import 'package:portfolio_website/features/portfolio/presentation/widgets/project_widgets.dart';

void main() {
  for (final width in [375.0, 768.0, 1440.0]) {
    testWidgets('Track navigation and case studies at $width pixels', (
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
      expect(find.text(PortfolioData.title), findsOneWidget);
      await tester.tap(find.text('View Mobile Work'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Explore my work on Grounds').first);
      await tester.pumpAndSettle();
      expect(
        find.text('Explore my work on Grounds').first.hitTestable(),
        findsOneWidget,
      );
      await tester.tap(find.text('Explore my work on Grounds').first);
      await tester.pumpAndSettle();
      expect(find.byType(ProjectCaseStudyPage), findsOneWidget);
      expect(
        find.text('Role: Flutter Developer / Development Team Member'),
        findsOneWidget,
      );
      expect(find.text('Architectural Direction'), findsNothing);
      await tester.ensureVisible(find.text('Read Authentication & User State'));
      await tester.tap(find.text('Read Authentication & User State'));
      await tester.pumpAndSettle();
      expect(find.byType(EngineeringStoryPage), findsOneWidget);
      expect(
        find.text('Authentication & User State Lifecycle Refactor'),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Back to Grounds'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectCaseStudyPage), findsOneWidget);
      await tester.tap(find.byTooltip('Back to portfolio'));
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(ProjectsSection));
      Navigator.of(context).pushNamed('/projects/shadow-hills-manor');
      await tester.pumpAndSettle();
      expect(
        find.text('Role: Game Programmer / Development Team Member'),
        findsOneWidget,
      );
      expect(find.byType(ProjectTrailer), findsNWidgets(2));
      expect(find.byType(ProjectMediaView), findsNothing);
      expect(find.text('Announcement trailer'), findsOneWidget);
      expect(find.text('Gameplay trailer'), findsOneWidget);
      expect(find.text('Know Buddy Games website'), findsOneWidget);
      expect(find.text('Know Buddy Games YouTube'), findsOneWidget);
      await tester.tap(find.byTooltip('Toggle theme'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  }
  testWidgets('Unavailable media falls back to an explicit placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProjectMediaView(
            media: ProjectMedia(
              asset: 'missing.png',
              caption: 'Test capture',
              alt: 'Test media',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Project image unavailable'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
