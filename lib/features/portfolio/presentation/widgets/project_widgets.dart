import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/url_utils.dart';
import '../../models/project_model.dart';
import 'youtube_embed.dart';
import 'auth_lifecycle_diagram.dart';
import 'project_flow_diagram.dart';

class TechnologyTags extends StatelessWidget {
  final List<String> tags;
  const TechnologyTags({super.key, required this.tags});
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: tags.map((tag) => Chip(label: Text(tag))).toList(),
  );
}

class ProjectLinks extends StatelessWidget {
  final ProjectModel project;
  const ProjectLinks({super.key, required this.project});
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    runSpacing: 8,
    children: [
      if (project.liveUrl != null)
        OutlinedButton.icon(
          onPressed: () => launchSafely(project.liveUrl!),
          icon: const Icon(Icons.open_in_new, size: 16),
          label: Text(
            project.liveUrlLabel ??
                switch (project.track) {
                  ProjectTrack.mobile => 'View on App Store',
                  ProjectTrack.game => 'View on Steam',
                  ProjectTrack.portfolio => 'View project',
                },
          ),
        ),
      for (final link in project.externalLinks)
        OutlinedButton.icon(
          onPressed: () => launchSafely(link.url),
          icon: const Icon(Icons.open_in_new, size: 16),
          label: Text(link.label),
        ),
      if (project.githubUrl != null)
        OutlinedButton(
          onPressed: () => launchSafely(project.githubUrl!),
          child: const Text('GitHub'),
        ),
      if (project.videoUrl != null)
        OutlinedButton(
          onPressed: () => launchSafely(project.videoUrl!),
          child: const Text('Watch demo / trailer'),
        ),
    ],
  );
}

class ProjectMediaView extends StatelessWidget {
  final ProjectMedia media;
  const ProjectMediaView({super.key, required this.media});
  @override
  Widget build(BuildContext context) {
    Widget placeholder() => Container(
      color: context.surfaceColor,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, color: context.textSecondary, size: 32),
          const SizedBox(height: 12),
          Text(
            media.asset == null ? media.caption : 'Project image unavailable',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption(context.textSecondary),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (media.focusLogging && media.asset != null) ...[
          ClipRect(
            child: Align(
              alignment: const Alignment(0, 0.88),
              heightFactor: 0.14,
              child: Image.asset(
                media.asset!,
                fit: BoxFit.contain,
                semanticLabel: media.alt,
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.fullscreen, size: 18),
            label: const Text('View full screenshot'),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        tooltip: 'Close screenshot',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Flexible(
                      child: InteractiveViewer(
                        child: Image.asset(
                          media.asset!,
                          fit: BoxFit.contain,
                          semanticLabel: media.alt,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ] else
          AspectRatio(
            aspectRatio: media.aspectRatio,
            child: media.asset == null
                ? placeholder()
                : Image.asset(
                    media.asset!,
                    fit: BoxFit.contain,
                    semanticLabel: media.alt,
                    errorBuilder: (_, error, stack) => placeholder(),
                  ),
          ),
        if (!media.focusLogging && media.asset != null)
          TextButton.icon(
            icon: const Icon(Icons.fullscreen, size: 18),
            label: const Text('View full screenshot'),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        tooltip: 'Close screenshot',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Flexible(
                      child: InteractiveViewer(
                        child: Image.asset(
                          media.asset!,
                          fit: BoxFit.contain,
                          semanticLabel: media.alt,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        Text(
          media.caption,
          style: AppTextStyles.caption(context.textSecondary),
        ),
        if (media.explanation != null) ...[
          const SizedBox(height: 6),
          Text(
            media.explanation!,
            style: AppTextStyles.caption(context.textSecondary),
          ),
        ],
      ],
    );
  }
}

class ProjectMediaGallery extends StatelessWidget {
  final List<ProjectMedia> media;
  const ProjectMediaGallery({super.key, required this.media});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth < 600
          ? constraints.maxWidth
          : (constraints.maxWidth - 24) / 2;
      return Wrap(
        spacing: 24,
        runSpacing: 32,
        children: media
            .map(
              (item) => SizedBox(
                width: width,
                child: ProjectMediaView(media: item),
              ),
            )
            .toList(),
      );
    },
  );
}

class CaseStudyBlock extends StatelessWidget {
  final CaseStudySection section;
  const CaseStudyBlock({super.key, required this.section});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(section.title, style: AppTextStyles.heading2(context.textPrimary)),
        const SizedBox(height: 10),
        Text(section.body, style: AppTextStyles.body(context.textSecondary)),
        if (section.diagram != null) ...[
          const SizedBox(height: 20),
          switch (section.diagram!) {
            CaseStudyDiagram.authenticationLifecycle =>
              const AuthLifecycleDiagram(),
            CaseStudyDiagram.foodSearchToMeal => const ProjectFlowDiagram(
              title: 'From food search to a trustworthy meal entry',
              steps: [
                'Search the catalog or choose a personal food',
                'Normalize zero, one or many search matches',
                'Select a serving and logged quantity',
                'Write to the target meal from the latest timeline',
                'Preserve the daily goal and other meal entries',
              ],
            ),
            CaseStudyDiagram.nutritionProgressAcrossDates =>
              const ProjectFlowDiagram(
                title: 'One accurate nutrition record for each day',
                steps: [
                  'Edit the selected day’s macros',
                  'Today updates the profile default; a past date is a local override',
                  'Transactionally update that day’s macro snapshot',
                  'Preserve meals already recorded for the date',
                  'Show live intake against the saved daily goal',
                ],
              ),
          },
        ],
      ],
    ),
  );
}

class ProjectTrailer extends StatelessWidget {
  final ProjectVideo video;
  const ProjectTrailer({super.key, required this.video});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: 16 / 9,
        child: YouTubeEmbed(videoId: video.youtubeId, title: video.title),
      ),
      const SizedBox(height: 12),
      Text(
        video.title,
        style: AppTextStyles.heading2(context.textPrimary, fontSize: 20),
      ),
      const SizedBox(height: 4),
      Text(
        'Official trailer · Know Buddy Games',
        style: AppTextStyles.caption(context.textSecondary),
      ),
      TextButton.icon(
        onPressed: () => launchSafely(video.url),
        icon: const Icon(Icons.open_in_new, size: 16),
        label: const Text('Watch on YouTube'),
      ),
    ],
  );
}

class ProjectTrailerGallery extends StatelessWidget {
  final List<ProjectVideo> videos;
  const ProjectTrailerGallery({super.key, required this.videos});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth < 700
          ? constraints.maxWidth
          : (constraints.maxWidth - 24) / 2;
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: videos
            .map(
              (video) => SizedBox(
                width: width,
                child: ProjectTrailer(video: video),
              ),
            )
            .toList(),
      );
    },
  );
}
