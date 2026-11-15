import '../models/project_model.dart';

class NuexProjectData {
  NuexProjectData._();

  static const ProjectModel project = ProjectModel(
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
        routeSlug: 'food-logging-reliability',
        cardTitle: 'Food Search & Logging',
        cardSummary:
            'Fixed a false empty search state and carried catalog or personal foods into portion-aware, transaction-safe meal logging.',
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
        routeSlug: 'nutrition-progress-history',
        cardTitle: 'Daily Progress',
        cardSummary:
            'Kept past-day goals separate from the profile default and tied live progress to saved meal data.',
        subtitle:
            'Keeping per-day goals, saved meals and the home progress summary in sync.',
      ),
    ],
    liveUrl: 'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
    liveUrlLabel: 'View on Play Store',
    media: [
      ProjectMedia(
        asset: 'assets/images/projects/nuex/hero.png',
        caption: 'Nuex — public Google Play listing',
        alt:
            'Browser capture of the Nuex: Calorie & Weight Tracker Google Play listing, including its app icon and promotional screenshots.',
        sourceUrl:
            'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
        aspectRatio: 1440 / 1000,
        explanation:
            'Public product context; this does not identify which screens I implemented.',
      ),
    ],
    featured: true,
  );
}
