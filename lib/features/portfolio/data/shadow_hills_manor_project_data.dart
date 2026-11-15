import '../models/project_model.dart';

class ShadowHillsManorProjectData {
  ShadowHillsManorProjectData._();

  static const ProjectModel project = ProjectModel(
    slug: 'shadow-hills-manor',
    title: 'Shadow Hills Manor',
    track: ProjectTrack.game,
    context: 'Team project · Know Buddy Games',
    role: 'Game Programmer / Development Team Member',
    sections: [
      CaseStudySection(
        'My Contribution',
        'As a programmer on the Know Buddy Games development team, I designed and '
            'implemented the shared GameInstance foundation for save/load and persistent '
            'game state. This was my contribution within the development team; '
            'the project and its IP belong to their owners.',
      ),
      CaseStudySection(
        'What I Learned',
        'I learned to consider system lifetime and persistent-state ownership when designing '
            'a foundation other developers would use. Keeping that foundation understandable '
            'and straightforward to extend matters as the project grows.',
      ),
    ],
    stories: [
      EngineeringStory(
        'A shared GameInstance foundation',
        [
          CaseStudySection(
            'Need',
            'Save/load needed to preserve the player’s inventory, stats, position '
                'and other essential game state. The team needed a shared foundation '
                'for these persistent responsibilities.',
          ),
          CaseStudySection(
            'Architecture',
            'I designed and implemented a dedicated GameInstance architecture that '
                'both held persistent state directly and coordinated separate systems. '
                'GameInstance remains available across level loads, making it suitable '
                'for this shared runtime foundation.',
          ),
          CaseStudySection(
            'Save/load and maintainability',
            'The architecture supported save, loading and other persistent game-wide '
                'systems. My work also included a checkpoint-based save system. '
                'I designed the foundation to stay understandable, reusable and '
                'extensible as the development team added systems.',
          ),
        ],
        routeSlug: 'production-debugging',
        cardTitle: 'Production Debugging',
        cardSummary:
            'Strengthened lifecycle guards, asynchronous state handling and checks around production edge cases.',
      ),
    ],
    media: [
      ProjectMedia(
        asset:
            'assets/images/projects/shadow-hills-manor/steam-store-capture.png',
        caption: 'Shadow Hills Manor — public Steam store listing',
        alt:
            'Steam store page for Shadow Hills Manor with the game title, official trailer thumbnails, description, and developer details.',
        sourceUrl:
            'https://store.steampowered.com/app/4158810/Shadow_Hills_Manor/',
        aspectRatio: 1440 / 1000,
        explanation:
            'Public product context only; this capture does not identify which game media Hamza created or imply authorship of the listing.',
      ),
    ],
    videos: [
      ProjectVideo(title: 'Announcement trailer', youtubeId: '0aG555ZLJio'),
      ProjectVideo(title: 'Gameplay trailer', youtubeId: 'IjMZEyl3XXs'),
    ],
    externalLinks: [
      ProjectExternalLink(
        'Know Buddy Games website',
        'https://knowbuddygames.com/',
      ),
      ProjectExternalLink(
        'Know Buddy Games YouTube',
        'https://youtube.com/@knowbuddygames?si=5urmyFVhPe5f-H32',
      ),
    ],
    description:
        'First-person psychological horror game with exploration, puzzle-solving, and dynamic greed mechanics. '
        'As a development team member, I designed and implemented a shared GameInstance architecture '
        'for save, loading and other persistent game-wide systems. Launching on Steam in 2027.',
    tags: ['Unreal Engine 5', 'C++', 'Blueprints'],
    liveUrl: 'https://store.steampowered.com/app/4158810/Shadow_Hills_Manor/',
    featured: true,
  );
}
