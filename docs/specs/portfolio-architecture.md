# Portfolio Architecture: Current Map and Refactor Direction

## Status

Accepted direction: a lean, feature-first Flutter application. This document records the code map read before refactoring and the boundaries to preserve. It is not permission for a big-bang rewrite. Update it when an incremental refactor establishes a verified new boundary.

## Current application flow

```text
lib/main.dart
  └─ provides ThemeCubit and installs AppBlocObserver
      └─ lib/app.dart
          ├─ BlocBuilder selects light/dark MaterialApp theme
          └─ wires lib/app_routes.dart into MaterialApp
              ├─ matches project/story URLs from PortfolioData
              └─ falls back to PortfolioPage (including section arguments)
                  ├─ NavBar and scroll/section keys
                  ├─ HeroSection
                  ├─ ProjectsSection (mobile, Grounds, Nuex, games, and a supporting Portfolio Engineering link)
                  ├─ AboutSection (bio, skills summary, selected experience)
                  └─ ContactSection

ProjectCaseStudyPage / EngineeringStoryPage
  └─ shared _StudyLayout + case-study widgets
      ├─ project/story content from PortfolioData
      ├─ project-specific chapter grouping in _storyChapters
      ├─ media, diagrams, external links, videos, optional playable embed
      └─ ContactSection
```

The app is a static, local-content Flutter Web portfolio. There is no backend, persistence, remote content repository, or business workflow that currently warrants repository/use-case/service layers.

## Current responsibility map and refactor candidates

| Area | Current responsibility | Reading notes / candidate boundary |
|---|---|---|
| `lib/main.dart`, `lib/app.dart`, `lib/app_routes.dart` | Bootstrap, global theme provider, observer, theme-aware app, project/story route matching and fallback | Bootstrap and theme-aware app stay small; route generation is isolated at the app boundary and covered by focused route-contract tests. Preserve hash URLs and fallback/section-argument behavior. |
| `lib/core/theme/` | Color/type/spacing tokens, Material theme, `ThemeContext`, theme Cubit/state | Retain shared semantic tokens. Keep theme Cubit as app-wide state; do not move portfolio content into core. |
| `lib/core/utils/`, `lib/core/widgets/`, `lib/core/painters/` | Responsive helpers, scrolling, safe links, animation/hover/decorative widgets | Audit actual production use, tests, and Portfolio Engineering story claims before moving/removing anything. Keep only conditional web/stub contracts that still have runtime callers. |
| `lib/features/portfolio/data/` | `portfolio_data.dart` holds profile strings and the ordered `PortfolioData` facade; project definitions are separated by project, with skills and experience in dedicated catalogs | `PortfolioData.projects`, `.skills`, and `.experience` retain typed const access points. Five project modules own their stories/media/links; the aggregator preserves order. Keep local content static and typed; no repository abstraction. |
| `lib/features/portfolio/models/` | Project, story, media, diagram, link, and experience types | Keep domain concepts immutable and explicit. Every story now requires explicit route slug, card title, and summary; catalog tests preserve all current slugs and display copy. |
| `lib/features/portfolio/presentation/pages/` | `project_case_study_page.dart` orchestrates project/story pages and page-specific sections; `case_study_overview.dart` owns intro/contribution widgets; `case_study_stories.dart` owns chapter grouping/index/body; `study_layout.dart` supplies the shared selectable-content shell, navigation and contact footer | Case-study page orchestration is now 300 lines. Characterization tests preserve chapter labels, contribution copy, selectable text, contact footer, routes, media and navigation. Keep project-specific differences explicit. |
| `lib/features/portfolio/presentation/sections/projects_section.dart` | Grounds/Nuex/mobile work, game work, media compositions, and generic `ProjectCard` | Separate track-specific compositions from reusable project/media widgets where this improves clarity. First fix the verified unbounded desktop Grounds row and the narrow media overflow. |
| `lib/features/portfolio/presentation/sections/` | Hero, projects, about, contact, plus standalone skills/experience sections | `PortfolioPage` currently renders About (which includes selected skills/experience summaries), not the standalone `SkillsSection` or `ExperienceSection`. Both have tests or content references; verify desired product use before treating them as dead. |
| `lib/features/portfolio/presentation/widgets/` | Navigation, reusable project/media/link/trailer widgets, diagrams, conditional game/video embeds | Keep feature-specific views in the portfolio feature. Separate generic shared UI only when there is a real second consumer. Preserve lazy/click-to-load and platform behavior. |
| `web/`, `.github/workflows/`, `Makefile`, `pubspec.yaml` | Flutter Web bootstrap/splash, assets/fonts, Pages deploy/build commands | Treat deployment and web interop as explicit platform boundaries; preserve root base-href, WASM build, public routes, and any active platform contracts. |

## Verified usage audit (candidates, not deletion approval)

Core-use audit found the standalone `SkillsSection`/`ExperienceSection` without apparent production-page callers; `SkillsSection` remains directly tested, and both belong to portfolio presentation rather than core. `HoverBuilder` is used by `SkillsSection`; it is not proof that `HoverCubit` was used. The web game/video embedders are used by case-study flows. `HorizontalRule`, the full-background `SeigaihaBackground` wrapper, `HeroCubit`/`HeroState`, `HoverCubit`, `ParallaxWidget`, and the unreferenced text-measurement API/jsDelivr bridge were removed after source, test, docs, and history checks. Their historical use remains documented with commit evidence. `SeigaihaPainter` remains available for the approved hero-only decorative signature.

