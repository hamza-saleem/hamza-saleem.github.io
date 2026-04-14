import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../../../../core/widgets/hover_builder.dart';
import '../../data/portfolio_data.dart';

class NavBar extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const NavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ThemeNotifier>();

    return Container(
      color: context.bgColor.withValues(alpha: 0.92),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.ruleColor, width: 1),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.sectionPaddingH,
                vertical: 14,
              ),
              child: Row(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    ),
                    child: Text(
                      PortfolioData.name,
                      style: AppTextStyles.heading2(
                        context.textPrimary,
                        fontSize: context.responsive<double>(
                          mobile: 18.0,
                          tablet: 20.0,
                          desktop: 24.0,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (context.isDesktop) ...[
                    _NavLink(
                      'Projects',
                      () => scrollToKey(sectionKeys['projects']!),
                    ),
                    const SizedBox(width: 28),
                    _NavLink(
                      'Skills',
                      () => scrollToKey(sectionKeys['skills']!),
                    ),
                    const SizedBox(width: 28),
                    _NavLink(
                      'Experience',
                      () => scrollToKey(sectionKeys['experience']!),
                    ),
                    const SizedBox(width: 28),
                    _NavLink(
                      'Contact',
                      () => scrollToKey(sectionKeys['contact']!),
                    ),
                    const SizedBox(width: 16),
                  ],
                  IconButton(
                    onPressed: notifier.toggle,
                    icon: Icon(
                      notifier.isDark
                          ? Icons.wb_sunny_outlined
                          : Icons.nightlight_outlined,
                      color: context.textSecondary,
                      size: 20,
                    ),
                    tooltip: notifier.isDark ? 'Light mode' : 'Dark mode',
                  ),
                  if (!context.isDesktop) _MobileMenu(sectionKeys: sectionKeys),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTextStyles.navItem(
            hovered ? context.accent : context.textSecondary,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;

  const _MobileMenu({required this.sectionKeys});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: context.textSecondary, size: 22),
      color: context.surfaceColor,
      onSelected: (section) => scrollToKey(sectionKeys[section]!),
      itemBuilder: (_) => sectionKeys.keys
          .map(
            (s) => PopupMenuItem(
              value: s,
              child: Text(
                s[0].toUpperCase() + s.substring(1),
                style: AppTextStyles.navItem(context.textPrimary),
              ),
            ),
          )
          .toList(),
    );
  }
}
