import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../models/project_model.dart';

class CaseStudyIntroduction extends StatelessWidget {
  final ProjectModel project;
  const CaseStudyIntroduction({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final grounds = project.slug == 'grounds';
    final metadata = grounds
        ? const [
            ('PLATFORM', 'iOS & Android'),
            ('STACK', 'Flutter · GetX · Firebase'),
            ('FOCUS', 'State, logging & reliability'),
          ]
        : [
            ('ROLE', project.role),
            ('CONTEXT', project.context),
            ('STACK', project.tags.take(3).join(' · ')),
          ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sectionPaddingH,
        vertical: context.responsive(mobile: 56.0, tablet: 56.0, desktop: 88.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELECTED WORK / ${project.trackLabel.toUpperCase()}',
            style: AppTextStyles.label(context.accent),
          ),
          const SizedBox(height: 28),
          Text(
            project.title,
            style: AppTextStyles.display(
              context.textPrimary,
              fontSize: context.responsive(
                mobile: 48.0,
                tablet: 72.0,
                desktop: 100.0,
              ),
            ).copyWith(height: 1.2),
          ),
          const SizedBox(height: 28),
          Text(
            grounds
                ? 'Making an existing production app\neasier to extend and maintain.'
                : project.caseStudyIntro ?? project.description,
            style: AppTextStyles.heading1(
              context.textPrimary,
              fontSize: context.responsive(
                mobile: 28.0,
                tablet: 32.0,
                desktop: 38.0,
              ),
            ).copyWith(height: 1.25),
          ),
          const SizedBox(height: 24),
          Text(
            grounds
                ? 'Flutter development · Studio93 · Development team member'
                : '${project.role} · ${project.context}',
            style: AppTextStyles.caption(context.textSecondary),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 40.0;
              final width = constraints.maxWidth < 600
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap * 2) / 3;
              return Wrap(
                spacing: gap,
                runSpacing: 16,
                children: [
                  for (final item in metadata)
                    SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.$1,
                            style: AppTextStyles.label(
                              context.accent,
                            ).copyWith(fontSize: 10),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.$2,
                            style: AppTextStyles.caption(context.textPrimary),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            grounds
                ? 'Product context: a women’s health and fitness app. The work below describes my contribution within the development team, not ownership of the whole product.'
                : '${project.context}. This page describes my documented role and contribution.',
            style: AppTextStyles.body(
              context.textSecondary,
            ).copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class ContributionSummary extends StatelessWidget {
  final ProjectModel project;
  final String? contribution;
  const ContributionSummary({
    super.key,
    required this.project,
    required this.contribution,
  });

  @override
  Widget build(BuildContext context) {
    final content = contribution ?? project.description;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sectionPaddingH),
      child: Container(
        color: context.cardColor,
        padding: EdgeInsets.all(context.isMobile ? 24 : 40),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final introduction = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MY CONTRIBUTION',
                  style: AppTextStyles.label(context.accent),
                ),
                const SizedBox(height: 16),
                Text(
                  project.slug == 'grounds'
                      ? 'Incremental changes.\nProduction constraints.'
                      : 'Documented work.\nClear ownership.',
                  style: AppTextStyles.heading2(
                    context.textPrimary,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  project.role,
                  style: AppTextStyles.caption(context.textSecondary),
                ),
                Text(
                  project.context,
                  style: AppTextStyles.caption(context.textSecondary),
                ),
              ],
            );
            final details = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.slug == 'grounds'
                      ? 'I improved an existing Flutter/GetX application across iOS and Android.'
                      : project.title,
                  style: AppTextStyles.body(
                    context.textPrimary,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                if (project.slug == 'grounds')
                  for (final item in const [
                    '01  Authentication & user-state lifecycle',
                    '02  Exercise logging with V1 compatibility',
                    '03  App-update UI & dashboard integration',
                    '04  Production reliability fixes',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        item,
                        style: AppTextStyles.caption(context.textPrimary),
                      ),
                    )
                else
                  Text(content, style: AppTextStyles.body(context.textPrimary)),
                if (project.role.toLowerCase().contains('team')) ...[
                  const SizedBox(height: 16),
                  Text(
                    'These are my documented contributions within the team. Product screenshots do not establish whole-screen ownership.',
                    style: AppTextStyles.caption(context.textSecondary),
                  ),
                ],
              ],
            );
            if (constraints.maxWidth < 700) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [introduction, const SizedBox(height: 32), details],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 320, child: introduction),
                const SizedBox(width: 64),
                Expanded(child: details),
              ],
            );
          },
        ),
      ),
    );
  }
}
