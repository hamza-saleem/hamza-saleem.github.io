import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';
import '../widgets/project_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final grounds = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'grounds',
    );
    final nuex = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'nuex',
    );
    final games = PortfolioData.projects
        .where((project) => project.track == ProjectTrack.game)
        .toList();
    final portfolioEngineering = PortfolioData.projects.singleWhere(
      (project) => project.track == ProjectTrack.portfolio,
    );
    final exerciseStory = grounds.stories.firstWhere(
      (story) => story.media.isNotEmpty,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: context.sectionPaddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: context.ruleColor),
          const SizedBox(height: 32),
          Text(
            '01 / MOBILE ENGINEERING',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final heading = Text(
                'Built for everyday use.',
                style: AppTextStyles.heading1(
                  context.textPrimary,
                  fontSize: context.responsive(
                    mobile: 30.0,
                    tablet: 36.0,
                    desktop: 42.0,
                  ),
                ),
              );
              final description = Text(
                'Professional Flutter work, with attention to state, backward '
                'compatibility and production reliability.',
                style: AppTextStyles.body(
                  context.textSecondary,
                ).copyWith(fontSize: 15, height: 1.6),
              );
              if (constraints.maxWidth < 900) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [heading, const SizedBox(height: 16), description],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: heading),
                  const SizedBox(width: 16),
                  Expanded(child: description),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          _GroundsFeature(
            project: grounds,
            story: exerciseStory,
            media: exerciseStory.media,
          ),
          _NuexRow(project: nuex),
          const SizedBox(height: 48),
          Divider(height: 1, color: context.ruleColor),
          const SizedBox(height: 64),
          Text(
            '02 / GAME DEVELOPMENT',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 28),
          Text(
            'A complementary practice.',
            style: AppTextStyles.heading1(
              context.textPrimary,
              fontSize: context.responsive(
                mobile: 30.0,
                tablet: 36.0,
                desktop: 42.0,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Systems, interaction and the craft of building with a team.',
            style: AppTextStyles.body(context.textSecondary),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 900) {
                return Column(
                  children: [
                    for (final project in games) ...[
                      _GameProject(project: project),
                      const SizedBox(height: 40),
                    ],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 21, child: _GameProject(project: games[0])),
                  const SizedBox(width: 24),
                  Expanded(flex: 19, child: _GameProject(project: games[1])),
                ],
              );
            },
          ),
          _PortfolioEngineeringNote(project: portfolioEngineering),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}

class _PortfolioEngineeringNote extends StatelessWidget {
  final ProjectModel project;

  const _PortfolioEngineeringNote({required this.project});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, color: context.ruleColor),
        const SizedBox(height: 24),
        Text(
          'SUPPORTING / PORTFOLIO ENGINEERING',
          style: AppTextStyles.label(context.accent),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final details = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: AppTextStyles.heading2(
                    context.textPrimary,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: AppTextStyles.caption(context.textSecondary),
                ),
              ],
            );
            final link = TextButton(
              onPressed: () => Navigator.of(context).pushNamed(project.route),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Read portfolio case study  →'),
            );

            if (constraints.maxWidth < 700) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [details, const SizedBox(height: 12), link],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: details),
                const SizedBox(width: 24),
                link,
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _GroundsFeature extends StatelessWidget {
  final ProjectModel project;
  final EngineeringStory story;
  final List<ProjectMedia> media;

  const _GroundsFeature({
    required this.project,
    required this.story,
    required this.media,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final copy = _GroundsDetails(project: project, story: story);
      final images = _GroundsMedia(media: media);
      return Container(
        color: context.cardColor,
        child: constraints.maxWidth < 900
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [copy, images],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 12, child: copy),
                  Expanded(flex: 13, child: images),
                ],
              ),
      );
    },
  );
}

