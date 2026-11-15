import 'package:flutter/material.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../sections/contact_section.dart';
import '../sections/about_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../widgets/nav_bar.dart';

class PortfolioPage extends StatefulWidget {
  final String? initialSection;

  const PortfolioPage({super.key, this.initialSection});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _projectsKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();
  bool _initialSectionHandled = false;

  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      'work': _projectsKey,
      'about': _aboutKey,
      'contact': _contactKey,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final section = widget.initialSection;
    if (_initialSectionHandled || section == null || section == 'top') return;
    _initialSectionHandled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = _sectionKeys[section];
      if (mounted && key != null) scrollToKey(key);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        NavBar(sectionKeys: _sectionKeys, scrollController: _scrollController),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeroSection(
                          onViewWork: () => scrollToKey(_projectsKey),
                          onContact: () => scrollToKey(_contactKey),
                        ),
                        SizedBox(
                          key: _projectsKey,
                          child: const ProjectsSection(),
                        ),
                        SizedBox(key: _aboutKey, child: const AboutSection()),
                      ],
                    ),
                  ),
                ),
                SizedBox(key: _contactKey, child: const ContactSection()),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
