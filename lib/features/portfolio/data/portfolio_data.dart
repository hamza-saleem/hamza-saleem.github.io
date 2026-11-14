import '../models/project_model.dart';
import '../models/experience_model.dart';

class PortfolioData {
  PortfolioData._();

  static const String name = 'Hamza Saleem';
  static const String title =
      'Software Engineer — Mobile Applications & Game Development';
  static const String tagline =
      'I build and improve interactive software, with professional experience in '
      'mobile application development and hands-on experience in gameplay programming '
      'using Unreal Engine and Unity.';
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
    ProjectModel(
      slug: 'nuex',
      title: 'Nuex',
      track: ProjectTrack.mobile,
      context: 'Nutrition & wellness app · Engineering team',
      role: 'Flutter Developer · Nutrition Features',
      description:
          'A Flutter nutrition and health tracking app for meal logging, daily macro goals, '
          'water, weight, sleep and activity. I focused on two trust-critical moments: '
          'getting foods into the log correctly and reviewing progress against the right '
          'goal for each day.',
      tags: [
        'Flutter',
        'Provider',
        'GoRouter',
        'Firebase Auth',
        'Cloud Firestore',
        'Health Connect',
      ],
      sections: [
        CaseStudySection(
          'My Contribution',
          'I fixed a food-search parsing bug that hid valid single matches, built a personal '
              'custom-food library, and made serving edits and meal writes preserve the '
              'latest logged data. I also connected daily macro targets and home progress to '
              'date-specific nutrition records. For the team-built step integration, I made '
              'Health Connect status checks start when the user opens that feature.',
        ),
      ],
      stories: [
        EngineeringStory(
          'Food logging that works from search to saved meal',
          [
            CaseStudySection(
              'The break in the logging flow',
              'The food-search API returned no match as an absent value, one match as an '
                  'object, and multiple matches as a list. The client always treated the '
                  'field as a list. When the API found exactly one food, parsing threw and '
                  'the app surfaced an empty result state.',
            ),
            CaseStudySection(
              'Root cause and fix',
              'I traced the false empty state to the response shape, not the search query. '
                  'I normalized absent, single-object and list responses at the parsing '
                  'boundary so the rest of the food library receives one consistent list.',
            ),
            CaseStudySection(
              'When the catalog is not enough',
              'I added a user-scoped custom-food library with create, edit and delete flows. '
                  'Users can enter a food’s name, serving details and macros, then select '
                  'that saved food from the library to add it to a meal.',
            ),
            CaseStudySection(
              'Keep the portion the user chose',
              'Food records can contain serving data in different shapes. I normalized '
                  'servings and kept the selected serving and quantity when a logged food is '
                  'reopened for editing. Macro totals scale with the chosen amount, while '
                  'rounding is applied for display rather than before summing.',
            ),
            CaseStudySection(
              'Protect the saved meal',
              'Add, edit and remove operations read the latest day timeline inside a '
                  'Firestore transaction, validate the target meal and item, then update '
                  'only meal data. This keeps the day’s macro target and other current '
                  'entries intact; if the target meal disappeared while its sheet was open, '
                  'the user gets a clear message.',
              diagram: CaseStudyDiagram.foodSearchToMeal,
            ),
            CaseStudySection(
              'Outcome',
              'A food returned as a single search match now reaches the result list instead '
                  'of looking like no food was found. Catalog results and personal foods can '
                  'both enter the same portion-aware logging flow, with writes based on the '
                  'latest saved day state.',
            ),
          ],
          subtitle:
              'Removing a false empty state and carrying the right food and portion safely into the daily log.',
        ),
        EngineeringStory(
          'Keep nutrition progress honest across dates',
          [
            CaseStudySection(
              'The product problem',
              'Nutrition history needs a stable goal for each date. Editing yesterday’s '
                  'target should not silently change the profile goal used by future days, '
                  'and updating a goal should never erase meals already logged. The home '
                  'summary also needed to show nutrients from saved meals rather than a '
                  'fixed calorie value.',
            ),
            CaseStudySection(
              'Make the goal belong to the selected day',
              'The editor starts from that date’s saved macro snapshot, falling back to the '
                  'profile goal when the date has no record. Saving today updates the profile '
                  'default and today’s snapshot; changing a past date writes only that '
                  'date’s override.',
              diagram: CaseStudyDiagram.nutritionProgressAcrossDates,
            ),
            CaseStudySection(
              'Save the goal without replacing the day',
              'I added a transactional create-or-update for the selected date. It changes '
                  'only the macro snapshot and timestamp on an existing record, preserving '
                  'its meal entries; a date with no record gets a new goal snapshot and an '
                  'empty meal list.',
            ),
            CaseStudySection(
              'Close the loop with actual intake',
              'I replaced the home calorie placeholder with totals from the live meal '
                  'timeline, then made calorie and macro cards react to saved intake. I also '
                  'built a calorie-composition ring that shows the share from protein, '
                  'carbohydrates and fat, tracks progress toward the goal, and shows how '
                  'much the user is over when intake exceeds it.',
            ),
            CaseStudySection(
              'Outcome',
              'Users can adjust a past day without moving the profile default, and goal '
                  'changes do not replace that day’s logged foods. The home summary is '
                  'calculated from saved meals, so progress is shown against the nutrition '
                  'record the user actually created.',
            ),
          ],
          subtitle:
              'Keeping per-day goals, saved meals and the home progress summary in sync.',
        ),
      ],
      liveUrl:
          'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
      liveUrlLabel: 'View on Play Store',
      media: [
        ProjectMedia(
          asset: 'assets/images/projects/nuex/hero.png',
          caption: 'Nuex — public Google Play listing',
          alt:
              'Browser capture of the Nuex: Calorie & Weight Tracker Google Play listing, including its app icon and promotional screenshots.',
          sourceUrl:
              'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
          explanation:
              'Public product context; this does not identify which screens I implemented.',
        ),
      ],
      featured: true,
    ),
    ProjectModel(
      slug: 'grounds',
      title: 'Grounds',
      track: ProjectTrack.mobile,
      context: 'Production application · Studio93',
      role: 'Flutter Developer / Development Team Member',
      caseStudyIntro:
          'Production health and fitness app for women. I contributed as a Flutter developer at Studio93.',
      sections: [
        CaseStudySection(
          'My Contribution',
          'Improved authentication and user-state lifecycle handling in an existing GetX application. '
              'Extended exercise logging while preserving V1 records, implemented app-update UI and dashboard integration, '
              'and strengthened controller, loading and error handling.',
        ),
        CaseStudySection(
          'Constraints',
          'Existing production application across iOS and Android; existing GetX state management.',
        ),
        CaseStudySection(
          'What I Learned',
          'This work reinforced that clear state ownership and dependency lifecycle are '
              'part of application architecture. Authentication identity and user/profile '
              'state need distinct responsibilities, and user-dependent functionality '
              'should wait until that state is ready.\n\n'
              'The exercise-logging work also showed the value of separating stored '
              'measurements from exercise-specific meanings while preserving legacy '
              'records. Incremental changes can improve maintainability and extensibility '
              'without rewriting existing user data or replacing the production architecture.',
        ),
      ],
      stories: [
        EngineeringStory(
          'Extending exercise logging beyond weight and reps',
          [
            CaseStudySection(
              'Problem',
              'I was initially asked to add units for cardio exercise logging. '
                  'The existing V1 model was designed mainly around strength exercises '
                  'and stored measurements directly as weight and reps. Cardio and machine '
                  'exercises needed other measurements, such as distance, incline or steps.',
            ),
            CaseStudySection(
              'Investigation / Root Cause',
              'While implementing the cardio-unit requirement, I recognized a broader '
                  'design limitation: the two logged values could not always mean weight '
                  'and reps. For example, treadmill exercises could require speed, distance or incline, '
                  'while another machine could record steps. The field meanings were tied '
                  'to strength exercises rather than the measurements an exercise required. '
                  'I identified this through implementation work; I do not recall using '
                  'specific logs to discover it.',
            ),
            CaseStudySection(
              'Constraints',
              'Existing V1 user records still used weight and reps and needed to keep '
                  'working. Historical data was not rewritten.',
            ),
            CaseStudySection(
              'Design / Reasoning',
              'For V2, we moved to generic value1 and value2 fields. Their meanings, '
                  'labels and units are determined dynamically in code and the frontend '
                  'based on the exercise name; units are not stored with the logged values. '
                  'A simple treadmill exercise uses distance (km/mi) and speed (levels 1–10), '
                  'while an incline treadmill exercise uses incline and speed (both levels '
                  '1–10). The same two storage fields can represent different measurements.',
            ),
            CaseStudySection(
              'My Implementation',
              'I made my side of the implementation maintainable and extensible: new '
                  'measurements could be added or configured through the appropriate '
                  'exercise measurement mapping in code while reusing value1 and value2. This avoided adding new '
                  'exercise-specific fields and logic for each measurement. I also '
                  'maintained backward compatibility: existing weight/reps records '
                  'continued through the legacy V1 path, while new V2 records used '
                  'value1 and value2.',
            ),
            CaseStudySection(
              'Outcome',
              'V2 supported measurements beyond weight and reps through a generic '
                  'value structure with exercise-specific frontend labels and units. Existing V1 records continued to work '
                  'without rewriting historical data.',
            ),
          ],
          media: [
            ProjectMedia(
              asset:
                  'assets/images/projects/grounds/feature-logging-cardio.jpeg',
              aspectRatio: 720 / 1639,
              focusLogging: true,
              caption: 'Cardio logging — Treadmill Slow Walk',
              alt:
                  'Grounds Treadmill Slow Walk screen with Notes & Logging highlighted, showing Speed 5.9 and distance 4.5 Km.',
              explanation:
                  'The logging panel uses Speed and Km labels for this treadmill exercise. Labels and units are selected in code/frontend based on the exercise name.',
            ),
            ProjectMedia(
              asset:
                  'assets/images/projects/grounds/feature-logging-strength.jpeg',
              aspectRatio: 720 / 1639,
              focusLogging: true,
              caption:
                  'Strength logging — Dumbbell Walking Lunges with Rotation',
              alt:
                  'Grounds Dumbbell Walking Lunges with Rotation screen with Notes & Logging highlighted, showing 10 Reps and an empty kg field.',
              explanation:
                  'The logging panel shows Reps and kg for this strength exercise, illustrating how the displayed measurements change with the exercise.',
            ),
          ],
        ),
        EngineeringStory(
          'Authentication & User State Lifecycle Refactor',
          [
            CaseStudySection(
              'Context',
              'Grounds was an existing production Flutter application using GetX. '
                  'Authentication and user-related responsibilities had become difficult '
                  'to reason about, with tight coupling between controllers and '
                  'user-dependent modules.',
            ),
            CaseStudySection(
              'My Contribution',
              'I incrementally improved the existing authentication and user-state '
                  'architecture, working on responsibility boundaries, dependency '
                  'initialization, controller cleanup, user readiness and defensive '
                  'error handling as a member of the development team.',
            ),
            CaseStudySection(
              'Problem',
              'Modules did not have a consistent rule for obtaining the authenticated '
                  'user’s ID: some used AuthController and others depended on UserController. '
                  'Authentication identity and application user/profile state had '
                  'overlapping responsibilities. Some user-dependent controllers could '
                  'initialize before login or before user state was ready. The logged-out '
                  'startup path also involved work intended for authenticated users, '
                  'while null, asynchronous readiness and lifecycle conditions were '
                  'handled inconsistently.',
            ),
            CaseStudySection(
              'Why It Mattered',
              'An unclear source of truth and tightly coupled controllers made the '
                  'flow harder to debug and maintain. Early initialization could access '
                  'user state before it existed and lead to runtime exceptions. The '
                  'startup goal was straightforward: unauthenticated users should not '
                  'pay the initialization cost of authenticated functionality.',
            ),
            CaseStudySection(
              'Investigation',
              'I examined the broader authentication and controller flow rather than '
                  'treating the issues as one isolated crash. I looked at who owned '
                  'authenticated identity, which controllers depended on user state, '
                  'when they initialized, what happened without an authenticated user, '
                  'and where readiness, null and error assumptions existed.',
            ),
            CaseStudySection(
              'Architectural Direction',
              'The direction was to clarify two responsibilities: the authentication '
                  'layer identifies who is authenticated; the user layer holds the '
                  'application/profile data belonging to that user. Global dependencies '
                  'can initialize at startup, while user-dependent modules should wait '
                  'until authentication is resolved and the authenticated user is ready. '
                  'Logged-out users should follow the unauthenticated flow without '
                  'unnecessary initialization of authenticated-only functionality.',
              diagram: CaseStudyDiagram.authenticationLifecycle,
            ),
            CaseStudySection(
              'Implementation / Refactor',
              'I integrated AuthService into AuthController, refactored authentication '
                  'and user modules, and improved cleanup and user-readiness handling. '
                  'I reduced inappropriate early controller registration and streamlined '
                  'dependency registration across modules. I also strengthened null '
                  'safety and error handling in controllers and asynchronous flows that '
                  'depended on user state. This was an incremental refactor of the '
                  'production architecture.',
            ),
            CaseStudySection(
              'Result',
              'Established clearer boundaries between authentication and user state, '
                  'improved controller lifecycle management, and reduced the number of '
                  'components depending on user-specific state before it was ready. '
                  'The changes improved maintainability and made authenticated versus '
                  'unauthenticated application state easier to reason about.',
            ),
            CaseStudySection(
              'What I Learned',
              'Clear ownership of state matters: authentication identity and '
                  'user/profile state are related, but should not become interchangeable. '
                  'Dependency lifecycle is part of architecture. Addressing the underlying '
                  'readiness and lifecycle problem is more maintainable than adding null '
                  'checks around every symptom. Production refactors also need to be '
                  'incremental to preserve existing behaviour.',
            ),
          ],
          subtitle:
              'Reducing ambiguous state ownership and preventing user-dependent '
              'modules from initializing before authentication was ready.',
        ),
        EngineeringStory(
          'App Update Feature & Dashboard Integration',
          [
            CaseStudySection(
              'Context',
              'The app-update feature was developed within Grounds’ existing production '
                  'Flutter/GetX application. The work covered app versioning, update '
                  'models and presentation, dashboard integration and dependency registration.',
            ),
            CaseStudySection(
              'My Contribution',
              'I implemented the app-update page and controller, worked on supporting '
                  'models and app-versioning code, and built and refined the update UI. '
                  'I also implemented update-sheet management in DashboardController '
                  'and refactored how the feature’s dependencies and UI interactions '
                  'were organized.',
            ),
            CaseStudySection(
              'Versioning & Feature Models',
              'I introduced models supporting the app-update feature and updated '
                  'app-versioning code alongside the UI. This contribution covered '
                  'both the feature’s data representation and its presentation within '
                  'the existing application.',
            ),
            CaseStudySection(
              'Update Presentation',
              'I built the app-update page and UI components, improved image handling '
                  'and layout in update tiles, customized the modal bottom sheet’s '
                  'appearance, and refined text styling and layout. I also streamlined '
                  'the UI components and their code organization as the feature evolved.',
            ),
            CaseStudySection(
              'Dashboard & Dependency Integration',
              'The work initially included a dashboard button and route for the '
                  'app-update feature. I subsequently removed the dashboard button '
                  'and implemented app-update sheet management in DashboardController. '
                  'Alongside this, I refactored dependencies and UI interactions, '
                  'reworked the feature’s bindings and removed the dedicated '
                  'AppUpdateBindings file.',
            ),
            CaseStudySection(
              'Result',
              'Implemented the app-update interface and supporting models, with '
                  'dashboard-managed update-sheet presentation and refined dependency '
                  'and UI organization. This was feature development and incremental '
                  'refactoring within the existing production application.',
            ),
          ],
          subtitle:
              'Building update presentation, supporting versioning/models and '
              'integrating sheet management into the existing dashboard.',
        ),
        EngineeringStory(
          'Production Debugging & Defensive State Handling',
          [
            CaseStudySection(
              'My Contribution',
              'I worked on Sentry-related production issues and reliability fixes '
                  'across Grounds’ existing Flutter/GetX application. My changes '
                  'covered widget lifecycle checks, scroll safety, navigation during '
                  'asynchronous work, missing data, planner/calendar behaviour and '
                  'subscription-state handling.',
            ),
            CaseStudySection(
              'Lifecycle & Scroll Safety',
              'I added a mounted check before scrolling to a comment, guarded scroll '
                  'actions and clamped indices. These changes added explicit checks '
                  'around whether a UI action could proceed and whether an index '
                  'was within bounds.',
            ),
            CaseStudySection(
              'Navigation During Loading / Processing',
              'I disabled navigation while the recommendation page was loading '
                  'and prevented navigation during processing in the program overview. '
                  'I also added loading-state management to planner logging. These '
                  'changes made loading and processing states part of how the UI '
                  'handled user actions.',
            ),
            CaseStudySection(
              'Missing Data & Asynchronous Error Handling',
              'I added checks for empty workout lists, strengthened null safety '
                  'and error handling across controllers, and added error handling '
                  'to post-stream updates. In workout participant services, I added '
                  'error handling and debug logging. This work addressed data '
                  'availability and error conditions in existing application flows.',
            ),
            CaseStudySection(
              'Planner & Calendar Correctness',
              'I corrected calendar navigation to handle year and month values '
                  'and fixed duplicate-workout filtering using createdAt. These '
                  'were targeted correctness fixes alongside the planner’s '
                  'loading-state improvements.',
            ),
            CaseStudySection(
              'Subscription-State Handling',
              'I improved trial-status handling and error logging, and added a '
                  'subscription-availability check. This strengthened how the '
                  'existing subscription flow handled status and availability.',
            ),
            CaseStudySection(
              'Result',
              'The changes added explicit lifecycle, index, loading and data checks, '
                  'strengthened error handling, and corrected planner/calendar '
                  'behaviour within the existing application. They represent targeted '
                  'production fixes rather than a replacement of the application’s '
                  'architecture.',
            ),
            CaseStudySection(
              'Concrete Fix: Comment Scrolling',
              'For comment scrolling, I added a mounted check before performing '
                  'the scroll action. This made widget lifecycle an explicit '
                  'precondition at the point where the UI action was requested. '
                  'The documented change is the guard itself; the original exception '
                  'and reproduction trace are not available.',
            ),
          ],
          subtitle:
              'Addressing lifecycle, asynchronous state and data edge cases '
              'through targeted fixes in an existing production application.',
        ),
      ],
      media: [
        ProjectMedia(
          asset: 'assets/images/projects/grounds/hero.png',
          caption: 'Grounds — public App Store listing',
          alt: 'Browser capture of the Grounds App Store listing',
          sourceUrl:
              'https://apps.apple.com/us/app/grounds-fitness-app-for-women/id6450262705',
          explanation:
              'Public product context; this does not identify which screens I implemented.',
        ),
      ],
      description:
          'Women\'s health & fitness app with 60K+ users and a 4.6★ iOS rating. '
          'My work covered authentication and user-state lifecycle improvements, backward-compatible exercise logging, '
          'app-update UI and dashboard integration, and production reliability fixes.',
      tags: ['Flutter', 'GetX', 'Firebase', 'RevenueCat', 'Sentry'],
      liveUrl:
          'https://apps.apple.com/us/app/grounds-fitness-app-for-women/id6450262705',
      featured: true,
    ),
    ProjectModel(
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
        EngineeringStory('A shared GameInstance foundation', [
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
        ]),
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
    ),
    ProjectModel(
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
    ),
    ProjectModel(
      slug: 'portfolio-engineering',
      title: 'Building this portfolio',
      track: ProjectTrack.portfolio,
      context: 'Personal project · Flutter Web',
      role: 'Portfolio developer',
      description:
          'A responsive Flutter Web portfolio with separate project tracks, direct engineering-story routes, and an automated GitHub Pages release path.',
      tags: [
        'Flutter',
        'Dart',
        'flutter_bloc',
        'GitHub Actions',
        'GitHub Pages',
      ],
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
              'I added a shared HoverBuilder for pointer interactions and a ParallaxWidget used in the hero for scroll-linked movement. I also added browser text measurement and used it to size the animated underline in that section.',
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
              'main.dart provides ThemeCubit through BlocProvider, and app.dart rebuilds theme-dependent MaterialApp state through BlocBuilder. The navigation theme toggle calls ThemeCubit; the hero uses HeroCubit for its underline measurement.',
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
    ),
  ];

  static const Map<String, List<String>> skills = {
    'Mobile Engineering': [
      'Flutter',
      'Dart',
      'GetX',
      'Firebase',
      'REST APIs',
      'iOS',
      'Android',
    ],
    'Game Programming': ['Unreal Engine 5', 'Unity', 'C++', 'C#', 'Blueprints'],
    'Production Engineering': [
      'Debugging',
      'Sentry',
      'App version management',
      'Structured playtesting',
    ],
    'Additional / Working Knowledge': [
      'Bloc',
      'Provider',
      'ChangeNotifier',
      'Hive',
      'GetStorage',
      'SharedPreferences',
      'GitHub',
      'Figma',
      'Jira',
      'Mixpanel',
      'AppsFlyer',
      'RevenueCat',
      'Web',
      'Remote Config',
      'Firebase Storage',
    ],
  };

  static const List<ExperienceModel> experience = [
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
