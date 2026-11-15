import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app_routes.dart';
import 'package:portfolio_website/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:portfolio_website/features/portfolio/presentation/pages/project_case_study_page.dart';
import 'package:portfolio_website/features/portfolio/presentation/sections/contact_section.dart';

void main() {
  testWidgets('project routes resolve to their case-study page', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(onGenerateRoute: generateAppRoute));
    await tester.pumpAndSettle();

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamed('/projects/grounds');
    await tester.pumpAndSettle();

    expect(find.byType(ProjectCaseStudyPage), findsOneWidget);
    expect(find.byType(SelectionArea), findsOneWidget);
    expect(find.byType(ContactSection), findsOneWidget);
    expect(find.text('Grounds'), findsWidgets);
    expect(find.text('MY CONTRIBUTION'), findsOneWidget);
    expect(
      find.text('Incremental changes.\nProduction constraints.'),
      findsOneWidget,
    );
    expect(find.text('01 / State lifecycle'), findsOneWidget);
    expect(find.text('02 / Exercise logging'), findsOneWidget);
    expect(find.text('03 / Updates & reliability'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('portfolio story routes resolve to their story page', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(onGenerateRoute: generateAppRoute));
    await tester.pumpAndSettle();

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamed('/projects/portfolio-engineering/responsive-portfolio-ui');
    await tester.pumpAndSettle();

    expect(find.byType(EngineeringStoryPage), findsOneWidget);
    expect(find.byType(SelectionArea), findsOneWidget);
    expect(find.byType(ContactSection), findsOneWidget);
    expect(
      find.text('Building a responsive, modular portfolio'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('unknown paths keep the portfolio section fallback', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(onGenerateRoute: generateAppRoute));
    await tester.pumpAndSettle();

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamedAndRemoveUntil(
          '/unknown-path',
          (_) => false,
          arguments: 'work',
        );
    await tester.pumpAndSettle();

    final portfolioPage = tester.widget<PortfolioPage>(
      find.byType(PortfolioPage),
    );
    expect(portfolioPage.initialSection, 'work');
    expect(tester.takeException(), isNull);
  });
}
