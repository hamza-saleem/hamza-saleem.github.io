class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;
  final bool isCurrent;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.isCurrent = false,
  });
}
