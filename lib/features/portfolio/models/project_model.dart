enum ProjectTrack { mobile, game, portfolio }

enum CaseStudyDiagram {
  authenticationLifecycle,
  foodSearchToMeal,
  nutritionProgressAcrossDates,
}

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
  final String? routeSlug;
  final String? cardTitle;
  final String? cardSummary;
  const EngineeringStory(
    this.title,
    this.sections, {
    this.media = const [],
    this.subtitle,
    this.routeSlug,
    this.cardTitle,
    this.cardSummary,
  });
}

extension EngineeringStoryNavigation on EngineeringStory {
  String get slug {
    if (routeSlug != null) return routeSlug!;
    if (title.startsWith('Authentication')) return 'authentication';
    if (title.startsWith('Extending')) return 'exercise-logging';
    if (title.startsWith('App Update')) return 'app-update';
    if (title.startsWith('Food logging')) return 'food-logging-reliability';
    if (title.startsWith('Keep nutrition progress')) {
      return 'nutrition-progress-history';
    }
    return 'production-debugging';
  }

  String get shortTitle {
    if (cardTitle != null) return cardTitle!;
    if (title.startsWith('Authentication'))
      return 'Authentication & User State';
    if (title.startsWith('Extending')) return 'Exercise Logging';
    if (title.startsWith('App Update')) return 'App Update';
    if (title.startsWith('Food logging')) return 'Food Search & Logging';
    if (title.startsWith('Keep nutrition progress')) return 'Daily Progress';
    return 'Production Debugging';
  }

  String get summary {
    if (cardSummary != null) return cardSummary!;
    if (title.startsWith('Authentication')) {
      return 'Clarified authentication and user-state responsibilities, and improved readiness and controller lifecycle handling.';
    }
    if (title.startsWith('Extending')) {
      return 'Supported exercise-specific measurements with value1/value2 while preserving historical weight/reps records.';
    }
    if (title.startsWith('App Update')) {
      return 'Implemented update UI, models and dashboard integration, and refined dependency registration.';
    }
    if (title.startsWith('Food logging')) {
      return 'Fixed a false empty search state and carried catalog or personal foods into portion-aware, transaction-safe meal logging.';
    }
    if (title.startsWith('Keep nutrition progress')) {
      return 'Kept past-day goals separate from the profile default and tied live progress to saved meal data.';
    }
    return 'Strengthened lifecycle guards, asynchronous state handling and checks around production edge cases.';
  }
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
  final String? caseStudyIntro;
  final List<String> tags;
  final String? liveUrl;
  final String? liveUrlLabel;
  final String? githubUrl;
  final String? videoUrl;
  final bool featured;
  final List<ProjectVideo> videos;
  final List<ProjectExternalLink> externalLinks;
  final List<CaseStudySection> sections;
  final List<EngineeringStory> stories;
  final List<ProjectMedia> media;
  final List<ProjectMedia> beforeAfter;
  final String? gameEmbedUrl;
  const ProjectModel({
    required this.slug,
    required this.title,
    required this.track,
    required this.context,
    required this.role,
    required this.description,
    this.caseStudyIntro,
    required this.tags,
    this.liveUrl,
    this.liveUrlLabel,
    this.githubUrl,
    this.videoUrl,
    this.featured = false,
    this.videos = const [],
    this.externalLinks = const [],
    this.sections = const [],
    this.stories = const [],
    this.media = const [],
    this.beforeAfter = const [],
    this.gameEmbedUrl,
  });
  String get trackLabel => switch (track) {
    ProjectTrack.mobile => 'Mobile Applications',
    ProjectTrack.game => 'Game Development',
    ProjectTrack.portfolio => 'Portfolio Engineering',
  };
  String get route => '/projects/$slug';
  bool get supportsStoryNavigation =>
      track == ProjectTrack.mobile || track == ProjectTrack.portfolio;
}