## Target structure

Keep one app and use ownership-first boundaries:

```text
lib/
  main.dart                 # bootstrap and app-wide providers
  app.dart                  # MaterialApp/theme configuration
  app_routes.dart           # app-boundary project/story route handoff
  core/                     # genuinely shared theme, responsive/platform helpers, generic UI
  features/
    portfolio/
      data/                 # project-specific content plus skills/experience catalogs
      models/               # immutable portfolio-specific types
      presentation/
        pages/              # homepage and reusable project/story page shells
        sections/           # page-level sections and project-track compositions
        widgets/            # portfolio-specific media, diagrams, navigation and embed views
```

This is a target boundary, not a required one-file-per-concept rewrite. Prefer the smallest clear module. Keep project data local and typed; keep Flutter widget rendering in presentation; keep only cross-feature/platform-agnostic code in core. Avoid speculative feature/domain/use-case layers, service locators, routing packages, code generation, and new dependencies.

## Reading and refactoring protocol

Before changing a module:
1. Read the whole module and relevant neighboring implementations.
2. Trace its callers, routes, data producers/consumers, platform variants, tests, and documentation claims.
3. State the behavior and contracts the refactor must preserve; classify the change as behavior-preserving or intentionally behavioral.
4. Write/update the focused test first for behavior changes (TDD). For pure structural refactors, establish characterization tests around externally observable behavior before moving code.
5. Refactor one cohesive slice; test, analyze, and inspect the diff before proceeding. Do not combine visual redesign with a pure refactor.

Clean code here means readable names, cohesive responsibility, explicit contracts, small composable widgets, and abstractions justified by actual reuse. It does not mean minimizing line count or creating layers for hypothetical future needs.

## Current baseline on `feature/portfolio-redesign`

Captured before architecture source changes on the current `feature/portfolio-redesign` working tree:

- `flutter test`: **21 passed, 11 failed**. Failures include an unbounded-height exception in `_GroundsFeature`'s desktop `Row` (`crossAxisAlignment: stretch` in a vertically unbounded scroll page), a narrow Grounds media-row overflow, mobile navigation overflow, and stale assertions expecting prior hero/title labels. Downstream `RenderBox`/hit-test failures follow the initial layout failures. Update tests only where their contract is genuinely stale; retain tests for the accepted current design.
- `flutter analyze`: **2 issues**: an info-level missing block around an `if` in `project_model.dart:70`, and an unused import in `design_system_page.dart`. Do not suppress these; fix or explicitly justify them in their owning slice.
- `flutter build web --release --wasm --base-href /`: **succeeds**. Flutter prints a Cupertino icon-font tree-shaking warning although the project currently finds Material icons only; investigate during the dependency/platform audit, not by adding unused packages.

Baseline runs include the current uncommitted redesign changes; they are not a claim about `main`. Preserve those changes and record the baseline as fixes land.

## Progress after the initial baseline

- Fixed the Grounds desktop unbounded-height exception by changing the stretched row alignment to `start`; a focused regression test confirms natural-height layout.
- Fixed mobile navigation sizing and Grounds media sizing; added mobile/responsive coverage.
- Restored Portfolio Engineering as a visually subordinate homepage entry, with a tested route to its case study and stories.
- Extracted route generation to `lib/app_routes.dart` with tests for project routes, story routes, and unknown-route section fallback.
- Split skill groups, employment entries and all five project records into cohesive files under `features/portfolio/data/`; `PortfolioData` retains typed const access points and catalog order. Characterization tests protect project slugs/tracks/routes, experience ordering/periods/links, and key contribution copy.
- Replaced title-prefix story slug/title/summary inference with required explicit metadata on every story record; catalog tests protect all current story routes, labels, and summaries.
- Extracted the shared project/story shell to `study_layout.dart`, project-introduction/contribution widgets to `case_study_overview.dart`, and chapter grouping/index/body to `case_study_stories.dart`; focused route tests preserve Grounds chapter labels, selection, contact, and contribution rendering.
- Route/navigation coverage passes at 375, 768, 900, 1024, and 1440px. After these extractions, the full suite passes all 47 tests, `flutter analyze` reports no issues, and the release WASM build succeeds.
- Fixed the two baseline analyzer findings (missing braces in `project_model.dart`, unused import in `design_system_page.dart`); `flutter analyze` now reports no issues.
- Removed verified non-runtime helpers: `HorizontalRule`, the full-background `SeigaihaBackground` wrapper, unused Hero/Hover Cubits and state, `ParallaxWidget`, and the text-measurement API/JS bridge. Removed isolated unit tests with the deleted Cubits; retained historical attribution backed by commit evidence and kept `SeigaihaPainter` for the approved hero-only signature.
- Headless Chrome screenshots verified the home page in dark mode at all five target widths and light mode at 1440px; Grounds rendered at 375px and 1440px in light mode. No page-level console errors/exceptions were observed; Chrome emitted software-WebGL/GPU fallback warnings in the headless environment.
- Teardown checks pass for the exercised navigation flow. Browser review is partial (light mode was not captured at every target width); profiling and remaining architecture slices are outstanding.

## Verification

Follow `tasks/plan.md` and `tasks/todo.md`: TDD unit/widget tests first, then full-app integration and route/theme checks, then teardown/disposal checks, and profiling only after correctness. Keep responsive verification at 375, 768, 900, 1024, and 1440px where applicable, in both themes. Final gates include full tests, analyzer, WASM release build, browser console/layout review, and `git diff --check`.
