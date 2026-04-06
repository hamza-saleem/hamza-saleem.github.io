import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/section_fade.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionFade(
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.sectionPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// skills', style: AppTextStyles.label(context.accent)),
            const SizedBox(height: 12),
            Text(
              'Tech Stack',
              style: AppTextStyles.heading1(context.textPrimary),
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final entries = PortfolioData.skills.entries.toList();
                final useGrid = !context.isMobile;
                const gap = 40.0;

                if (useGrid) {
                  final colWidth = (constraints.maxWidth - gap) / 2;
                  return Wrap(
                    spacing: gap,
                    runSpacing: 36,
                    children: entries
                        .map((e) => SizedBox(
                              width: colWidth,
                              child: _SkillGroup(
                                category: e.key,
                                items: e.value,
                              ),
                            ))
                        .toList(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 32),
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
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((skill) => _SkillChip(label: skill)).toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered
              ? context.accent.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: _hovered ? context.accent : context.ruleColor,
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.caption(
            _hovered ? context.accent : context.textSecondary,
          ),
        ),
      ),
    );
  }
}
