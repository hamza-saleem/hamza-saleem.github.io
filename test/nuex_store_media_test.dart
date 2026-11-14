import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_website/features/portfolio/data/portfolio_data.dart';
import 'package:portfolio_website/features/portfolio/models/project_model.dart';
import 'package:portfolio_website/features/portfolio/presentation/widgets/project_widgets.dart';

void main() {
  testWidgets('Nuex link is labeled for the Google Play Store', (tester) async {
    final nuex = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'nuex',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ProjectLinks(project: nuex)),
      ),
    );

    expect(find.text('View on Play Store'), findsOneWidget);
    expect(find.text('View on App Store'), findsNothing);
  });

  testWidgets('project media does not show a source button', (tester) async {
    const media = ProjectMedia(
      caption: 'Public store listing',
      alt: 'A public store listing',
      sourceUrl: 'https://example.com',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ProjectMediaView(media: media)),
      ),
    );

    expect(find.text('Media source'), findsNothing);
  });

  test('Nuex includes the public Google Play listing capture', () {
    final nuex = PortfolioData.projects.singleWhere(
      (project) => project.slug == 'nuex',
    );

    expect(
      nuex.liveUrl,
      'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
    );
    expect(nuex.liveUrlLabel, 'View on Play Store');
    expect(nuex.media, hasLength(1));
    expect(nuex.media.single.asset, 'assets/images/projects/nuex/hero.png');
    expect(
      nuex.media.single.sourceUrl,
      'https://play.google.com/store/apps/details?id=com.nuex.org&hl=en',
    );
    expect(nuex.media.single.caption, 'Nuex — public Google Play listing');
  });
}
