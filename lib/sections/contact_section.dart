import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/section_fade.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

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
              style: AppTextStyles.heading1(context.textPrimary),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 560,
              ),
              child: Text(
                "Have a project in mind, want to collaborate, or just want to say hello? "
                "I'm always open to interesting conversations and new opportunities.",
                style: AppTextStyles.body(context.textSecondary),
              ),
            ),
            const SizedBox(height: 40),
            // On mobile: stack links full-width. On tablet+: wrap side by side.
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ContactLink(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => _launch(PortfolioData.githubUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: Icons.work_outline,
                    label: 'LinkedIn',
                    onTap: () => _launch(PortfolioData.linkedinUrl),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    icon: Icons.mail_outline,
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
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => _launch(PortfolioData.githubUrl),
                  ),
                  _ContactLink(
                    icon: Icons.work_outline,
                    label: 'LinkedIn',
                    onTap: () => _launch(PortfolioData.linkedinUrl),
                  ),
                  _ContactLink(
                    icon: Icons.mail_outline,
                    label: PortfolioData.email,
                    onTap: () => _launch('mailto:${PortfolioData.email}'),
                  ),
                ],
              ),
            const SizedBox(height: 72),
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
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? context.accent : context.textSecondary,
              ),
              const SizedBox(width: 10),
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
