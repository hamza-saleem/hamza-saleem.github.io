import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: context.sectionPaddingV,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('// about', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 12),
        Text(
          'How I work',
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: context.isMobile ? 28 : 36,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          PortfolioData.bio,
          style: AppTextStyles.body(context.textSecondary),
        ),
        const SizedBox(height: 20),
        Text(
          PortfolioData.process,
          style: AppTextStyles.body(context.textSecondary),
        ),
        const SizedBox(height: 24),
        Text(
          PortfolioData.relocation,
          style: AppTextStyles.body(context.accent),
        ),
      ],
    ),
  );
}
