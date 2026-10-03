import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';
import '../widgets/project_widgets.dart';
import '../widgets/playable_game.dart';

List<EngineeringStory> _orderedStories(ProjectModel project) =>
    [...project.stories]..sort((a, b) {
      if (a.title.startsWith('Authentication')) return -1;
      if (b.title.startsWith('Authentication')) return 1;
      return project.stories.indexOf(a).compareTo(project.stories.indexOf(b));
    });

void _back(BuildContext context, String fallback) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  } else {
    Navigator.of(context).pushReplacementNamed(fallback);
  }
}

class _StudyLayout extends StatelessWidget {
  final String title;
  final String backLabel;
  final String fallback;
  final List<Widget> children;
  const _StudyLayout({
    required this.title,
    required this.backLabel,
    required this.fallback,
    required this.children,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        tooltip: backLabel,
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _back(context, fallback),
      ),
      title: Text(title),
      actions: [
        IconButton(
          tooltip: 'Toggle theme',
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: const Icon(Icons.brightness_6_outlined),
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.sectionPaddingH,
              vertical: context.isMobile ? 32 : 48,
            ),
            child: SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class ProjectCaseStudyPage extends StatelessWidget {
  final ProjectModel project;
  const ProjectCaseStudyPage({super.key, required this.project});
  @override
  Widget build(BuildContext context) => _StudyLayout(
    title: project.title,
    backLabel: 'Back to portfolio',
    fallback: '/',
    children: [
      Text(project.trackLabel, style: AppTextStyles.label(context.accent)),
      const SizedBox(height: 12),
      Text(
        project.title,
        style: AppTextStyles.heading1(
          context.textPrimary,
          fontSize: context.isMobile ? 32 : 44,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        project.track == ProjectTrack.mobile
            ? "Production health and fitness app for women. I contributed as a Flutter developer at Studio93."
            : project.description,
        style: AppTextStyles.body(context.textSecondary),
      ),
      const SizedBox(height: 20),
      Text('Role: ${project.role}', style: AppTextStyles.body(context.accent)),
      Text(
        project.context,
        style: AppTextStyles.caption(context.textSecondary),
      ),
      const SizedBox(height: 12),
      TechnologyTags(tags: project.tags),
      const SizedBox(height: 12),
      ProjectLinks(project: project),
      const SizedBox(height: 28),
      if (project.gameEmbedUrl != null) ...[
        PlayableGame(
          url: project.gameEmbedUrl!,
          title: project.title,
          pageUrl: project.externalLinks.first.url,
        ),
        const SizedBox(height: 24),
      ],
      for (final section in project.sections.where(
        (s) => s.title == 'My Contribution',
      ))
        CaseStudyBlock(section: section),
      if (project.track == ProjectTrack.mobile) ...[
        Text(
          'Engineering stories',
          style: AppTextStyles.heading2(context.textPrimary),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) => Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final story in _orderedStories(project))
                SizedBox(
                  width: constraints.maxWidth < 650
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 16) / 2,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            story.shortTitle,
                            style: AppTextStyles.heading2(
                              context.textPrimary,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            story.summary,
                            style: AppTextStyles.body(context.textSecondary),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () => Navigator.of(
                              context,
                            ).pushNamed('${project.route}/${story.slug}'),
                            child: Text('Read ${story.shortTitle}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 28),
      ] else ...[
        for (final section in project.sections.where(
          (s) => s.title != 'My Contribution' && s.title != 'What I Learned',
        ))
          CaseStudyBlock(section: section),
        for (final story in project.stories)
          for (final section in story.sections)
            CaseStudyBlock(section: section),
      ],
      for (final section in project.sections.where(
        (s) => s.title == 'What I Learned',
      ))
        CaseStudyBlock(section: section),
      if (project.gameEmbedUrl != null) ...[
        Text(
          'Gameplay screenshots',
          style: AppTextStyles.heading2(context.textPrimary),
        ),
        const SizedBox(height: 16),
        ProjectMediaGallery(media: project.media),
        const SizedBox(height: 24),
      ],
      if (project.videos.isNotEmpty) ...[
        Text(
          'Official trailers',
          style: AppTextStyles.heading2(context.textPrimary),
        ),
        const SizedBox(height: 16),
        ProjectTrailerGallery(videos: project.videos),
        const SizedBox(height: 24),
      ],
      Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (_) => false),
            child: const Text('Back to portfolio'),
          ),
          TextButton(
            onPressed: () => launchSafely('mailto:${PortfolioData.email}'),
            child: const Text('Get in touch'),
          ),
        ],
      ),
    ],
  );
}

class EngineeringStoryPage extends StatelessWidget {
  final ProjectModel project;
  final EngineeringStory story;
  const EngineeringStoryPage({
    super.key,
    required this.project,
    required this.story,
  });
  @override
  Widget build(BuildContext context) => _StudyLayout(
    title: project.title,
    backLabel: 'Back to ${project.title}',
    fallback: project.route,
    children: [
      Text(
        '${project.title} · Engineering story',
        style: AppTextStyles.label(context.accent),
      ),
      const SizedBox(height: 16),
      Text(
        story.title,
        style: AppTextStyles.heading1(
          context.textPrimary,
          fontSize: context.isMobile ? 28 : 36,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        story.subtitle ?? story.summary,
        style: AppTextStyles.body(context.accent),
      ),
      const SizedBox(height: 28),
      for (final section in story.sections.where(
        (s) => s.body.trim().isNotEmpty,
      ))
        CaseStudyBlock(section: section),
      if (story.media.isNotEmpty) ProjectMediaGallery(media: story.media),
      const SizedBox(height: 24),
      OutlinedButton(
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed(project.route),
        child: Text('Back to ${project.title}'),
      ),
      const SizedBox(height: 24),
      Text(
        'Other engineering stories',
        style: AppTextStyles.heading2(context.textPrimary, fontSize: 20),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final other in _orderedStories(project).where((s) => s != story))
            OutlinedButton(
              onPressed: () => Navigator.of(
                context,
              ).pushReplacementNamed('${project.route}/${other.slug}'),
              child: Text(other.shortTitle),
            ),
        ],
      ),
    ],
  );
}
