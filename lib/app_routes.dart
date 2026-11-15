import 'package:flutter/material.dart';

import 'features/portfolio/data/portfolio_data.dart';
import 'features/portfolio/presentation/pages/design_system_page.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';
import 'features/portfolio/presentation/pages/project_case_study_page.dart';

Route<dynamic> generateAppRoute(RouteSettings settings) {
  if (settings.name == '/design-system') {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const DesignSystemPage(),
    );
  }

  for (final project in PortfolioData.projects) {
    for (final story in project.stories) {
      if (project.supportsStoryNavigation &&
          settings.name == '${project.route}/${story.slug}') {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => EngineeringStoryPage(project: project, story: story),
        );
      }
    }
    if (settings.name == project.route) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => ProjectCaseStudyPage(project: project),
      );
    }
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (_) => PortfolioPage(
      initialSection: settings.arguments is String
          ? settings.arguments! as String
          : null,
    ),
  );
}
