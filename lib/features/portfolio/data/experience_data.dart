import '../models/experience_model.dart';

class ExperienceData {
  ExperienceData._();

  static const List<ExperienceModel> entries = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Studio93',
      period: '2025 - 2026',
      description:
          'Contributed to Grounds, a production health and fitness app.',
      highlights: [
        'Extended exercise logging with a value1/value2 model and exercise-specific frontend labels, while keeping historical V1 records working.',
        'Improved authentication and user-state readiness, controller cleanup and dependency registration.',
        'Implemented app-update screens and dashboard integration; strengthened loading, lifecycle and error handling.',
      ],
      projects: [ExperienceLink('Grounds case study', '/projects/grounds')],
    ),
    ExperienceModel(
      role: 'Founder & Game Producer',
      company: 'KageMichi Dev',
      period: '2025 - Present',
      description:
          'Founded a volunteer indie game development group and led production planning.',
      highlights: [
        'Led creative direction, game design, scope management and design documentation for Odds & Edges.',
        'Released the team’s entry in the Devs That Jam 36-hour Challenge #20; publicly credited as Scapegoat0442 (Lead).',
      ],
      projects: [ExperienceLink('Odds & Edges', '/projects/odds-and-edges')],
    ),
    ExperienceModel(
      role: 'UE5 Game Programmer · Part-time',
      company: 'Know Buddy Games',
      period: '2024 - 2026',
      description:
          'Contributed to Shadow Hills Manor as part of the development team.',
      highlights: [
        'Designed and implemented a shared GameInstance architecture for persistent game state, save/load and other game-wide systems.',
        'Built a checkpoint-based save system for player progression.',
      ],
      projects: [
        ExperienceLink('Shadow Hills Manor', '/projects/shadow-hills-manor'),
      ],
    ),
    ExperienceModel(
      role: 'Game Developer & Project Coordinator',
      company: 'CYBRNODE',
      period: '2022 — 2024',
      description:
          'Worked across game development, project coordination and an earlier Flutter internship.',
      highlights: [
        'Built Foxy Run, a 2D endless platformer, as an in-house game developer.',
        'Coordinated sprints and stakeholder communication as Project Coordinator.',
        'Earlier contributed to MindSling, an online school platform, as a Flutter intern.',
      ],
    ),
    ExperienceModel(
      role: 'Unity Game Developer',
      company: 'Clash of Dvlopers',
      period: '2021 — 2022',
      description:
          'Progressed from intern to junior game developer within three months.',
      highlights: [
        'Worked on mobile game reskinning projects using Unity.',
        'Integrated AdMob and Yodo1 ad platforms and collaborated with QA on performance optimization.',
      ],
    ),
  ];
}
