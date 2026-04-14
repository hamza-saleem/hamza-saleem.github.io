import 'package:flutter/material.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../../../../core/widgets/horizontal_rule.dart';
import '../../../../core/widgets/seigaiha_background.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/nav_bar.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();

  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      'projects': _projectsKey,
      'skills': _skillsKey,
      'experience': _experienceKey,
      'contact': _contactKey,
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeigaihaBackground(
        child: Column(
          children: [
            NavBar(
              sectionKeys: _sectionKeys,
              scrollController: _scrollController,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeroSection(
                          scrollController: _scrollController,
                          onViewWork: () => scrollToKey(_projectsKey),
                          onContact: () => scrollToKey(_contactKey),
                        ),
                        const HorizontalRule(),
                        SizedBox(
                          key: _projectsKey,
                          child: ProjectsSection(
                            scrollController: _scrollController,
                          ),
                        ),
                        const HorizontalRule(),
                        SizedBox(
                            key: _skillsKey, child: const SkillsSection()),
                        const HorizontalRule(),
                        SizedBox(
                          key: _experienceKey,
                          child: const ExperienceSection(),
                        ),
                        const HorizontalRule(),
                        SizedBox(
                          key: _contactKey,
                          child: const ContactSection(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
