import '../models/experience_model.dart';
import '../models/project_model.dart';
import 'experience_data.dart';
import 'grounds_project_data.dart';
import 'nuex_project_data.dart';
import 'odds_and_edges_project_data.dart';
import 'portfolio_engineering_project_data.dart';
import 'shadow_hills_manor_project_data.dart';
import 'skills_data.dart';

class PortfolioData {
  PortfolioData._();

  static const String name = 'Hamza Saleem';
  static const String title = 'Software Engineer · Flutter Mobile Applications';
  static const String tagline =
      'I build and improve production Flutter applications, with professional '
      'experience in mobile engineering. I also bring hands-on experience '
      'contributing to gameplay systems in Unreal Engine and Unity.';
  static const String bio =
      'Software Engineer with professional experience building and improving production '
      'mobile applications. My primary experience is in Flutter, including state management, '
      'Firebase, REST APIs, debugging and production reliability. Alongside mobile development, '
      'I contribute to gameplay systems in Unreal Engine and Unity. I value understanding '
      'root causes and keeping systems maintainable beyond the immediate fix.';
  static const String relocation =
      'Based in Pakistan · Open to relocation to Japan and international opportunities';
  static const String process =
      'I use AI-assisted development where it improves productivity, while architectural '
      'decisions, debugging, verification and final implementation remain subject to my own review and testing.';
  // TODO: Add the reviewed resume to web/resume/hamza-saleem-resume.pdf.
  static const String? resumeUrl = null;

  static const String githubUrl = 'https://github.com/hamza-saleem';
  static const String linkedinUrl =
      'https://linkedin.com/in/hamza-saleem-scapegoat';
  static const String email = 'hamza.saleem87@gmail.com';

  static const List<ProjectModel> projects = [
    NuexProjectData.project,
    GroundsProjectData.project,
    ShadowHillsManorProjectData.project,
    OddsAndEdgesProjectData.project,
    PortfolioEngineeringProjectData.project,
  ];

  static const Map<String, List<String>> skills = SkillsData.groups;

  static const List<ExperienceModel> experience = ExperienceData.entries;
}
