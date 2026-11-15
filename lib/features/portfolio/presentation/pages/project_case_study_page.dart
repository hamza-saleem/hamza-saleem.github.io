import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';
import '../widgets/playable_game.dart';
import '../widgets/project_widgets.dart';
import 'case_study_overview.dart';
import 'case_study_stories.dart';
import 'study_layout.dart';

class ProjectCaseStudyPage extends StatelessWidget {
  final ProjectModel project;
  const ProjectCaseStudyPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final chapters = buildCaseStudyChapters(project);
    final chapterKeys = List.generate(chapters.length, (_) => GlobalKey());
    final contribution = project.sections.where(
      (section) => section.title == 'My Contribution',
    );
    final reflection = project.sections.where(
      (section) => section.title == 'What I Learned',
    );

    return StudyLayout(
      children: [
        CaseStudyIntroduction(project: project),
        ContributionSummary(
          project: project,
          contribution: contribution.isEmpty ? null : contribution.first.body,
        ),
        if (chapters.isNotEmpty) ...[
          CaseStudyStoryIndex(chapters: chapters, keys: chapterKeys),
          for (final (index, chapter) in chapters.indexed)
            CaseStudyChapterView(
              key: chapterKeys[index],
              project: project,
              chapter: chapter,
            ),
        ],
        for (final section in project.sections.where(
          (section) =>
              section.title != 'My Contribution' &&
              section.title != 'What I Learned' &&
              !(project.slug == 'grounds' && section.title == 'Constraints'),
        ))
          _StandaloneSection(section: section),
        if (project.gameEmbedUrl != null) ...[
          _MediaPageSection(
            title: 'Play the game',
            child: PlayableGame(
              url: project.gameEmbedUrl!,
              title: project.title,
              pageUrl: project.externalLinks.first.url,
            ),
          ),
          _MediaPageSection(
            title: 'Gameplay screenshots',
            child: ProjectMediaGallery(
              media: project.media,
              showFullMedia: true,
            ),
          ),
        ],
        if (project.videos.isNotEmpty)
          _MediaPageSection(
            title: 'Official trailers',
            child: ProjectTrailerGallery(videos: project.videos),
          ),
        if (reflection.isNotEmpty)
          _ReflectionSection(project: project, reflection: reflection.first),
        if (project.slug == 'grounds') const _NextProjectSection(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sectionPaddingH,
            vertical: 32,
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              ProjectLinks(project: project),
              TextButton(
                onPressed: () => launchSafely('mailto:${PortfolioData.email}'),
                child: const Text('Get in touch  →'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StandaloneSection extends StatelessWidget {
  final CaseStudySection section;
  const _StandaloneSection({required this.section});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: 20,
    ),
    child: CaseStudyBlock(section: section),
  );
}

class _MediaPageSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _MediaPageSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: 32,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 30),
        ),
        const SizedBox(height: 20),
        child,
      ],
    ),
  );
}

class _ReflectionSection extends StatelessWidget {
  final ProjectModel project;
  final CaseStudySection reflection;
  const _ReflectionSection({required this.project, required this.reflection});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: 48,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, color: context.ruleColor),
        const SizedBox(height: 32),
        Text('REFLECTION', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 24),
        Text(
          project.slug == 'grounds'
              ? 'State ownership is architecture.'
              : 'What I learned.',
          style: AppTextStyles.heading1(context.textPrimary, fontSize: 38),
        ),
        const SizedBox(height: 24),
        Text(reflection.body, style: AppTextStyles.body(context.textSecondary)),
      ],
    ),
  );
}

class _NextProjectSection extends StatelessWidget {
  const _NextProjectSection();

  @override
  Widget build(BuildContext context) {
    final project = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'shadow-hills-manor',
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: 24,
      ),
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(project.route),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NEXT / COMPLEMENTARY GAME WORK',
              style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
            ),
            const SizedBox(height: 12),
            Text(
              project.title,
              style: AppTextStyles.heading2(context.textPrimary, fontSize: 30),
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: AppTextStyles.caption(context.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
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
  Widget build(BuildContext context) => StudyLayout(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.sectionPaddingH,
          vertical: context.responsive(
            mobile: 56.0,
            tablet: 56.0,
            desktop: 88.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${project.title.toUpperCase()} / ENGINEERING STORY',
              style: AppTextStyles.label(context.accent),
            ),
            const SizedBox(height: 28),
            Text(
              story.title,
              style: AppTextStyles.heading1(
                context.textPrimary,
                fontSize: context.responsive(
                  mobile: 32.0,
                  tablet: 42.0,
                  desktop: 56.0,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              story.subtitle ?? story.summary,
              style: AppTextStyles.body(context.textSecondary),
            ),
            const SizedBox(height: 20),
            Text(
              '${project.role} · ${project.context}',
              style: AppTextStyles.caption(context.textSecondary),
            ),
          ],
        ),
      ),
      for (final section in story.sections.where(
        (section) => section.body.trim().isNotEmpty,
      ))
        _StandaloneSection(section: section),
      if (story.media.isNotEmpty)
        _MediaPageSection(
          title: 'Supporting media',
          child: ProjectMediaGallery(media: story.media, showFullMedia: true),
        ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.sectionPaddingH,
          vertical: 24,
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(project.route),
              child: Text('Back to ${project.title}'),
            ),
            for (final other in project.stories.where((item) => item != story))
              TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushReplacementNamed('${project.route}/${other.slug}'),
                child: Text(other.shortTitle),
              ),
          ],
        ),
      ),
    ],
  );
}
