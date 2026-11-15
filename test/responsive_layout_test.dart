import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/core/theme/app_theme.dart';
import 'package:portfolio_website/features/portfolio/presentation/sections/projects_section.dart';
import 'package:portfolio_website/features/portfolio/presentation/widgets/nav_bar.dart';

void setViewport(WidgetTester tester, double width) {
  tester.view.physicalSize = Size(width, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('mobile navigation fits without horizontal overflow', (
    tester,
  ) async {
    setViewport(tester, 375);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: const Scaffold(body: NavBar()),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Grounds media fits within the mobile project section', (
    tester,
  ) async {
    setViewport(tester, 375);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: const Scaffold(
          body: SingleChildScrollView(child: ProjectsSection()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Authentication & user-state lifecycle'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
