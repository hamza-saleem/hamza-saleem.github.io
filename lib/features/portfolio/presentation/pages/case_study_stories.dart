import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../../models/project_model.dart';
import '../widgets/project_widgets.dart';

class CaseStudyChapter {
  final String label;
  final String title;
  final String indexTitle;
  final List<EngineeringStory> stories;

  const CaseStudyChapter({
    required this.label,
    required this.title,
    required this.indexTitle,
    required this.stories,
  });
}

List<CaseStudyChapter> buildCaseStudyChapters(ProjectModel project) {
  if (project.slug == 'grounds') {
    final stories = project.stories;
    final authentication = stories
        .where((story) => story.title.startsWith('Authentication'))
        .toList();
    final logging = stories
        .where((story) => story.title.startsWith('Extending'))
        .toList();
    final updates = stories
        .where(
          (story) =>
              story.title.startsWith('App Update') ||
              story.title.startsWith('Production'),
        )
        .toList();
    final chapters = <CaseStudyChapter>[];
    if (authentication.isNotEmpty) {
      chapters.add(
        CaseStudyChapter(
          label: '01 / ARCHITECTURE',
          title: 'Authentication & user-state lifecycle',
          indexTitle: 'State lifecycle',
          stories: authentication,
        ),
      );
    }
    if (logging.isNotEmpty) {
      chapters.add(
        CaseStudyChapter(
          label: '02 / DATA & COMPATIBILITY',
          title: 'Beyond weight and reps',
          indexTitle: 'Exercise logging',
          stories: logging,
        ),
      );
    }
    if (updates.isNotEmpty) {
      chapters.add(
        CaseStudyChapter(
          label: '03 / FEATURE & RELIABILITY',
          title: 'Updates and production care',
          indexTitle: 'Updates & reliability',
          stories: updates,
        ),
      );
    }
    return chapters;
  }

  return [
    for (final (index, story) in project.stories.indexed)
      CaseStudyChapter(
        label: '${(index + 1).toString().padLeft(2, '0')} / ENGINEERING STORY',
        title: story.title,
        indexTitle: story.shortTitle,
        stories: [story],
      ),
  ];
}

class CaseStudyStoryIndex extends StatelessWidget {
  final List<CaseStudyChapter> chapters;
  final List<GlobalKey> keys;
  const CaseStudyStoryIndex({
    super.key,
    required this.chapters,
    required this.keys,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      context.sectionPaddingH,
      72,
      context.sectionPaddingH,
      24,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ENGINEERING NOTES', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 32),
        Text(
          'Decisions behind the work.',
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: context.responsive(
              mobile: 32.0,
              tablet: 38.0,
              desktop: 46.0,
            ),
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth < 600
                ? constraints.maxWidth
                : (constraints.maxWidth - 24 * (chapters.length - 1)) /
                      chapters.length;
            return Wrap(
              spacing: 24,
              runSpacing: 12,
              children: [
                for (final (index, chapter) in chapters.indexed)
                  SizedBox(
                    width: width,
                    child: TextButton(
                      onPressed: () => scrollToKey(keys[index]),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text(
                        '${(index + 1).toString().padLeft(2, '0')} / ${chapter.indexTitle}',
                        style: AppTextStyles.caption(context.textSecondary),
                        maxLines: 2,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Divider(height: 1, color: context.ruleColor),
      ],
    ),
  );
}

class CaseStudyChapterView extends StatelessWidget {
  final ProjectModel project;
  final CaseStudyChapter chapter;
  const CaseStudyChapterView({
    super.key,
    required this.project,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: 40,
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final label = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chapter.label,
              style: AppTextStyles.label(context.accent).copyWith(fontSize: 10),
            ),
            const SizedBox(height: 16),
            Text(
              chapter.title,
              style: AppTextStyles.heading2(
                context.textPrimary,
                fontSize: context.isMobile ? 26 : 30,
              ),
            ),
          ],
        );
        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final story in chapter.stories) ...[
              for (final section in story.sections.where(
                (section) => section.body.trim().isNotEmpty,
              ))
                CaseStudyBlock(section: section),
              if (story.media.isNotEmpty)
                ProjectMediaGallery(media: story.media, showFullMedia: true),
              TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushNamed('${project.route}/${story.slug}'),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text('Open full story: ${story.shortTitle}  →'),
              ),
              const SizedBox(height: 24),
            ],
          ],
        );
        if (constraints.maxWidth < 900) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [label, const SizedBox(height: 24), body],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 280, child: label),
            const SizedBox(width: 64),
            Expanded(child: body),
          ],
        );
      },
    ),
  );
}
