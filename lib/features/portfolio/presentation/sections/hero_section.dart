import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.screenWidth < 1440;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: context.responsive(mobile: 56.0, tablet: 56.0, desktop: 88.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SOFTWARE ENGINEER · PAKISTAN',
            style: AppTextStyles.label(context.accent).copyWith(fontSize: 11),
          ),
          const SizedBox(height: 28),
          if (compact) ...[
            _HeroIntroduction(onViewWork: onViewWork, onContact: onContact),
            const SizedBox(height: 36),
            const _PracticeNotes(),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _HeroIntroduction(
                    onViewWork: onViewWork,
                    onContact: onContact,
                  ),
                ),
                const SizedBox(width: 80),
                const SizedBox(width: 348, child: _PracticeNotes()),
              ],
            ),
          const SizedBox(height: 28),
          Text(
            'BASED IN PAKISTAN  /  OPEN TO RELOCATION TO JAPAN & INTERNATIONAL OPPORTUNITIES',
            style: AppTextStyles.caption(
              context.textSecondary,
            ).copyWith(fontSize: 10, letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}

class _HeroIntroduction extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const _HeroIntroduction({required this.onViewWork, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final displaySize = context.responsive(
      mobile: 48.0,
      tablet: 70.0,
      desktop: 96.0,
    );
    final focusSize = context.responsive(
      mobile: 33.0,
      tablet: 40.0,
      desktop: 48.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.name,
          style: AppTextStyles.display(
            context.textPrimary,
            fontSize: displaySize,
          ).copyWith(height: 1.2),
        ),
        const SizedBox(height: 24),
        Text(
          'Mobile engineer.\nThoughtful systems,\ncarefully built.',
          style: AppTextStyles.heading1(
            context.textPrimary,
            fontSize: focusSize,
          ).copyWith(height: 1.2),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            'I build and improve Flutter applications. Alongside my mobile work, '
            'I contribute to games in Unreal Engine and Unity.',
            style: AppTextStyles.body(
              context.textSecondary,
            ).copyWith(fontSize: context.isDesktop ? 17 : 15, height: 1.55),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: onViewWork,
              child: const Text('Explore mobile work  →'),
            ),
            FilledButton(
              onPressed: onContact,
              style: FilledButton.styleFrom(
                backgroundColor: context.surfaceColor,
                foregroundColor: context.textPrimary,
              ),
              child: const Text('Get in touch  →'),
            ),
          ],
        ),
      ],
    );
  }
}

class _PracticeNotes extends StatelessWidget {
  const _PracticeNotes();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('01 / PRIMARY PRACTICE', style: AppTextStyles.label(context.accent)),
      const SizedBox(height: 24),
      Text(
        'Flutter & Dart',
        style: AppTextStyles.heading2(context.textPrimary, fontSize: 22),
      ),
      const SizedBox(height: 16),
      Text(
        'Production mobile apps\nState management\nDebugging & reliability',
        style: AppTextStyles.caption(
          context.textSecondary,
        ).copyWith(fontSize: 13, height: 1.55),
      ),
      const SizedBox(height: 22),
      Divider(height: 1, color: context.ruleColor),
      const SizedBox(height: 22),
      Text('02 / COMPLEMENTARY', style: AppTextStyles.label(context.accent)),
      const SizedBox(height: 24),
      Text(
        'Games & systems',
        style: AppTextStyles.heading2(context.textPrimary, fontSize: 22),
      ),
      const SizedBox(height: 16),
      Text(
        'Unreal Engine · Unity\nProgramming · Design · Production',
        style: AppTextStyles.caption(
          context.textSecondary,
        ).copyWith(fontSize: 13, height: 1.55),
      ),
    ],
  );
}
