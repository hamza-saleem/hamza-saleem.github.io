import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

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
            SizedBox(height: context.responsive(mobile: 28.0, desktop: 40.0)),
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ContactLink(
                    icon: FontAwesomeIcons.github,
                    label: 'GitHub',
                    onTap: () => _launch(PortfolioData.githubUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: FontAwesomeIcons.linkedinIn,
                    label: 'LinkedIn',
                    onTap: () => _launch(PortfolioData.linkedinUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: FontAwesomeIcons.envelope,
                    label: PortfolioData.email,
                    onTap: () => _launch('mailto:${PortfolioData.email}'),
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
                    onTap: () => _launch(PortfolioData.githubUrl),
                  ),
                  _ContactLink(
                    icon: FontAwesomeIcons.linkedinIn,
                    label: 'LinkedIn',
                    onTap: () => _launch(PortfolioData.linkedinUrl),
                  ),
                  _ContactLink(
                    icon: FontAwesomeIcons.envelope,
                    label: PortfolioData.email,
                    onTap: () => _launch('mailto:${PortfolioData.email}'),
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

class _ContactLink extends StatefulWidget {
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
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = _hovered ? context.accent : context.textSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered ? context.accent : context.ruleColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: widget.fullWidth
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              FaIcon(widget.icon, size: 16, color: iconColor),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  widget.label,
                  style: AppTextStyles.button(
                    _hovered ? context.accent : context.textSecondary,
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
