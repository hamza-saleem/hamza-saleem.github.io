import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../../models/project_model.dart';
import '../widgets/project_widgets.dart';

class ProjectsSection extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey? mobileKey;
  final GlobalKey? gameKey;
  const ProjectsSection({
    super.key,
    required this.scrollController,
    this.mobileKey,
    this.gameKey,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.sectionPaddingH,
      vertical: context.sectionPaddingV,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('// selected work', style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 12),
        Text(
          'Two disciplines. One engineering mindset.',
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: context.isMobile ? 28 : 36,
          ),
        ),
        const SizedBox(height: 40),
        for (final track in ProjectTrack.values) ...[
          SizedBox(
            key: track == ProjectTrack.mobile ? mobileKey : gameKey,
            child: Text(
              track == ProjectTrack.mobile
                  ? 'Mobile Applications'
                  : 'Game Development',
              style: AppTextStyles.heading2(context.accent),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            track == ProjectTrack.mobile
                ? 'Production mobile software · State management · Reliability'
                : 'Gameplay programming · Persistent game state · Team development',
            style: AppTextStyles.body(context.textSecondary),
          ),
          const SizedBox(height: 24),
          for (final project in PortfolioData.projects.where(
            (p) => p.track == track,
          ))
            ProjectCard(project: project),
          const SizedBox(height: 48),
        ],
      ],
    ),
  );
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.context, style: AppTextStyles.label(context.accent)),
        const SizedBox(height: 12),
        Text(
          project.title,
          style: AppTextStyles.heading1(context.textPrimary, fontSize: 30),
        ),
        const SizedBox(height: 12),
        Text(project.role, style: AppTextStyles.caption(context.accent)),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: AppTextStyles.body(context.textSecondary),
        ),
        const SizedBox(height: 20),
        TechnologyTags(tags: project.tags),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => Navigator.of(context).pushNamed(project.route),
          child: const Text('Read engineering case study'),
        ),
        const SizedBox(height: 12),
        ProjectLinks(project: project),
      ],
    );
    return Container(
      padding: EdgeInsets.all(context.isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: context.cardColor,
        border: Border.all(color: context.ruleColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (project.media.isNotEmpty)
                  ProjectMediaView(media: project.media.first),
                if (project.videos.isNotEmpty)
                  ProjectTrailer(video: project.videos.first),
                if (project.media.isNotEmpty || project.videos.isNotEmpty)
                  const SizedBox(height: 24),
                details,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.media.isNotEmpty) ...[
                Expanded(child: ProjectMediaView(media: project.media.first)),
                const SizedBox(width: 32),
              ],
              if (project.media.isEmpty && project.videos.isNotEmpty) ...[
                Expanded(child: ProjectTrailer(video: project.videos.first)),
                const SizedBox(width: 32),
              ],
              Expanded(child: details),
            ],
          );
        },
      ),
    );
  }
}
