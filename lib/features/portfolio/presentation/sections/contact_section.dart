import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: context.isDark ? context.cardColor : context.surfaceColor,
    child: SectionFade(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.sectionPaddingH,
              vertical: context.isMobile ? 48 : 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HAVE A ROLE OR PROJECT IN MIND?',
                  style: AppTextStyles.label(
                    context.accent,
                  ).copyWith(fontSize: 10),
                ),
                const SizedBox(height: 24),
                Text(
                  'Let’s build something\nwith care.',
                  style: AppTextStyles.heading1(
                    context.textPrimary,
                    fontSize: context.responsive(
                      mobile: 32.0,
                      tablet: 38.0,
                      desktop: 44.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () =>
                      launchSafely('mailto:${PortfolioData.email}'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    '${PortfolioData.email}  →',
                    style: AppTextStyles.caption(
                      context.textPrimary,
                    ).copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  PortfolioData.relocation,
                  style: AppTextStyles.caption(
                    context.textSecondary,
                  ).copyWith(fontSize: 10),
                ),
                const SizedBox(height: 28),
                Divider(height: 1, color: context.ruleColor),
                const SizedBox(height: 20),
                if (context.isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FooterLinks(),
                      const SizedBox(height: 20),
                      _Signature(),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const _FooterLinks(), const _Signature()],
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 24,
    runSpacing: 8,
    children: [
      _FooterLink(label: 'GitHub  ↗', url: PortfolioData.githubUrl),
      _FooterLink(label: 'LinkedIn  ↗', url: PortfolioData.linkedinUrl),
    ],
  );
}

class _FooterLink extends StatelessWidget {
  final String label;
  final String url;
  const _FooterLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => launchSafely(url),
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
    ),
    child: Text(label, style: AppTextStyles.caption(context.textPrimary)),
  );
}

class _Signature extends StatelessWidget {
  const _Signature();

  @override
  Widget build(BuildContext context) => Text(
    '${PortfolioData.name} / Software Engineer',
    style: AppTextStyles.caption(context.textSecondary).copyWith(fontSize: 10),
  );
}
