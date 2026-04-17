import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/text_measurer.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../../../core/widgets/parallax_widget.dart';
import '../../../../core/widgets/section_fade.dart';
import '../../cubit/hero_cubit.dart';
import '../../data/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.scrollController,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late final HeroCubit _heroCubit;

  @override
  void initState() {
    super.initState();
    _heroCubit = HeroCubit();
    // Measure after the first frame so BuildContext has accurate layout info.
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureName());
  }

  Future<void> _measureName() async {
    if (!mounted) return;
    final fontSize = context.responsive<double>(
      mobile: 36,
      tablet: 48,
      desktop: 56,
    );
    final result = await TextMeasurer.measure(
      text: PortfolioData.name,
      font: '700 ${fontSize.toInt()}px "Noto Serif JP"',
    ).timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        debugPrint(
          '[HeroSection] Text measurement timed out — underline will not render.',
        );
        return null;
      },
    );
    if (!mounted || result == null) return;
    _heroCubit.setNameWidth(result.maxLineWidth);
  }

  @override
  void dispose() {
    _heroCubit.close();
    super.dispose();
  }

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

    return BlocProvider.value(
      value: _heroCubit,
      child: SectionFade(
        child: ParallaxWidget(
          scrollController: widget.scrollController,
          parallaxStrength: 0.3,
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
                SizedBox(
                  height: context.responsive(
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                ),
                Text(
                  PortfolioData.name,
                  style: AppTextStyles.display(
                    context.textPrimary,
                    fontSize: displaySize,
                  ),
                ),
                // Accent underline — width driven by HeroCubit measurement.
                // Animates from 0 → measured width once fonts are ready.
                BlocBuilder<HeroCubit, HeroState>(
                  builder: (context, heroState) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      width: heroState.nameWidth ?? 0,
                      height: 2,
                      margin: EdgeInsets.only(
                        top: context.responsive(
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        ),
                      ),
                      color: context.accent,
                    );
                  },
                ),
                SizedBox(
                  height: context.responsive(
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                ),
                Text(
                  PortfolioData.title,
                  style:
                      AppTextStyles.heading1(context.accent, fontSize: h1Size),
                ),
                SizedBox(
                  height: context.responsive(
                    mobile: 20.0,
                    tablet: 24.0,
                    desktop: 32.0,
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    PortfolioData.tagline,
                    style: AppTextStyles.body(context.textSecondary),
                  ),
                ),
                SizedBox(
                  height: context.responsive(
                    mobile: 32.0,
                    tablet: 40.0,
                    desktop: 48.0,
                  ),
                ),
                if (context.isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PrimaryButton(
                        label: 'View Work',
                        onTap: widget.onViewWork,
                        fullWidth: true,
                      ),
                      const SizedBox(height: 12),
                      _OutlineButton(
                        label: 'Get in Touch',
                        onTap: widget.onContact,
                        fullWidth: true,
                      ),
                    ],
                  )
                else
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _PrimaryButton(
                        label: 'View Work',
                        onTap: widget.onViewWork,
                      ),
                      _OutlineButton(
                        label: 'Get in Touch',
                        onTap: widget.onContact,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _PrimaryButton({
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
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(mobile: 20.0, desktop: 24.0),
            vertical: context.responsive(mobile: 10.0, desktop: 12.0),
          ),
          decoration: BoxDecoration(
            color: hovered ? context.accentHover : context.accent,
          ),
          child: Text(
            label,
            style: AppTextStyles.button(
              context.accentForeground,
              fontSize: context.responsive(mobile: 12.0, desktop: 13.0),
            ),
            textAlign: fullWidth ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _OutlineButton({
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
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(mobile: 20.0, desktop: 24.0),
            vertical: context.responsive(mobile: 10.0, desktop: 12.0),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: hovered ? context.accent : context.ruleColor,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.button(
              hovered ? context.accent : context.textSecondary,
              fontSize: context.responsive(mobile: 12.0, desktop: 13.0),
            ),
            textAlign: fullWidth ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    );
  }
}
