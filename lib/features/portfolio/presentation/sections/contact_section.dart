import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final h1Size = context.responsive<double>(
      mobile: 28,
      tablet: 32,
      desktop: 36,
    );

    return SectionFade(
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.sectionPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// contact', style: AppTextStyles.label(context.accent)),
            const SizedBox(height: 12),
            Text(
              "Let's Connect",
              style:
                  AppTextStyles.heading1(context.textPrimary, fontSize: h1Size),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isMobile ? double.infinity : 560),
              child: Text(
                "Have a project in mind, want to collaborate, or just want to say hello? "
                "I'm always open to interesting conversations and new opportunities.",
                style: AppTextStyles.body(context.textSecondary),
              ),
            ),
            SizedBox(height: context.responsive(mobile: 32.0, desktop: 48.0)),
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ContactLink(
                    icon: FontAwesomeIcons.github,
                    label: 'GitHub',
                    onTap: () => launchSafely(PortfolioData.githubUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: FontAwesomeIcons.linkedinIn,
                    label: 'LinkedIn',
                    onTap: () => launchSafely(PortfolioData.linkedinUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: FontAwesomeIcons.envelope,
                    label: PortfolioData.email,
                    onTap: () => launchSafely('mailto:${PortfolioData.email}'),
                    fullWidth: true,
                  ),
                ],
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 14,
                children: [
                  _ContactLink(
                    icon: FontAwesomeIcons.github,
                    label: 'GitHub',
                    onTap: () => launchSafely(PortfolioData.githubUrl),
                  ),
                  _ContactLink(
                    icon: FontAwesomeIcons.linkedinIn,
                    label: 'LinkedIn',
                    onTap: () => launchSafely(PortfolioData.linkedinUrl),
                  ),
                  _ContactLink(
                    icon: FontAwesomeIcons.envelope,
                    label: PortfolioData.email,
                    onTap: () => launchSafely('mailto:${PortfolioData.email}'),
                  ),
                ],
              ),
            SizedBox(height: context.responsive(mobile: 48.0, desktop: 72.0)),
            Center(
              child: Column(
                children: [
                  Container(width: 1, height: 40, color: context.ruleColor),
                  const SizedBox(height: 16),
                  Text(
                    '© ${DateTime.now().year} ${PortfolioData.name} — Built with Flutter',
                    style: AppTextStyles.caption(context.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: hovered ? context.accent : context.ruleColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: fullWidth
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              FaIcon(
                icon,
                size: 16,
                color: hovered ? context.accent : context.textSecondary,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.button(
                    hovered ? context.accent : context.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
