import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/models/project_model.dart';

void main() {
  test('project catalog preserves order, tracks, and stable routes', () {
    expect(PortfolioData.projects.map((project) => project.slug), [
      'nuex',
      'grounds',
      'shadow-hills-manor',
      'odds-and-edges',
      'portfolio-engineering',
    ]);
    expect(PortfolioData.projects.map((project) => project.track), [
      ProjectTrack.mobile,
      ProjectTrack.mobile,
      ProjectTrack.game,
      ProjectTrack.game,
      ProjectTrack.portfolio,
    ]);
    expect(PortfolioData.projects.map((project) => project.route), [
      '/projects/nuex',
      '/projects/grounds',
      '/projects/shadow-hills-manor',
      '/projects/odds-and-edges',
      '/projects/portfolio-engineering',
    ]);
  });

  test('Shadow Hills Manor media is an attributed public Steam capture', () {
    final shadowHills = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'shadow-hills-manor',
    );
    final capture = shadowHills.media.single;

    expect(
      capture.asset,
      'assets/images/projects/shadow-hills-manor/steam-store-capture.png',
    );
    expect(capture.sourceUrl, shadowHills.liveUrl);
    expect(capture.caption, 'Shadow Hills Manor — public Steam store listing');
    expect(capture.alt, contains('Steam store page'));
    expect(capture.explanation, contains('product context'));
  });

  test('every story has explicit navigation and display metadata', () {
    final stories = PortfolioData.projects.expand((project) => project.stories);

    expect(stories.map((story) => story.routeSlug), everyElement(isNotNull));
    expect(stories.map((story) => story.cardTitle), everyElement(isNotNull));
    expect(stories.map((story) => story.cardSummary), everyElement(isNotNull));
    expect(stories.map((story) => story.slug), [
      'food-logging-reliability',
      'nutrition-progress-history',
      'exercise-logging',
      'authentication',
      'app-update',
      'production-debugging',
      'production-debugging',
      'responsive-portfolio-ui',
      'cubit-state-management',
      'flutter-web-delivery',
    ]);
    expect(stories.map((story) => story.shortTitle), [
      'Food Search & Logging',
      'Daily Progress',
      'Exercise Logging',
      'Authentication & User State',
      'App Update',
      'Production Debugging',
      'Production Debugging',
      'Responsive UI',
      'Cubit state',
      'Web delivery',
    ]);
    expect(stories.map((story) => story.summary), [
      'Fixed a false empty search state and carried catalog or personal foods into portion-aware, transaction-safe meal logging.',
      'Kept past-day goals separate from the profile default and tied live progress to saved meal data.',
      'Supported exercise-specific measurements with value1/value2 while preserving historical weight/reps records.',
      'Clarified authentication and user-state responsibilities, and improved readiness and controller lifecycle handling.',
      'Implemented update UI, models and dashboard integration, and refined dependency registration.',
      'Strengthened lifecycle guards, asynchronous state handling and checks around production edge cases.',
      'Strengthened lifecycle guards, asynchronous state handling and checks around production edge cases.',
      'Started with a Flutter portfolio, reorganized its code, and evolved its responsive project and case-study presentation.',
      'Replaced Provider-based theme state with Flutter Bloc, added Cubits for hero measurement and hover transitions, and tested their state changes.',
      'Configured GitHub Pages deployment and reduced the splash-logo asset by about 91% by bytes.',
    ]);
  });

  test(
    'experience entries preserve their order, periods, and project links',
    () {
      expect(PortfolioData.experience.map((entry) => entry.company), [
        'Studio93',
        'KageMichi Dev',
        'Know Buddy Games',
        'CYBRNODE',
        'Clash of Dvlopers',
      ]);
      expect(PortfolioData.experience.map((entry) => entry.period), [
        '2025 - 2026',
        '2025 - Present',
        '2024 - 2026',
        '2022 — 2024',
        '2021 — 2022',
      ]);
      expect(
        PortfolioData.experience.first.projects.single.route,
        '/projects/grounds',
      );
    },
  );
}
