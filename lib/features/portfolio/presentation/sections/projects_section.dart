import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final useGrid = !context.isMobile;
                const gap = 20.0;
                final projects = PortfolioData.projects;

                if (useGrid) {
                  final rows = <Widget>[];
                  for (var i = 0; i < projects.length; i += 2) {
                    final hasSecond = i + 1 < projects.length;
                    rows.add(
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _ProjectCard(project: projects[i])),
                            if (hasSecond) ...[
                              const SizedBox(width: gap),
                              Expanded(
                                  child: _ProjectCard(project: projects[i + 1])),
                            ] else
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    );
                    if (i + 2 < projects.length) {
                      rows.add(const SizedBox(height: gap));
                    }
                  }
                  return Column(children: rows);
                }

                return Column(
                  children: projects
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

    String _getButtonLabel(String url) {
      if (url.contains('apps.apple.com')) return 'View on App Store';
      if (url.contains('steampowered.com')) return 'View on Steam';
      if (url.contains('github.com')) return 'View on GitHub';
      return 'View Project';
    }

    return HoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(24),
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
            Center(
              child: Text(
                p.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2(context.textPrimary),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                p.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.body(context.textSecondary),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: p.tags.map((t) => _Tag(label: t)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  if (p.liveUrl != null)
                    _SocialButton(
                      icon: p.liveUrl!.contains('apps.apple.com')
                          ? FontAwesomeIcons.apple
                          : FontAwesomeIcons.steam,
                      label: _getButtonLabel(p.liveUrl!),
                      onTap: () => launchSafely(p.liveUrl!),
                    ),
                  if (p.githubUrl != null)
                    _SocialButton(
                      icon: FontAwesomeIcons.github,
                      label: 'GitHub',
                      onTap: () => launchSafely(p.githubUrl!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: hovered ? context.accent : context.ruleColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
            color: hovered ? context.accent.withOpacity(0.1) : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              FaIcon(
                icon,
                size: 14,
                color: hovered ? context.accent : context.textSecondary,
              ),
              Text(
                label,
                style: AppTextStyles.caption(
                  hovered ? context.accent : context.textSecondary,
                ),
              ),
            ],
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
