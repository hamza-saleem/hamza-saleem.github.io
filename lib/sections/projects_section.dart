import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/section_fade.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              style: AppTextStyles.heading1(context.textPrimary),
            ),
            const SizedBox(height: 40),
            // LayoutBuilder gives us the actual available width inside the
            // constrained column — avoids the MediaQuery overshoot bug.
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final useGrid = !context.isMobile;
                const gap = 20.0;

                if (useGrid) {
                  final cardWidth = (availableWidth - gap) / 2;
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

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final cardPad = context.responsive(mobile: 20.0, desktop: 28.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(cardPad),
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
            color: _hovered ? context.accent : context.ruleColor,
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
                      style: AppTextStyles.caption(Colors.white),
                    ),
                  ),
                const Spacer(),
                if (p.githubUrl != null)
                  _IconLink(
                    icon: Icons.code,
                    tooltip: 'GitHub',
                    onTap: () => _launch(p.githubUrl!),
                  ),
                if (p.liveUrl != null) ...[
                  const SizedBox(width: 8),
                  _IconLink(
                    icon: Icons.open_in_new,
                    tooltip: 'Live',
                    onTap: () => _launch(p.liveUrl!),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Text(
              p.title,
              style: AppTextStyles.heading2(context.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(p.description, style: AppTextStyles.body(context.textSecondary)),
            const SizedBox(height: 20),
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

class _IconLink extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconLink({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_IconLink> createState() => _IconLinkState();
}

class _IconLinkState extends State<_IconLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Icon(
            widget.icon,
            size: 18,
            color: _hovered ? context.accent : context.textSecondary,
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
