import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../../../core/widgets/parallax_widget.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  final ScrollController scrollController;

  const ProjectsSection({super.key, required this.scrollController});

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
            Text('// projects', style: AppTextStyles.label(context.accent)),
            SizedBox(
              height: context.responsive(
                mobile: 12.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
            ),
            Text(
              'Selected Work',
              style: AppTextStyles.heading1(
                context.textPrimary,
                fontSize: h1Size,
              ),
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
                // Grid only on desktop (1024px+); tablet and mobile use single column.
                final useGrid = context.isDesktop;
                final gap = context.responsive(
                  mobile: 16.0,
                  tablet: 16.0,
                  desktop: 20.0,
                );
                final projects = PortfolioData.projects;

                if (useGrid) {
                  // Responsive card height based on screen size and content.
                  // Avoids IntrinsicHeight double-measurement during hover animations.
                  final cardHeight = context.responsive<double?>(
                    mobile: null,
                    tablet: null,
                    desktop: 380,
                  );

                  final rows = <Widget>[];
                  for (var i = 0; i < projects.length; i += 2) {
                    final hasSecond = i + 1 < projects.length;
                    final rowChild = Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ParallaxWidget(
                            scrollController: scrollController,
                            parallaxStrength: 0.2,
                            invert: true,
                            child: _ProjectCard(project: projects[i]),
                          ),
                        ),
                        if (hasSecond) ...[
                          SizedBox(width: gap),
                          Flexible(
                            child: ParallaxWidget(
                              scrollController: scrollController,
                              parallaxStrength: 0.2,
                              invert: true,
                              child: _ProjectCard(project: projects[i + 1]),
                            ),
                          ),
                        ],
                      ],
                    );

                    // On desktop, constrain height to avoid relayout during hover.
                    rows.add(
                      cardHeight != null
                          ? SizedBox(height: cardHeight, child: rowChild)
                          : rowChild,
                    );
                    if (i + 2 < projects.length) {
                      rows.add(SizedBox(height: gap));
                    }
                  }
                  return Column(children: rows);
                }

                return Column(
                  children: projects
                      .map(
                        (p) => Padding(
                          padding: EdgeInsets.only(
                            bottom: context.responsive(
                              mobile: 16.0,
                              tablet: 20.0,
                              desktop: 20.0,
                            ),
                          ),
                          child: _ProjectCard(project: p),
                        ),
                      )
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
    final cardPad = context.responsive(
      mobile: 20.0,
      tablet: 22.0,
      desktop: 24.0,
    );
    final duration = context.responsive<Duration>(
      mobile: const Duration(milliseconds: 250),
      tablet: const Duration(milliseconds: 200),
      desktop: const Duration(milliseconds: 200),
    );

    String getButtonLabel(String url) {
      if (url.contains('apps.apple.com')) return 'View on App Store';
      if (url.contains('steampowered.com')) return 'View on Steam';
      if (url.contains('github.com')) return 'View on GitHub';
      return 'View Project';
    }

    return HoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: duration,
        width: double.infinity,
        padding: EdgeInsets.all(cardPad),
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
            color: hovered ? context.accent : context.ruleColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              p.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading2(context.textPrimary),
            ),
            SizedBox(height: context.responsive(mobile: 10.0, desktop: 12.0)),
            Text(
              p.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(context.textSecondary),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            SizedBox(height: context.responsive(mobile: 18.0, desktop: 24.0)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: p.tags.map((t) => const _Tag(label: t)).toList(),
            ),
            SizedBox(height: context.responsive(mobile: 18.0, desktop: 24.0)),
            Expanded(
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
                      label: getButtonLabel(p.liveUrl!),
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
    final duration = context.responsive<Duration>(
      mobile: const Duration(milliseconds: 250),
      tablet: const Duration(milliseconds: 200),
      desktop: const Duration(milliseconds: 200),
    );
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: hovered ? context.accent : context.ruleColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
            color: hovered
                ? context.accent.withValues(alpha: 0.1)
                : Colors.transparent,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: context.ruleColor, width: 1),
      ),
      child: Text(label, style: AppTextStyles.caption(context.textSecondary)),
    );
  }
}
