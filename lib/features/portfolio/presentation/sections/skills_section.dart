import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
            Text('// skills', style: AppTextStyles.label(context.accent)),
            SizedBox(
              height: context.responsive(
                mobile: 12.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
            ),
            Text(
              'Tech Stack',
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
            LayoutBuilder(
              builder: (context, constraints) {
                final entries = PortfolioData.skills.entries.toList();
                final useGrid = !context.isMobile;
                final gap = context.responsive(
                  mobile: 24.0,
                  tablet: 28.0,
                  desktop: 32.0,
                );

                if (useGrid) {
                  final colWidth = (constraints.maxWidth - gap) / 2;
                  return Center(
                    child: Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      alignment: WrapAlignment.center,
                      children: entries
                          .map((e) => SizedBox(
                                width: colWidth,
                                child: _SkillGroup(
                                  category: e.key,
                                  items: e.value,
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: entries
                      .map((e) => Padding(
                            padding: EdgeInsets.only(bottom: gap),
                            child: _SkillGroup(
                              category: e.key,
                              items: e.value,
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String category;
  final List<String> items;

  const _SkillGroup({required this.category, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 16, height: 1, color: context.accent),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                category.toUpperCase(),
                style: AppTextStyles.label(context.accent),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((skill) => _SkillChip(label: skill)).toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: hovered
              ? context.accent.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: hovered ? context.accent : context.ruleColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption(
            hovered ? context.accent : context.textSecondary,
          ),
        ),
      ),
    );
  }
}