class _GroundsDetails extends StatelessWidget {
  final ProjectModel project;
  final EngineeringStory story;
  const _GroundsDetails({required this.project, required this.story});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenWidth < 900 ? 24.0 : 40.0;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED / STUDIO93 / TEAM PROJECT',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 24),
          Text(
            project.title,
            style: AppTextStyles.heading1(
              context.textPrimary,
              fontSize: context.screenWidth < 600 ? 40 : 54,
            ),
          ),
          const SizedBox(height: 16),
          Text(project.role, style: AppTextStyles.caption(context.textPrimary)),
          const SizedBox(height: 20),
          Text(
            project.caseStudyIntro ?? project.description,
            style: AppTextStyles.body(context.textSecondary),
          ),
          const SizedBox(height: 24),
          Text('MY CONTRIBUTION', style: AppTextStyles.label(context.accent)),
          const SizedBox(height: 16),
          for (final contribution in const [
            'Authentication & user-state lifecycle',
            'Backward-compatible exercise logging',
            'App-update UI & dashboard integration',
            'Production debugging & defensive state handling',
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                contribution,
                style: AppTextStyles.caption(context.textPrimary),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            project.tags.take(4).join('   /   '),
            style: AppTextStyles.caption(
              context.textSecondary,
            ).copyWith(fontSize: 11),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => Navigator.of(
              context,
            ).pushNamed('${project.route}/${story.slug}'),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text('Read the engineering story  →'),
          ),
        ],
      ),
    );
  }
}

class _GroundsMedia extends StatelessWidget {
  final List<ProjectMedia> media;
  const _GroundsMedia({required this.media});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 400;
      final gap = compact ? 12.0 : 24.0;
      final horizontalPadding = compact ? 16.0 : 28.0;
      final mediaWidth = constraints.maxWidth - 2 * horizontalPadding;
      final height = ((mediaWidth - gap) / 2) / (720 / 1639);
      final imageHeight = height.clamp(0.0, 473.0).toDouble();
      final imageWidth = imageHeight * (720 / 1639);
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 24,
        ),
        child: Column(
          children: [
            SizedBox(
              height: imageHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final (index, item) in media.take(2).indexed) ...[
                    if (index > 0) SizedBox(width: gap),
                    SizedBox(
                      width: imageWidth,
                      child: Image.asset(
                        item.asset!,
                        fit: BoxFit.contain,
                        semanticLabel: item.alt,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Supplied logging screens · Product context, not whole-screen ownership.',
                style: AppTextStyles.caption(
                  context.textSecondary,
                ).copyWith(fontSize: 10),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _NuexRow extends StatelessWidget {
  final ProjectModel project;
  const _NuexRow({required this.project});

  @override
  Widget build(BuildContext context) {
    final media = project.media.first;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 32),
        ),
        const SizedBox(height: 8),
        Text(
          '${project.context} · ${project.tags.take(3).join(' · ')}',
          style: AppTextStyles.caption(context.textSecondary),
        ),
      ],
    );
    final projectNumber = Text(
      '02  ↗',
      style: AppTextStyles.caption(context.textSecondary),
    );

    return Column(
      children: [
        Divider(height: 1, color: context.ruleColor),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(project.route),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final capture = _StorePageCapture(
                  media: media,
                  aspectRatio: 1.6,
                );
                if (constraints.maxWidth < 600) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      capture,
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: details),
                          const SizedBox(width: 16),
                          projectNumber,
                        ],
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth < 900 ? 230 : 300,
                      child: capture,
                    ),
                    const SizedBox(width: 24),
                    Expanded(child: details),
                    const SizedBox(width: 16),
                    projectNumber,
                  ],
                );
              },
            ),
          ),
        ),
        Divider(height: 1, color: context.ruleColor),
      ],
    );
  }
}

class _StorePageCapture extends StatelessWidget {
  final ProjectMedia media;
  final double aspectRatio;

