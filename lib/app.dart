import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';
import 'features/portfolio/presentation/pages/project_case_study_page.dart';
import 'features/portfolio/data/portfolio_data.dart';
import 'features/portfolio/models/project_model.dart';

class HamzaSaleemApp extends StatelessWidget {
  const HamzaSaleemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.isDark != current.isDark,
      builder: (context, state) {
        return MaterialApp(
          title: 'Hamza Saleem  — Portfolio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: (settings) {
            for (final project in PortfolioData.projects) {
              for (final story in project.stories) {
                if (project.track == ProjectTrack.mobile &&
                    settings.name == '${project.route}/${story.slug}') {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (_) =>
                        EngineeringStoryPage(project: project, story: story),
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
              builder: (_) => const PortfolioPage(),
            );
          },
        );
      },
    );
  }
}
