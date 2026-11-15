import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/models/project_model.dart';
import 'package:portfolio_website/features/portfolio/presentation/pages/project_case_study_page.dart';
import 'package:portfolio_website/features/portfolio/presentation/widgets/project_widgets.dart';

void main() {
  const storySlugs = [
    'responsive-portfolio-ui',
    'cubit-state-management',
    'flutter-web-delivery',
  ];

  testWidgets('portfolio live links use a neutral project label', (
    tester,
  ) async {
    const project = ProjectModel(
      slug: 'portfolio-engineering',
      title: 'Building this portfolio',
      track: ProjectTrack.portfolio,
      context: 'Personal project · Flutter Web',
      role: 'Portfolio developer',
      description: 'A Flutter Web portfolio.',
      tags: ['Flutter'],
      liveUrl: 'https://example.com',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ProjectLinks(project: project)),
      ),
    );

    expect(find.text('View project'), findsOneWidget);
    expect(find.text('View on Steam'), findsNothing);
    expect(find.text('View on App Store'), findsNothing);
  });

  test('portfolio engineering stories have stable, unique routes', () {
    final project = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'portfolio-engineering',
    );

    expect(project.track, ProjectTrack.portfolio);
    expect(project.trackLabel, 'Portfolio Engineering');
    expect(project.supportsStoryNavigation, isTrue);
    expect(
      PortfolioData.projects
          .singleWhere((project) => project.slug == 'odds-and-edges')
          .supportsStoryNavigation,
      isFalse,
    );
    expect(project.stories.map((story) => story.slug), storySlugs);
    expect(project.stories.map((story) => story.slug).toSet(), hasLength(3));
    expect(project.stories.every((story) => story.summary.isNotEmpty), isTrue);
  });

  for (final width in [375.0, 1440.0]) {
    testWidgets('portfolio engineering case study navigates at $width pixels', (
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

      final projectEntry = find.text('Building this portfolio').first;
      await tester.ensureVisible(projectEntry);
      await tester.pumpAndSettle();
      expect(find.text('SUPPORTING / PORTFOLIO ENGINEERING'), findsOneWidget);
      expect(projectEntry.hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);

      final openProject = find.text('Read portfolio case study  →');
      await tester.ensureVisible(openProject);
      await tester.tap(openProject);
      await tester.pumpAndSettle();
      expect(find.byType(ProjectCaseStudyPage), findsOneWidget);
      expect(find.text('Portfolio developer'), findsWidgets);
      expect(find.textContaining('Responsive UI'), findsWidgets);
      expect(find.textContaining('Cubit state'), findsWidgets);
      expect(find.textContaining('Web delivery'), findsWidgets);

      final storyButton = find.textContaining('Open full story: Responsive UI');
      await tester.ensureVisible(storyButton);
      await tester.tap(storyButton);
      await tester.pumpAndSettle();
      expect(find.byType(EngineeringStoryPage), findsOneWidget);
      expect(
        find.text('Building a responsive, modular portfolio'),
        findsOneWidget,
      );

      final storyContext = tester.element(find.byType(EngineeringStoryPage));
      Navigator.of(
        storyContext,
      ).pushNamed('/projects/portfolio-engineering/cubit-state-management');
      await tester.pumpAndSettle();
      expect(find.byType(EngineeringStoryPage), findsOneWidget);
      expect(
        find.text('Migrating theme state and adding focused Cubits'),
        findsOneWidget,
      );

      final cubitStoryContext = tester.element(
        find.byType(EngineeringStoryPage),
      );
      Navigator.of(
        cubitStoryContext,
      ).pushNamed('/projects/portfolio-engineering/flutter-web-delivery');
      await tester.pumpAndSettle();
      expect(
        find.text('Preparing the Flutter portfolio for web release'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  }
}
