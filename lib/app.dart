import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';

class KageMichiApp extends StatelessWidget {
  const KageMichiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeNotifier>().mode;
    return MaterialApp(
      title: 'Hamza Saleem  — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: const PortfolioPage(),
    );
  }
}
