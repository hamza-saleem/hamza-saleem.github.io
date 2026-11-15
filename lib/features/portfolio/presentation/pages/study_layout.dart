import 'package:flutter/material.dart';

import '../sections/contact_section.dart';
import '../widgets/nav_bar.dart';

class StudyLayout extends StatelessWidget {
  final List<Widget> children;

  const StudyLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        NavBar(
          onNavigate: (section) => Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/', (_) => false, arguments: section),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: SelectionArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),
                ),
                const ContactSection(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
