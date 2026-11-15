import '../models/project_model.dart';

class PortfolioEngineeringProjectData {
  PortfolioEngineeringProjectData._();

  static const ProjectModel project = ProjectModel(
    slug: 'portfolio-engineering',
    title: 'Building this portfolio',
    track: ProjectTrack.portfolio,
    context: 'Personal project · Flutter Web',
    role: 'Portfolio developer',
    description:
        'A responsive Flutter Web portfolio with separate project tracks, direct engineering-story routes, and an automated GitHub Pages release path.',
    tags: ['Flutter', 'Dart', 'flutter_bloc', 'GitHub Actions', 'GitHub Pages'],
    sections: [
      CaseStudySection(
        'My Contribution',
        'I built and iterated on this Flutter portfolio: organizing shared code into core and portfolio-feature areas, creating responsive project presentations, migrating theme state from Provider to Flutter Bloc, and adding routed case studies with media, diagrams and a playable game embed. I also configured the GitHub Pages release workflow. The stories below describe changes supported by this repository’s history and source.',
      ),
    ],
    stories: [
      EngineeringStory(
        'Building a responsive, modular portfolio',
        [
          CaseStudySection(
            'Starting with the portfolio itself',
            'My first full implementation established the hero, projects, skills, experience and contact sections, along with theme and responsive helpers. I later reorganized shared code under lib/core and the portfolio feature under lib/features/portfolio.',
          ),
          CaseStudySection(
            'Reworking the project layout',
            'I replaced an earlier GridView with width-aware project rows: paired cards at wider sizes and a single-column list on mobile. In a later redesign, I organized projects into separate Mobile Applications and Game Development tracks, rendered from the project data.',
          ),
          CaseStudySection(
            'Reusable interactions',
            'In an earlier hero implementation, I added a shared HoverBuilder for pointer interactions and a ParallaxWidget for scroll-linked movement. I also added browser text measurement for the animated underline. The current hero no longer uses parallax or text measurement.',
          ),
          CaseStudySection(
            'Responsive implementation',
            'The portfolio uses shared responsive helpers for mobile, tablet and desktop sizing. The current project section adapts its cards to the available width and keeps each project track distinct.',
          ),
          CaseStudySection(
            'Turning project data into case studies',
            'I added structured project and engineering-story data, direct routes to project and story pages, and reusable media, diagram and trailer components. A later update added a playable Odds & Edges embed. These features describe how this portfolio presents projects; they do not claim authorship of the underlying project implementations.',
          ),
        ],
        routeSlug: 'responsive-portfolio-ui',
        cardTitle: 'Responsive UI',
        cardSummary:
            'Started with a Flutter portfolio, reorganized its code, and evolved its responsive project and case-study presentation.',
        subtitle:
            'From the initial Flutter sections to a modular, responsive portfolio with direct case-study routes.',
      ),
      EngineeringStory(
        'Migrating theme state and adding focused Cubits',
        [
          CaseStudySection(
            'Replacing the previous state setup',
            'I replaced the Provider-based theme notifier with Flutter Bloc. I introduced ThemeCubit for theme selection, HeroCubit for the measured hero-name width, and HoverCubit with explicit enter/exit transitions. The reusable HoverBuilder continues to manage pointer hover locally within its widget.',
          ),
          CaseStudySection(
            'Wiring state to the interface',
            'main.dart provides ThemeCubit through BlocProvider, and app.dart rebuilds theme-dependent MaterialApp state through BlocBuilder. The navigation theme toggle calls ThemeCubit. HeroCubit and HoverCubit were part of the earlier implementation; neither is wired into the current runtime.',
          ),
          CaseStudySection(
            'Testing state transitions',
            'I added focused tests for theme toggling, hover entry/exit and hero-width updates. A later pass added buildWhen filters to the app and hero builders so they only react to the state fields they use; I make no measured rebuild or frame-rate claim.',
          ),
        ],
        routeSlug: 'cubit-state-management',
        cardTitle: 'Cubit state',
        cardSummary:
            'Replaced Provider-based theme state with Flutter Bloc, added Cubits for hero measurement and hover transitions, and tested their state changes.',
        subtitle:
            'Migrating theme state and adding testable Cubit boundaries for hero measurement and hover transitions.',
      ),
      EngineeringStory(
        'Preparing the Flutter portfolio for web release',
        [
          CaseStudySection(
            'A repeatable GitHub Pages path',
            'I added a GitHub Actions workflow that builds the Flutter app in release mode, uploads the web build artifact and deploys it to GitHub Pages. I set the base href to the root path used by this user-site repository and added Makefile commands for building, serving and cleaning the web build.',
          ),
          CaseStudySection(
            'Reducing the splash-logo asset',
            'I replaced the 2,030,789-byte PNG splash logo with a 178,444-byte WebP, about 91% fewer bytes. The HTML preloads the WebP and retains the PNG as a fallback. This is an asset-size comparison, not a measured page-load improvement.',
          ),
          CaseStudySection(
            'Being precise about loading claims',
            'The repository records iterations on font delivery and Flutter web renderer choices. The current workflow builds with --wasm; the splash references Google Fonts, while Flutter font assets are declared in pubspec.yaml. No before/after page-load timing is recorded, so I do not claim a measured speedup.',
          ),
        ],
        routeSlug: 'flutter-web-delivery',
        cardTitle: 'Web delivery',
        cardSummary:
            'Configured GitHub Pages deployment and reduced the splash-logo asset by about 91% by bytes.',
        subtitle:
            'Automating Flutter Web deployment while keeping asset and performance claims evidence-based.',
      ),
    ],
  );
}
