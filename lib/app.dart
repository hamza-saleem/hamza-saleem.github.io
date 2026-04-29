import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';

class KageMichiApp extends StatelessWidget {
  const KageMichiApp({super.key});

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
          home: const PortfolioPage(),
        );
      },
    );
  }
}
