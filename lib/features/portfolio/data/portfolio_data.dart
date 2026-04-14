import '../models/project_model.dart';
import '../models/experience_model.dart';

class PortfolioData {
  PortfolioData._();

  static const String name = 'Hamza Saleem';
  static const String title = 'Flutter Developer & Game Programmer';
  static const String tagline =
      'Building apps people rely on and games people remember.';
  static const String bio =
      'Flutter developer with production experience on a cross-platform health & fitness app serving 60K+ users. '
      'I work across the full feature lifecycle — from Figma specs through controller logic to Firestore integration. '
      'Outside of mobile, I develop gameplay systems in Unreal Engine 5 and Unity, and run KageMichi Dev, '
      'a volunteer indie game studio. Focused on stable, maintainable code and continuously sharpening my engineering fundamentals.';

  static const String githubUrl = 'https://github.com/hamza-saleem';
  static const String linkedinUrl =
      'https://linkedin.com/in/hamzasaleem-scapegoat';
  static const String email = 'hamza.saleem87@gmail.com';

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Grounds',
      description:
          'Women\'s health & fitness app with 60K+ users and a 4.6★ iOS rating. '
          'Contributed a unified exercise logging system across all workout types, an app update management layer, '
          'auth module refactor, TDEE health integration, and resolved critical Sentry crash reports.',
      tags: ['Flutter', 'GetX', 'Firebase', 'RevenueCat', 'Sentry', 'Hive'],
      featured: true,
    ),
    ProjectModel(
      title: 'Shadow Hills Manor',
      description:
          'First-person psychological horror game with exploration, puzzle-solving, and dynamic greed mechanics. '
          'Built a checkpoint-based save system for player progression. Launching on Steam in 2027.',
      tags: ['Unreal Engine 5', 'C++', 'Blueprints'],
      featured: true,
    ),
    ProjectModel(
      title: 'Instagram Clone',
      description:
          'Full-featured social media app with feed, likes, image upload, user profiles, and search. '
          'Built end-to-end during internship as a deep-dive into Flutter and Firebase.',
      tags: ['Flutter', 'Firebase Auth', 'Firestore', 'Firebase Storage'],
      featured: false,
    ),
    ProjectModel(
      title: 'MindSling',
      description:
          'Online school platform with real-time class features, login flows, and Firebase integration. '
          'Focused on mobile UI, REST API integration, and reusable component architecture.',
      tags: ['Flutter', 'Firebase Auth', 'Firestore', 'REST APIs'],
      featured: false,
    ),
  ];

  static const Map<String, List<String>> skills = {
    'State Management': ['GetX', 'Bloc', 'Provider', 'ChangeNotifier'],
    'Backend & APIs': [
      'Firebase Auth',
      'Firestore',
      'Remote Config',
      'REST APIs',
      'Firebase Storage',
    ],
    'Storage & Tools': [
      'Hive',
      'GetStorage',
      'SharedPreferences',
      'GitHub',
      'Figma',
      'Jira',
    ],
    'Game Dev': ['Unreal Engine 5', 'Unity', 'Blueprints', 'C++', 'C#'],
    'Monitoring & Payments': ['Sentry', 'Mixpanel', 'AppsFlyer', 'RevenueCat'],
    'Platforms': ['iOS', 'Android', 'Web'],
  };

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Junior Flutter Developer',
      company: 'Studio93',
      period: 'Oct 2025 — Present',
      description:
          'Contributing to Grounds, a women\'s health & fitness app with 60K+ users. '
          'Built a unified exercise logging system across all workout types with zero data loss during migration. '
          'Designed the app version management system across iOS and Android, refactored the auth module, '
          'and resolved critical crashes across the codebase.',
      isCurrent: true,
    ),
    ExperienceModel(
      role: 'Founder & Game Producer',
      company: 'KageMichi Dev',
      period: 'Dec 2025 — Present',
      description:
          'Founded a volunteer indie game development group. Lead production planning and contribute code. '
          'Shipped 1 game on itch.io with a second title in active development.',
      isCurrent: true,
    ),
    ExperienceModel(
      role: 'UE5 Game Programmer (Part-Time)',
      company: 'Know Buddy Games',
      period: 'Oct 2024 — Present',
      description:
          'Developing Shadow Hills Manor, a survival-horror game. '
          'Built a checkpoint-based save system to persist player progression. '
          'Conducted structured playtesting and iterated on pacing and game flow.',
      isCurrent: true,
    ),
    ExperienceModel(
      role: 'Flutter Intern',
      company: 'Studio93',
      period: 'May 2025 — Sep 2025',
      description:
          'Onboarded onto the Grounds codebase. Contributed to UI implementation, '
          'bug fixes, and minor performance improvements under senior developer guidance.',
    ),
    ExperienceModel(
      role: 'Game Developer & Project Coordinator',
      company: 'CYBRNODE',
      period: 'Aug 2020 — Oct 2023',
      description:
          'Wore multiple hats across three years: built a 2D endless platformer (Foxy Run) as in-house game developer, '
          'coordinated sprints and stakeholder communication as Project Coordinator, '
          'and earlier contributed to MindSling (online school platform) as a Flutter intern.',
    ),
    ExperienceModel(
      role: 'Unity Game Developer',
      company: 'Clash of Dvlopers',
      period: 'May 2021 — Jan 2022',
      description:
          'Started as an intern, promoted to junior game developer within 3 months. '
          'Worked on mobile game reskinning projects using Unity, integrated AdMob and Yodo1 ad platforms, '
          'and collaborated with QA on performance optimization.',
    ),
  ];
}
