enum ProjectTrack { mobile, game }

enum CaseStudyDiagram { authenticationLifecycle }

class CaseStudySection {
  final String title;
  final String body;
  final CaseStudyDiagram? diagram;
  const CaseStudySection(this.title, this.body, {this.diagram});
}

class ProjectMedia {
  final String? asset;
  final String caption;
  final String alt;
  final String? explanation;
  final String? sourceUrl;
  final double aspectRatio;
  final bool focusLogging;
  const ProjectMedia({
    this.asset,
    required this.caption,
    required this.alt,
    this.explanation,
    this.sourceUrl,
    this.aspectRatio = 16 / 10,
    this.focusLogging = false,
  });
}

class EngineeringStory {
  final String title;
  final List<CaseStudySection> sections;
  final List<ProjectMedia> media;
  final String? subtitle;
  const EngineeringStory(
    this.title,
    this.sections, {
    this.media = const [],
    this.subtitle,
  });
}

extension EngineeringStoryNavigation on EngineeringStory {
  String get slug => title.startsWith('Authentication')
      ? 'authentication'
      : title.startsWith('Extending')
      ? 'exercise-logging'
      : title.startsWith('App Update')
      ? 'app-update'
      : 'production-debugging';
  String get shortTitle => title.startsWith('Authentication')
      ? 'Authentication & User State'
      : title.startsWith('Extending')
      ? 'Exercise Logging'
      : title.startsWith('App Update')
      ? 'App Update'
      : 'Production Debugging';
  String get summary => title.startsWith('Authentication')
      ? 'Clarified authentication and user-state responsibilities, and improved readiness and controller lifecycle handling.'
      : title.startsWith('Extending')
      ? 'Supported exercise-specific measurements with value1/value2 while preserving historical weight/reps records.'
      : title.startsWith('App Update')
      ? 'Implemented update UI, models and dashboard integration, and refined dependency registration.'
      : 'Strengthened lifecycle guards, asynchronous state handling and checks around production edge cases.';
}

class ProjectVideo {
  final String title;
  final String youtubeId;
  const ProjectVideo({required this.title, required this.youtubeId});
  String get url => 'https://www.youtube.com/watch?v=$youtubeId';
}

class ProjectExternalLink {
  final String label;
  final String url;
  const ProjectExternalLink(this.label, this.url);
}

class ProjectModel {
  final String slug;
  final String title;
  final ProjectTrack track;
  final String context;
  final String role;
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final String? videoUrl;
  final bool featured;
  final List<ProjectVideo> videos;
  final List<ProjectExternalLink> externalLinks;
  final List<CaseStudySection> sections;
  final List<EngineeringStory> stories;
  final List<ProjectMedia> media;
  final List<ProjectMedia> beforeAfter;
  const ProjectModel({
    required this.slug,
    required this.title,
    required this.track,
    required this.context,
    required this.role,
    required this.description,
    required this.tags,
    this.liveUrl,
    this.githubUrl,
    this.videoUrl,
    this.featured = false,
    this.videos = const [],
    this.externalLinks = const [],
    this.sections = const [],
    this.stories = const [],
    this.media = const [],
    this.beforeAfter = const [],
  });
  String get trackLabel =>
      track == ProjectTrack.mobile ? 'Mobile Applications' : 'Game Development';
  String get route => '/projects/$slug';
}