  const _StorePageCapture({required this.media, required this.aspectRatio});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border.all(color: context.ruleColor),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                media.asset!,
                fit: BoxFit.cover,
                semanticLabel: media.alt,
                errorBuilder: (_, error, stack) => Center(
                  child: Text(
                    'Public store capture unavailable',
                    style: AppTextStyles.caption(context.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: context.bgColor.withValues(alpha: 0.94),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    media.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption(
                      context.textPrimary,
                    ).copyWith(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (media.explanation != null) ...[
        const SizedBox(height: 8),
        Text(
          media.explanation!,
          style: AppTextStyles.caption(
            context.textSecondary,
          ).copyWith(fontSize: 10),
        ),
      ],
    ],
  );
}

class _GameProject extends StatelessWidget {
  final ProjectModel project;
  const _GameProject({required this.project});

  bool get _shadowHills => project.slug == 'shadow-hills-manor';

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (_shadowHills)
        _ShadowHillsCover(project: project)
      else ...[
        _OddsAndEdgesImage(project: project),
        const SizedBox(height: 20),
        Text(
          'UNITY / KAGEMICHI DEV / RELEASED GAME JAM',
          style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
        ),
        const SizedBox(height: 20),
        Text(
          project.title,
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: context.isMobile ? 32 : 36,
          ),
        ),
        const SizedBox(height: 12),
        Text(project.role, style: AppTextStyles.caption(context.textPrimary)),
      ],
      if (_shadowHills) ...[
        Divider(height: 1, color: context.ruleColor),
        const SizedBox(height: 20),
        Text(project.role, style: AppTextStyles.caption(context.textPrimary)),
      ],
      const SizedBox(height: 16),
      Text(
        project.description,
        style: AppTextStyles.body(context.textSecondary),
      ),
      if (_shadowHills) ...[
        const SizedBox(height: 16),
        Text(
          'Team project and IP belong to their owners.',
          style: AppTextStyles.caption(context.textSecondary),
        ),
      ] else if (project.slug == 'odds-and-edges') ...[
        const SizedBox(height: 16),
        Text(
          'Programming & art: lucasananin · Music & audio: Lucy Pu',
          style: AppTextStyles.caption(context.textSecondary),
        ),
      ],
      const SizedBox(height: 16),
      Wrap(
        spacing: 20,
        runSpacing: 8,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(project.route),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              _shadowHills ? 'Explore contribution  →' : 'View project  →',
            ),
          ),
          if (_shadowHills && project.videos.isNotEmpty)
            TextButton(
              onPressed: () => launchSafely(project.videos.first.url),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text('Official trailer  →'),
            ),
          if (!_shadowHills && project.externalLinks.isNotEmpty)
            TextButton(
              onPressed: () => launchSafely(project.externalLinks.first.url),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text('Play on itch.io  →'),
            ),
        ],
      ),
    ],
  );
}

class _ShadowHillsCover extends StatelessWidget {
  final ProjectModel project;

  const _ShadowHillsCover({required this.project});

  @override
  Widget build(BuildContext context) {
    final media = project.media.first;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UNREAL ENGINE 5 / KNOW BUDDY GAMES',
          style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
        ),
        const SizedBox(height: 16),
        Text(
          'Shadow Hills\nManor',
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: context.isMobile ? 36 : 44,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'PERSISTENCE ACROSS LEVELS',
          style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
        ),
      ],
    );
    final capture = _StorePageCapture(media: media, aspectRatio: 1.6);

    return Container(
      color: context.cardColor,
      width: double.infinity,
      padding: EdgeInsets.all(context.isMobile ? 20 : 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 480) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [capture, const SizedBox(height: 20), details],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: details),
              const SizedBox(width: 20),
              SizedBox(width: 280, child: capture),
            ],
          );
        },
      ),
    );
  }
}

class _OddsAndEdgesImage extends StatelessWidget {
  final ProjectModel project;
  const _OddsAndEdgesImage({required this.project});

