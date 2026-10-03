import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';
import '../../models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) => SectionFade(
    delay: const Duration(milliseconds: 100),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: context.sectionPaddingV,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// experience', style: AppTextStyles.label(context.accent)),
              const SizedBox(height: 14),
              Text(
                'Work History',
                style: AppTextStyles.heading1(
                  context.textPrimary,
                  fontSize: context.responsive(
                    mobile: 28.0,
                    tablet: 32.0,
                    desktop: 36.0,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Selected roles and the work behind them.',
                style: AppTextStyles.body(context.textSecondary),
              ),
              const SizedBox(height: 32),
              for (final entry in PortfolioData.experience)
                _ExperienceCard(entry: entry),
            ],
          ),
        ),
      ),
    ),
  );
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel entry;
  const _ExperienceCard({required this.entry});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(context.isMobile ? 20 : 24),
    decoration: BoxDecoration(
      color: context.cardColor,
      border: Border.all(color: context.ruleColor),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              entry.company.toUpperCase(),
              style: AppTextStyles.label(context.accent),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                entry.period,
                style: AppTextStyles.caption(context.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          entry.role,
          style: AppTextStyles.heading2(
            context.textPrimary,
            fontSize: context.isMobile ? 20 : 23,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          entry.description,
          style: AppTextStyles.body(context.textSecondary),
        ),
        if (entry.highlights.isNotEmpty) ...[
          const SizedBox(height: 14),
          for (final highlight in entry.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Icon(Icons.circle, size: 6, color: context.accent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      highlight,
                      style: AppTextStyles.body(context.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
        ],
        if (entry.projects.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              for (final project in entry.projects)
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(project.route),
                  icon: const Icon(Icons.arrow_outward, size: 15),
                  label: Text(project.label),
                ),
            ],
          ),
        ],
      ],
    ),
  );
}
