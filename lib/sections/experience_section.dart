import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../models/experience_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/section_fade.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return SectionFade(
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// experience', style: AppTextStyles.label(context.accent)),
            const SizedBox(height: 12),
            Text('Work History', style: AppTextStyles.heading1(context.textPrimary)),
            const SizedBox(height: 48),
            ...PortfolioData.experience
                .asMap()
                .entries
                .map((e) => _TimelineItem(
                      entry: e.value,
                      isLast: e.key == PortfolioData.experience.length - 1,
                    )),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ExperienceModel entry;
  final bool isLast;

  const _TimelineItem({required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vertical connecting line drawn behind content
        if (!isLast)
          Positioned(
            left: 11,
            top: 14,
            bottom: 0,
            width: 1,
            child: Container(color: context.ruleColor),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline dot
            SizedBox(
              width: 24,
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.isCurrent
                      ? KageMichiColors.crimson
                      : context.ruleColor,
                  border: Border.all(
                    color: entry.isCurrent
                        ? KageMichiColors.crimson
                        : context.textSecondary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.role,
                                style: AppTextStyles.heading2(context.textPrimary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry.company,
                                style: AppTextStyles.body(context.accent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              entry.period,
                              style: AppTextStyles.caption(context.textSecondary),
                            ),
                            if (entry.isCurrent) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                color: KageMichiColors.crimson
                                    .withValues(alpha: 0.15),
                                child: Text(
                                  'CURRENT',
                                  style: AppTextStyles.caption(
                                    KageMichiColors.crimson,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      entry.description,
                      style: AppTextStyles.body(context.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
