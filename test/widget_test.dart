import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:portfolio_website/main.dart';
import 'package:portfolio_website/theme/app_theme.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: const KageMichiApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
