import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/section_fade.dart';
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
    final displaySize = context.responsive<double>(
      mobile: 36,
      tablet: 48,
      desktop: 56,
    );
    final h1Size = context.responsive<double>(
      mobile: 22,
      tablet: 28,
      desktop: 36,
    );

    return SectionFade(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.sectionPaddingH,
          vertical: context.sectionPaddingV,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '// hello, world',
              style: AppTextStyles.label(context.accent),
            ),
            SizedBox(height: context.responsive(mobile: 12.0, desktop: 20.0)),
            Text(
              PortfolioData.name,
              style: AppTextStyles.display(context.textPrimary,
                  fontSize: displaySize),
            ),
            SizedBox(height: context.responsive(mobile: 8.0, desktop: 12.0)),
            Text(
              PortfolioData.title,
              style: AppTextStyles.heading1(context.accent, fontSize: h1Size),
            ),
            SizedBox(height: context.responsive(mobile: 16.0, desktop: 28.0)),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                PortfolioData.tagline,
                style: AppTextStyles.body(context.textSecondary),
              ),
            ),
            SizedBox(height: context.responsive(mobile: 32.0, desktop: 48.0)),
            if (context.isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PrimaryButton(
                      label: 'View Work', onTap: onViewWork, fullWidth: true),
                  const SizedBox(height: 12),
                  _OutlineButton(
                      label: 'Get in Touch',
                      onTap: onContact,
                      fullWidth: true),
                ],
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _PrimaryButton(label: 'View Work', onTap: onViewWork),
                  _OutlineButton(label: 'Get in Touch', onTap: onContact),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _PrimaryButton(
      {required this.label, required this.onTap, this.fullWidth = false});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? context.accentHover : context.accent,
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.button(context.accentForeground),
            textAlign: widget.fullWidth ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _OutlineButton(
      {required this.label, required this.onTap, this.fullWidth = false});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered ? context.accent : context.ruleColor,
              width: 1,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.button(
              _hovered ? context.accent : context.textSecondary,
            ),
            textAlign: widget.fullWidth ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    );
  }
}
