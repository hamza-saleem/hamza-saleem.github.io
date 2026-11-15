import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../sections/projects_section.dart';

class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final project = PortfolioData.projects.firstWhere(
      (project) => project.slug == 'nuex',
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back to portfolio',
          onPressed: () =>
              Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Design system'),
        actions: [
          IconButton(
            tooltip: context.isDark
                ? 'Switch to light theme'
                : 'Switch to dark theme',
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: Icon(
              context.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.sectionPaddingH,
                vertical: context.responsive(
                  mobile: AppSpacing.xl,
                  tablet: AppSpacing.xxl,
                  desktop: AppSpacing.xxl,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// visual language',
                    style: AppTextStyles.label(context.accent),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'A small system for a thoughtful portfolio.',
                    style: AppTextStyles.heading1(
                      context.textPrimary,
                      fontSize: context.responsive(
                        mobile: 28,
                        tablet: 34,
                        desktop: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Warm surfaces, deliberate type, clear evidence.',
                    style: AppTextStyles.body(context.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  _StyleSection(
                    title: 'Color palette',
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final gap = AppSpacing.md;
                        final width = constraints.maxWidth < 620
                            ? constraints.maxWidth
                            : (constraints.maxWidth - gap) / 2;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: [
                            SizedBox(
                              width: width,
                              child: _PaletteGroup(
                                title: 'Dark',
                                colors: [
                                  (
                                    'Background',
                                    HamzaSaleemColors.darkBackground,
                                  ),
                                  ('Surface', HamzaSaleemColors.darkSurface),
                                  ('Card', HamzaSaleemColors.darkCard),
                                  ('Text', HamzaSaleemColors.darkTextPrimary),
                                  (
                                    'Secondary',
                                    HamzaSaleemColors.darkTextSecondary,
                                  ),
                                  ('Sand accent', HamzaSaleemColors.sand),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width,
                              child: _PaletteGroup(
                                title: 'Light',
                                colors: [
                                  (
                                    'Background',
                                    HamzaSaleemColors.lightBackground,
                                  ),
                                  ('Surface', HamzaSaleemColors.lightSurface),
                                  ('Card', HamzaSaleemColors.lightCard),
                                  ('Text', HamzaSaleemColors.lightTextPrimary),
                                  (
                                    'Secondary',
                                    HamzaSaleemColors.lightTextSecondary,
                                  ),
                                  ('Sand accent', HamzaSaleemColors.sandDark),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _StyleSection(
                    title: 'Typography',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Noto Serif JP · Display',
                          style: AppTextStyles.display(
                            context.textPrimary,
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Editorial section heading',
                          style: AppTextStyles.heading1(
                            context.textPrimary,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Poppins · Body text stays readable and calm across screen sizes.',
                          style: AppTextStyles.body(context.textSecondary),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          '// labels · links · metadata',
                          style: AppTextStyles.label(context.accent),
                        ),
                      ],
                    ),
                  ),
                  _StyleSection(
                    title: 'Spacing scale',
                    child: Wrap(
                      spacing: AppSpacing.lg,
                      runSpacing: AppSpacing.md,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final item in [
                          ('4', AppSpacing.xxs),
                          ('8', AppSpacing.xs),
                          ('12', AppSpacing.sm),
                          ('16', AppSpacing.md),
                          ('24', AppSpacing.lg),
                          ('32', AppSpacing.xl),
                          ('48', AppSpacing.xxl),
                        ])
                          _SpacingToken(label: item.$1, size: item.$2),
                      ],
                    ),
                  ),
                  _StyleSection(
                    title: 'Buttons',
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Primary action'),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Secondary action'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Quiet action'),
                        ),
                      ],
                    ),
                  ),
                  _StyleSection(
                    title: 'Navigation',
                    child: _NavigationSample(),
                  ),
                  _StyleSection(
                    title: 'Project card',
                    child: ProjectCard(project: project),
                  ),
                  _StyleSection(
                    title: 'Focus & hover',
                    child: const _FocusHoverSample(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed('/'),
                    icon: const Icon(Icons.arrow_back, size: 18),
                    label: const Text('Return to portfolio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StyleSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _StyleSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 22),
        ),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    ),
  );
}

class _PaletteGroup extends StatelessWidget {
  final String title;
  final List<(String, Color)> colors;

  const _PaletteGroup({required this.title, required this.colors});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      border: Border.all(color: context.ruleColor),
      color: context.cardColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.label(context.accent)),
        const SizedBox(height: AppSpacing.sm),
        for (final item in colors)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: item.$2,
                    border: Border.all(color: context.ruleColor),
                    borderRadius: BorderRadius.circular(AppRadii.tight),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    item.$1,
                    style: AppTextStyles.caption(context.textPrimary),
                  ),
                ),
                Text(
                  _hex(item.$2),
                  style: AppTextStyles.caption(context.textSecondary),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

class _SpacingToken extends StatelessWidget {
  final String label;
  final double size;

  const _SpacingToken({required this.label, required this.size});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${label}px', style: AppTextStyles.caption(context.textSecondary)),
      const SizedBox(height: AppSpacing.xs),
      Container(width: size, height: 8, color: context.accent),
    ],
  );
}

class _NavigationSample extends StatelessWidget {
  const _NavigationSample();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color: context.bgColor,
      border: Border.all(color: context.ruleColor),
    ),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        Text(
          PortfolioData.name,
          style: AppTextStyles.heading2(context.textPrimary, fontSize: 18),
        ),
        Wrap(
          spacing: AppSpacing.xs,
          children: [
            for (final label in ['Work', 'Experience', 'Contact'])
              TextButton(onPressed: () {}, child: Text(label)),
            IconButton(
              tooltip: context.isDark ? 'Light theme' : 'Dark theme',
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: Icon(
                context.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _FocusHoverSample extends StatefulWidget {
  const _FocusHoverSample();

  @override
  State<_FocusHoverSample> createState() => _FocusHoverSampleState();
}

class _FocusHoverSampleState extends State<_FocusHoverSample> {
  bool _focused = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
    onShowFocusHighlight: (value) => setState(() => _focused = value),
    onShowHoverHighlight: (value) => setState(() => _hovered = value),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        border: Border.all(
          color: _focused || _hovered ? context.accent : context.ruleColor,
          width: _focused ? 2 : 1,
        ),
      ),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.keyboard_tab, size: 18),
        label: Text(
          _focused
              ? 'Focused state'
              : _hovered
              ? 'Hover state'
              : 'Tab or hover here',
        ),
      ),
    ),
  );
}
