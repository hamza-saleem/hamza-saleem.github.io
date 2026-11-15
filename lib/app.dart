import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';

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
          onGenerateRoute: generateAppRoute,
        );
      },
    );
  }
}
