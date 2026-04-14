import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class HorizontalRule extends StatelessWidget {
  const HorizontalRule({super.key});

  @override
  Widget build(BuildContext context) {
    final vPad = context.responsive(mobile: 40.0, tablet: 52.0, desktop: 64.0);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: Row(
        children: [
          Container(width: 32, height: 1, color: context.accent),
          Expanded(child: Container(height: 1, color: context.ruleColor)),
        ],
      ),
    );
  }
}
