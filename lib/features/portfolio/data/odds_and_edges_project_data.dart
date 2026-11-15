import '../models/project_model.dart';

class OddsAndEdgesProjectData {
  OddsAndEdgesProjectData._();

  static const ProjectModel project = ProjectModel(
    slug: 'odds-and-edges',
    title: 'Odds & Edges',
    track: ProjectTrack.game,
    context: 'Released game jam project · KageMichi Dev',
    role: 'Game Designer & Producer',
    description:
        'A 2D dungeon adventure created by KageMichi Dev for the Devs That Jam '
        '36-hour Challenge #20. Released on itch.io for browser and Windows.',
    tags: ['Unity', 'Game Design', 'Production'],
    sections: [
      CaseStudySection(
        'My Contribution',
        'I led creative direction and handled game design and production for '
            'KageMichi Dev’s game jam entry. I am credited publicly as Scapegoat0442 (Lead).',
      ),
      CaseStudySection(
        'Design Direction',
        'The GDD framed the RANDOM theme around changing attack probabilities. '
            'It proposed slash, blunt and pierce attacks: using one would reduce '
            'its hit chance while increasing the others, encouraging players to '
            'adapt. The final art direction changed from the document’s initial '
            '3D plan to pure 2D.',
      ),
      CaseStudySection(
        'Production and Scope',
        'My documented responsibilities included scope management and design '
            'documentation. The plan separated essential features from optional '
            'polish and explicitly excluded larger systems such as multiplayer '
            'and procedural dungeon generation to keep the jam scope focused.',
      ),
      CaseStudySection(
        'Team',
        'The public credits list lucasananin for programming and art, Lucy for '
            'music and audio, and Scapegoat0442 for lead. My role focused on game '
            'design, production and creative direction.',
      ),
    ],
    gameEmbedUrl: 'https://itch.io/embed-upload/15835563?color=141412',
    media: [
      ProjectMedia(
        asset: 'assets/images/projects/odds-and-edges/combat.png',
        caption: 'Combat — attack choices and hit probabilities',
        alt:
            'Actual Odds & Edges combat interface with enemy, health and attack choices.',
        aspectRatio: 960 / 600,
      ),
      ProjectMedia(
        asset: 'assets/images/projects/odds-and-edges/instructions.png',
        caption: 'In-game instructions — changing odds and enemy weaknesses',
        alt:
            'Actual Odds & Edges instructions explaining changing hit chances and enemy weaknesses.',
        aspectRatio: 960 / 600,
      ),
    ],
    externalLinks: [
      ProjectExternalLink(
        'Play on itch.io',
        'https://lucasananin.itch.io/odds-edges',
      ),
    ],
    featured: true,
  );
}
