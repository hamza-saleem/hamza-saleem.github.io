import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: context.sectionPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// projects', style: AppTextStyles.label(context.accent)),
            const SizedBox(height: 12),
            Text(
              'Selected Work',
              style:
                  AppTextStyles.heading1(context.textPrimary, fontSize: h1Size),
            ),
            SizedBox(height: context.responsive(mobile: 28.0, desktop: 40.0)),
            LayoutBuilder(
              builder: (context, constraints) {
                final useGrid = !context.isMobile;
                const gap = 20.0;

                if (useGrid) {
                  final cardWidth = (constraints.maxWidth - gap) / 2;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: PortfolioData.projects
                        .map((p) => SizedBox(
                              width: cardWidth,
                              child: _ProjectCard(project: p),
                            ))
                        .toList(),
                  );
                }

                return Column(
                  children: PortfolioData.projects
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _ProjectCard(project: p),
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

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final p = project;
    final cardPad = context.responsive(mobile: 16.0, desktop: 28.0);
    final h2Size = context.responsive<double>(mobile: 18, desktop: 22);

    return HoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(cardPad),
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
            color: hovered ? context.accent : context.ruleColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (p.featured)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: context.accent,
                    child: Text(
                      'FEATURED',
                      style: AppTextStyles.caption(context.accentForeground),
                    ),
                  ),
                const Spacer(),
                if (p.githubUrl != null)
                  _IconLink(
                    icon: Icons.code,
                    tooltip: 'GitHub',
                    onTap: () => launchSafely(p.githubUrl!),
                  ),
                if (p.liveUrl != null) ...[
                  const SizedBox(width: 8),
                  _IconLink(
                    icon: Icons.open_in_new,
                    tooltip: 'Live',
                    onTap: () => launchSafely(p.liveUrl!),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 14),
            Text(
              p.title,
              style:
                  AppTextStyles.heading2(context.textPrimary, fontSize: h2Size),
            ),
            const SizedBox(height: 10),
            Text(p.description,
                style: AppTextStyles.body(context.textSecondary)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.tags.map((t) => _Tag(label: t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconLink extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconLink({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: 18,
            color: hovered ? context.accent : context.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: context.ruleColor, width: 1),
      ),
      child: Text(label, style: AppTextStyles.caption(context.textSecondary)),
    );
  }
}
