import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/app.dart';
import 'package:portfolio_website/core/theme/cubit/theme_cubit.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => ThemeCubit(),
        child: const KageMichiApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
