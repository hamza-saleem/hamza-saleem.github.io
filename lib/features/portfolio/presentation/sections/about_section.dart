import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) => SectionFade(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: context.sectionPaddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: context.ruleColor),
          const SizedBox(height: 28),
          Text(
            '03 / ABOUT & EXPERIENCE',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 80.0;
              final about = const _AboutContent();
              final experience = const _SelectedExperience();
              if (constraints.maxWidth < 1000) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [about, const SizedBox(height: 48), experience],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: about),
                  const SizedBox(width: gap),
                  Expanded(child: experience),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Understand the cause.\nBuild for what comes next.',
        style: AppTextStyles.heading1(
          context.textPrimary,
          fontSize: context.responsive(mobile: 28.0, desktop: 34.0),
        ),
      ),
      const SizedBox(height: 24),
      Text(PortfolioData.bio, style: AppTextStyles.body(context.textSecondary)),
      const SizedBox(height: 24),
      Text('CORE TOOLS', style: AppTextStyles.label(context.accent)),
      const SizedBox(height: 16),
      Text(
        PortfolioData.skills['Mobile Engineering']!.join(' · '),
        style: AppTextStyles.caption(context.textPrimary).copyWith(height: 1.7),
      ),
      const SizedBox(height: 8),
      Text(
        PortfolioData.skills['Game Programming']!.join(' · '),
        style: AppTextStyles.caption(context.textPrimary).copyWith(height: 1.7),
      ),
    ],
  );
}

class _SelectedExperience extends StatelessWidget {
  const _SelectedExperience();

  String _startYear(String period) =>
      period.split(RegExp(r'\s[-–—]\s')).first.trim();

  @override
  Widget build(BuildContext context) {
    final entries = PortfolioData.experience.take(3).toList();
    final earlier = PortfolioData.experience
        .skip(3)
        .map((entry) => '${entry.company}, ${entry.period}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECTED EXPERIENCE / CONFIRMED START YEARS',
          style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
        ),
        const SizedBox(height: 20),
        for (final entry in entries) ...[
          Divider(height: 1, color: context.ruleColor),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_startYear(entry.period)} / ${entry.company}',
                  style: AppTextStyles.heading2(
                    context.textPrimary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  entry.role,
                  style: AppTextStyles.caption(context.textPrimary),
                ),
                const SizedBox(height: 12),
                Text(
                  entry.description,
                  style: AppTextStyles.caption(context.textSecondary),
                ),
              ],
            ),
          ),
        ],
        Divider(height: 1, color: context.ruleColor),
        if (earlier.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(
            'EARLIER EXPERIENCE  /  ${earlier.join(' · ')}',
            style: AppTextStyles.caption(
              context.textSecondary,
            ).copyWith(fontSize: 10),
          ),
        ],
      ],
    );
  }
}
