class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final bool featured;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    this.liveUrl,
    this.githubUrl,
    this.featured = false,
  });
}
