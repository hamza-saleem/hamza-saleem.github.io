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
  Widget build(BuildContext context) {
    final h1Size = context.responsive<double>(
      mobile: 28,
      tablet: 32,
      desktop: 36,
    );

    return SectionFade(
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.sectionPaddingH,
          vertical: context.sectionPaddingV,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// experience', style: AppTextStyles.label(context.accent)),
            SizedBox(
              height: context.responsive(
                mobile: 12.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
            ),
            Text(
              'Work History',
              style: AppTextStyles.heading1(context.textPrimary,
                  fontSize: h1Size),
            ),
            SizedBox(
              height: context.responsive(
                mobile: 32.0,
                tablet: 40.0,
                desktop: 48.0,
              ),
            ),
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
    final h2Size = context.responsive<double>(
      mobile: 18,
      tablet: 20,
      desktop: 22,
    );
    final itemGap = context.responsive(
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );
    final isMobile = context.isMobile;

    return Stack(
      children: [
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
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.isCurrent ? context.accent : context.ruleColor,
                  border: Border.all(
                    color: entry.isCurrent
                        ? context.accent
                        : context.textSecondary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : itemGap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) ...[
                      Text(
                        entry.role,
                        style: AppTextStyles.heading2(context.textPrimary,
                            fontSize: h2Size),
                      ),
                      const SizedBox(height: 8),
                      Text(entry.company,
                          style: AppTextStyles.body(context.accent)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(entry.period,
                              style: AppTextStyles.caption(
                                  context.textSecondary)),
                          if (entry.isCurrent) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              color: context.accent.withValues(alpha: 0.15),
                              child: Text('CURRENT',
                                  style:
                                      AppTextStyles.caption(context.accent)),
                            ),
                          ],
                        ],
                      ),
                    ] else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.role,
                                  style: AppTextStyles.heading2(
                                      context.textPrimary,
                                      fontSize: h2Size),
                                ),
                                const SizedBox(height: 8),
                                Text(entry.company,
                                    style:
                                        AppTextStyles.body(context.accent)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(entry.period,
                                  style: AppTextStyles.caption(
                                      context.textSecondary)),
                              if (entry.isCurrent) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  color:
                                      context.accent.withValues(alpha: 0.15),
                                  child: Text('CURRENT',
                                      style: AppTextStyles.caption(
                                          context.accent)),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(entry.description,
                        style: AppTextStyles.body(context.textSecondary)),
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
