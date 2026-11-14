import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/core/theme/app_colors.dart';
import 'package:portfolio_website/core/theme/app_theme.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/presentation/sections/skills_section.dart';

void main() {
  for (final brightness in [Brightness.light, Brightness.dark]) {
    for (final width in [375.0, 1440.0]) {
      testWidgets(
        'skill groups use a theme-matched card at $width pixels in $brightness mode',
        (tester) async {
          tester.view.physicalSize = Size(width, 1000);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          final isDark = brightness == Brightness.dark;
          final cardColor = isDark
              ? HamzaSaleemColors.darkCard
              : HamzaSaleemColors.lightCard;
          final ruleColor = isDark
              ? HamzaSaleemColors.darkRule
              : HamzaSaleemColors.lightRule;

          await tester.pumpWidget(
            MaterialApp(
              theme: brightness == Brightness.dark
                  ? AppTheme.dark()
                  : AppTheme.light(),
              home: const Scaffold(
                body: SingleChildScrollView(child: SkillsSection()),
              ),
            ),
          );
          await tester.pumpAndSettle();

          final groupCards = tester.widgetList<Container>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration! as BoxDecoration).color == cardColor &&
                  ((widget.decoration! as BoxDecoration).border as Border?)
                          ?.top
                          .color ==
                      ruleColor,
            ),
          );

          expect(groupCards, hasLength(PortfolioData.skills.length));
          for (final entry in PortfolioData.skills.entries) {
            expect(find.text(entry.key.toUpperCase()), findsOneWidget);
          }
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
