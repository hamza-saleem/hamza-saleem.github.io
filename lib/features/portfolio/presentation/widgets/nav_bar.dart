import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../../data/portfolio_data.dart';

class NavBar extends StatelessWidget {
  final Map<String, GlobalKey>? sectionKeys;
  final ScrollController? scrollController;
  final ValueChanged<String>? onNavigate;

  const NavBar({
    super.key,
    this.sectionKeys,
    this.scrollController,
    this.onNavigate,
  });

  void _navigate(BuildContext context, String section) {
    final key = sectionKeys?[section];
    if (key != null) {
      scrollToKey(key);
    } else {
      onNavigate?.call(section);
    }
  }

  void _goToTop() {
    if (scrollController != null && scrollController!.hasClients) {
      scrollController!.animateTo(
        0,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    } else {
      onNavigate?.call('top');
    }
  }

  @override
  Widget build(BuildContext context) {
    final links = const [
      ('Work', 'work'),
      ('About', 'about'),
      ('Contact', 'contact'),
    ];
    final themeLabel = context.isDark
        ? 'Switch to light theme'
        : 'Switch to dark theme';
    final themeToggle = context.isMobile
        ? IconButton(
            tooltip: themeLabel,
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: Icon(
              context.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          )
        : Semantics(
            button: true,
            label: themeLabel,
            child: TextButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              style: TextButton.styleFrom(
                backgroundColor: context.surfaceColor,
                foregroundColor: context.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                minimumSize: const Size(0, 44),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                context.isDark ? 'Light ◐' : 'Dark ◑',
                style: AppTextStyles.navItem(context.textPrimary),
              ),
            ),
          );

    return Container(
      decoration: BoxDecoration(
        color: context.bgColor,
        border: Border(bottom: BorderSide(color: context.ruleColor)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.sectionPaddingH,
              vertical: 24,
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: _goToTop,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    PortfolioData.name,
                    style: AppTextStyles.heading2(
                      context.textPrimary,
                      fontSize: context.isMobile ? 16 : 19,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                if (context.isMobile) ...[
                  themeToggle,
                  PopupMenuButton<String>(
                    tooltip: 'Open navigation menu',
                    onSelected: (section) => _navigate(context, section),
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'work', child: Text('Work')),
                      PopupMenuItem(value: 'about', child: Text('About')),
                      PopupMenuItem(value: 'contact', child: Text('Contact')),
                    ],
                    icon: const Icon(Icons.menu),
                  ),
                ] else ...[
                  for (final (label, section) in links)
                    TextButton(
                      onPressed: () => _navigate(context, section),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        label,
                        style: AppTextStyles.navItem(context.textPrimary),
                      ),
                    ),
                  const SizedBox(width: 8),
                  themeToggle,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