  @override
  Widget build(BuildContext context) {
    final media = project.media.first;
    return AspectRatio(
      aspectRatio: 580 / 375,
      child: Image.asset(
        media.asset!,
        fit: BoxFit.cover,
        semanticLabel: media.alt,
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool mediaOnRight;

  const ProjectCard({
    super.key,
    required this.project,
    this.mediaOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final media = project.media.isEmpty ? null : project.media.first;

    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        border: Border.all(color: context.ruleColor),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: context.screenWidth < 600 ? 220 : 340,
            child: _ProjectVisual(project: project, media: media),
          ),
          Padding(
            padding: EdgeInsets.all(
              context.responsive(
                mobile: AppSpacing.md,
                tablet: AppSpacing.lg,
                desktop: AppSpacing.xl,
              ),
            ),
            child: _ProjectDetails(project: project),
          ),
        ],
      ),
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  final ProjectModel project;
  final ProjectMedia? media;

  const _ProjectVisual({required this.project, required this.media});

  @override
  Widget build(BuildContext context) {
    if (media?.asset != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            media!.asset!,
            fit: BoxFit.cover,
            semanticLabel: media!.alt,
            errorBuilder: (_, error, stack) =>
                _TypographicVisual(project: project),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: context.bgColor.withValues(alpha: 0.94),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                media!.caption,
                style: AppTextStyles.caption(context.textPrimary),
              ),
            ),
          ),
        ],
      );
    }
    return _TypographicVisual(project: project);
  }
}

class _TypographicVisual extends StatelessWidget {
  final ProjectModel project;

  const _TypographicVisual({required this.project});

  @override
  Widget build(BuildContext context) {
    final shadowHills = project.slug == 'shadow-hills-manor';
    return Container(
      color: context.surfaceColor,
      padding: EdgeInsets.all(context.isMobile ? AppSpacing.md : AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            shadowHills ? 'GAME SYSTEMS' : project.trackLabel.toUpperCase(),
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            shadowHills ? 'GameInstance' : project.title,
            style: AppTextStyles.display(
              context.textPrimary,
              fontSize: context.responsive(
                mobile: 24.0,
                tablet: 30.0,
                desktop: 36.0,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (shadowHills)
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final label in [
                  'Persistent state',
                  'Save / load',
                  'Shared foundation',
                ])
                  _SystemLabel(label: label),
              ],
            )
          else
            Text(
              project.context,
              style: AppTextStyles.body(context.textSecondary),
            ),
        ],
      ),
    );
  }
}

class _SystemLabel extends StatelessWidget {
  final String label;
  const _SystemLabel({required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.xs,
      vertical: AppSpacing.xxs,
    ),
    decoration: BoxDecoration(border: Border.all(color: context.ruleColor)),
    child: Text(label, style: AppTextStyles.caption(context.textSecondary)),
  );
}

class _ProjectDetails extends StatelessWidget {
  final ProjectModel project;
  const _ProjectDetails({required this.project});

  String? get _contribution {
    for (final section in project.sections) {
      if (section.title == 'My Contribution') return section.body;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(project.context, style: AppTextStyles.label(context.accent)),
      const SizedBox(height: AppSpacing.sm),
      Text(
        project.title,
        style: AppTextStyles.heading1(
          context.textPrimary,
          fontSize: context.responsive(mobile: 27.0, desktop: 32.0),
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      Text(project.role, style: AppTextStyles.caption(context.textSecondary)),
      const SizedBox(height: AppSpacing.md),
      Text(
        project.description,
        style: AppTextStyles.body(context.textSecondary),
      ),
      if (_contribution != null) ...[
        const SizedBox(height: AppSpacing.md),
        Text('MY CONTRIBUTION', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: AppSpacing.xs),
        Text(_contribution!, style: AppTextStyles.body(context.textPrimary)),
      ],
      const SizedBox(height: AppSpacing.md),
      TechnologyTags(tags: project.tags),
      const SizedBox(height: AppSpacing.md),
      Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.xs,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pushNamed(project.route),
            icon: const Icon(Icons.arrow_outward, size: 17),
            label: const Text('Read case study'),
          ),
          ProjectLinks(project: project),
        ],
      ),
    ],
  );
}
