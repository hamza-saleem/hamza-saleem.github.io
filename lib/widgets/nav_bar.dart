import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class NavBar extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const NavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ThemeNotifier>();
    final hPad = context.responsive(mobile: 16.0, tablet: 24.0, desktop: 32.0);

    return Container(
      color: context.bgColor.withValues(alpha: 0.92),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.ruleColor, width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 14),
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () => scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '影',
                      style: AppTextStyles.heading2(KageMichiColors.crimson),
                    ),
                    TextSpan(
                      text: 'Michi',
                      style: AppTextStyles.heading2(context.textPrimary),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Desktop nav links
            if (context.isDesktop) ...[
              _NavLink('Projects', () => _scrollTo(sectionKeys['projects']!)),
              const SizedBox(width: 28),
              _NavLink('Skills', () => _scrollTo(sectionKeys['skills']!)),
              const SizedBox(width: 28),
              _NavLink('Experience', () => _scrollTo(sectionKeys['experience']!)),
              const SizedBox(width: 28),
              _NavLink('Contact', () => _scrollTo(sectionKeys['contact']!)),
              const SizedBox(width: 16),
            ],
            // Theme toggle
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
            // Mobile/tablet hamburger
            if (!context.isDesktop)
              _MobileMenu(sectionKeys: sectionKeys, scrollTo: _scrollTo),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTextStyles.navItem(
            _hovered ? KageMichiColors.crimson : context.textSecondary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final void Function(GlobalKey) scrollTo;

  const _MobileMenu({required this.sectionKeys, required this.scrollTo});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: context.textSecondary, size: 22),
      color: context.surfaceColor,
      onSelected: (section) => scrollTo(sectionKeys[section]!),
      itemBuilder: (_) => ['projects', 'skills', 'experience', 'contact']
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
