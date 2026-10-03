class ExperienceLink {
  final String label;
  final String route;
  const ExperienceLink(this.label, this.route);
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> highlights;
  final List<ExperienceLink> projects;
  final bool isCurrent;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.highlights = const [],
    this.projects = const [],
    this.isCurrent = false,
  });
}
