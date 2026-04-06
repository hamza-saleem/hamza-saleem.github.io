import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/section_fade.dart';

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
            SizedBox(height: context.responsive(mobile: 14.0, desktop: 20.0)),
            Text(
              PortfolioData.name,
              style: AppTextStyles.display(context.textPrimary),
            ),
            SizedBox(height: context.responsive(mobile: 8.0, desktop: 12.0)),
            Text(
              PortfolioData.title,
              style: AppTextStyles.heading1(context.accent),
            ),
            SizedBox(height: context.responsive(mobile: 20.0, desktop: 28.0)),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.responsive(mobile: double.infinity, desktop: 560.0),
              ),
              child: Text(
                PortfolioData.tagline,
                style: AppTextStyles.body(context.textSecondary),
              ),
            ),
            SizedBox(height: context.responsive(mobile: 36.0, desktop: 48.0)),
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

  const _PrimaryButton({required this.label, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? KageMichiColors.crimsonLight
                : KageMichiColors.crimson,
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.button(Colors.white),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({required this.label, required this.onTap});

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
          ),
        ),
      ),
    );
  }
}
