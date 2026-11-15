# Implementation Plan: Portfolio Redesign

## Overview
Refine the existing Flutter portfolio into a recruiter-scannable editorial experience and complete a behavior-preserving cleanup/refactor into a lean feature-first architecture. Retain its warm serif/sans identity and themes while making Flutter mobile engineering primary, game development complementary, project contributions explicit and project media purposeful. Keep code reading, dependency tracing, and tests central to every change. Add a small design-system preview route for review.

## Verification Strategy
Follow TDD for every behavior/layout fix: add a focused failing test first, implement the smallest fix, then refactor while keeping tests green.

Testing proceeds in this order:
1. **Unit/widget tests:** Cover the failing layout and component behavior at the relevant constraints; include content-visibility and no-overflow assertions.
2. **Integration tests:** Pump the full app and verify project navigation, theme switching, and responsive layouts across the agreed viewport sizes.
3. **Tear-down testing:** Navigate away/unmount tested pages and verify owned controllers, listeners, timers, and other resources are disposed cleanly, with no post-disposal exceptions or leaked callbacks. If the feature owns no disposable resources, record that and verify route teardown still produces no exceptions.
4. **Profiling:** Only after correctness passes, profile representative mobile/tablet/desktop browser views for layout/build/raster costs and check for avoidable regressions. Record findings; optimize only evidence-backed hotspots.

## Architecture Decisions
- Adopt a lean feature-first structure: app composition/routing at the application boundary; genuinely shared styling, platform utilities, and generic UI in `core`; portfolio content/models/presentation grouped within `features/portfolio`.
- Keep this as one Flutter app. Static local portfolio content does not justify repositories, use-case layers, a service locator, new state-management, or added runtime dependencies.
- Retain `PortfolioData`, immutable project/story models, the theme Cubit, Flutter widget stack, and public routes while clarifying boundaries and reducing oversized modules. Split or relocate code only after reading its callers, data flow, and tests.
- Make routing/content metadata explicit where that reduces slug-based branching without introducing a generic content framework prematurely.
- Add shared spacing and component styling through existing theme files; do not add dependencies.
- Preserve behavior, factual claims, approved media, theme support, responsive behavior, and accessibility through every refactor slice.
- Keep the wave painter but remove full-page/splash repetition; use a small hero-only signature.
- Reuse only existing project images/listing captures and existing project/story content. Do not create screenshots or infer details for projects without imagery.
- Keep `/design-system` direct-addressable but absent from the visitor navigation.
- The approved brief and acceptance criteria are recorded in `docs/specs/portfolio-redesign.md`.

## Task List

### Phase 0: Codebase comprehension and architecture refactor
- [ ] Task 0.1: Complete a source/config/test/deployment/assets inventory and document the current dependency map, runtime routes, state ownership, component responsibilities, and verified unused-code candidates in `docs/specs/portfolio-architecture.md`.
  - Acceptance: Trace app entry → theme state → route resolution → homepage/case-study rendering; trace project/story data into its consumers; distinguish verified dead code from items with indirect/test/documentation use. Record the known Grounds unbounded-layout failure as a baseline issue.
  - Verify: `flutter test`, `flutter analyze`, and release build baseline where practical; record pre-existing failures without weakening checks.
  - Files: `docs/specs/portfolio-architecture.md`, inventory notes.
- [x] Task 0.2: Add and maintain a concise root `AGENTS.md` informed by `arranged_transcript.md`.
  - Acceptance: Root guidance stays broadly applicable and short; task-specific rules live in linked specs/docs; no duplicated giant checklist or fragile file-by-file map. Nested agent files are added only if a real module boundary requires distinct instructions.
  - Verify: Check references exist and guidance agrees with project commands, content boundaries, and the accepted architecture.
  - Files: `AGENTS.md`, architecture/content references.
- [ ] Task 0.3: Refactor the app boundary and route resolution in a behavior-preserving slice.
  - Acceptance: Bootstrap/theme ownership and route matching are clear; all existing hash routes, section arguments, story navigation, back behavior, and unknown-route fallback remain valid. No routing dependency is added.
  - Verify: Add/extend route tests first, then run navigation/integration tests and tear-down checks.
  - Files: `lib/main.dart`, `lib/app.dart`, route-focused tests.
- [ ] Task 0.4: Refactor portfolio content/model boundaries in small, readable slices.
  - Acceptance: Large static content is split into cohesive domain/data files only where it improves navigation; models stay immutable and typed; content remains byte-for-byte or meaning-preserving unless a separately reviewed correction is needed. No repository/use-case layer is introduced for local constants.
  - Verify: Data-contract tests cover project/story slugs, references, media paths, links, and required attribution; existing routes still resolve.
  - Files: `lib/features/portfolio/data/`, `models/`, tests.
- [ ] Task 0.5: Decompose oversized portfolio presentation modules by responsibility.
  - Acceptance: Homepage sections, project-track presentations, reusable case-study layout, story/chapter navigation, diagrams/media, and platform embeds have clear ownership; remove duplicate logic only after tracing behavior and callers. Slug-specific behavior is explicit and limited to real content variation.
  - Verify: TDD per slice; preserve responsive/theme/navigation/media behavior and test widget teardown. Do not mix visual redesign changes into pure refactor commits/slices.
  - Files: `lib/features/portfolio/presentation/`, focused tests.
- [ ] Task 0.6: Audit `core` utilities/state/widgets and safely remove or relocate only verified dead code.
  - Acceptance: Shared code is truly reusable or moved into its owning feature; remove obsolete Cubits/helpers only after checking runtime, tests, docs, and case-study claims; keep the intended `core` small.
  - Verify: Search all references, run focused/full tests and analyzer after each removal/refactor; preserve conditional web/stub implementations.
  - Files: `lib/core/`, any affected tests/content.
- [ ] Refactoring standard: Read each touched module and its callers/tests before editing; state the responsibility and behavior being preserved; use small TDD-guided increments; review each diff for clean names, cohesive responsibilities, unnecessary abstraction, and unrelated churn.

### Blocking regression: Responsive Grounds feature layout
- [ ] Reproduce the browser exception at desktop width and confirm the first failure is `_GroundsFeature`'s desktop `Row` at `projects_section.dart:164`; treat later hit-test and RenderBox assertions as cascading until proven otherwise.
- [ ] Remove the unbounded cross-axis constraint without hiding content: first test `CrossAxisAlignment.start` so the details and media retain natural heights; if still necessary, give the desktop composition an explicit, content-safe height strategy or stack it at that breakpoint. Avoid arbitrary clipping and fixed heights that cut off contribution copy.
- [ ] Following TDD, add a failing unit/widget regression test first, then fix the layout and refactor; pump the full homepage at 375, 768, 900, 1024, and 1440px and assert no Flutter exception/overflow plus visible Grounds media and contribution text.
- [ ] Add integration coverage for responsive rendering, theme switching, and project navigation; run browser checks at target widths in light/dark themes and confirm no console/render errors.
- [ ] Tear down/unmount pages after navigation and verify owned resources are disposed without post-disposal exceptions or callbacks.
- [ ] After correctness passes, profile representative viewport(s), inspect layout/build/raster costs, and document any evidence-backed follow-up.

### Phase 1: Design foundation
- [ ] Task 1: Define semantic spacing/type/component tokens and build the responsive design-system preview route.
  - Acceptance: Light/dark palette, typography, spacing, buttons, project-card treatment, navigation and focus/hover states are visible at mobile/desktop; no new dependency.
  - Verify: Focused design-system widget tests, theme assertions, formatter and analyze.
  - Files: `lib/core/theme/`, `lib/app.dart`, new design-system page/widgets, `test/`.

### Checkpoint: Foundation
- [ ] Shared tokens compile; both themes remain valid; the style-guide route is directly reachable.

### Phase 2: Homepage hierarchy and project discovery
- [ ] Task 2: Redesign navigation and hero as a responsive editorial composition with one primary work action, contact action, approved project-media visual, and limited wave signature.
  - Acceptance: The first view identifies Flutter mobile engineering as primary and game development as complementary; no fabricated portrait/UI; resume remains unavailable.
  - Verify: Widget tests and Chromium screenshots at 375px, 768px and 1440px in light/dark themes.
  - Files: `portfolio_page.dart`, `hero_section.dart`, `nav_bar.dart`, wave widgets/painter usage, `web/index.html`, `test/`.
- [ ] Task 3: Rework Selected Work into differentiated mobile and game project presentations.
  - Acceptance: Nuex and Grounds lead mobile work; Shadow Hills Manor and Odds & Edges appear as complementary game work; project role/contribution and team context remain visible; approved assets only; Portfolio Engineering remains subordinate.
  - Verify: Project ordering/media/contribution tests and responsive Chromium captures.
  - Files: `projects_section.dart`, `project_widgets.dart`, optional focused visual widget, `test/`.
- [ ] Task 4: Tighten skills, experience, about and contact into a clear, scannable lower-page sequence.
  - Acceptance: Existing factual content remains intact; hierarchy and density are improved without a long wall of cards/text.
  - Verify: Homepage widget tests at target widths; no overflow or rendering exceptions.
  - Files: `skills_section.dart`, `experience_section.dart`, `about_section.dart`, `contact_section.dart`, `portfolio_page.dart`, `test/`.

### Checkpoint: Homepage
- [ ] All requested homepage sections are discoverable; the four projects are prominent in their correct tracks; light/dark responsive previews reviewed.
- [ ] Grounds desktop/tablet layout passes the regression checks above with no unbounded constraints or downstream hit-test errors.

### Phase 3: Case-study reading experience
- [ ] Task 5: Refine the reusable project/story template for hierarchy, contribution attribution, approved media and responsive reading.
  - Acceptance: Existing direct routes, project links, story navigation, game embed and official trailers still work; contribution and team context are distinguishable; no content is invented.
  - Verify: Existing and new navigation/template tests at 375px, 768px and 1440px; inspect screenshot and media behavior in both themes.
  - Files: `project_case_study_page.dart`, `project_widgets.dart`, shared theme/widgets, `test/`.

### Phase 4: Final quality review
- [ ] Task 6: Review accessibility, responsive screenshots and evidence boundaries; run full quality checks.
  - Acceptance: No page-wide waves, unapproved images, unavailable-resume action, focus-visible gaps, console/page errors or overflow at target sizes.
  - Verify: `flutter test`; `flutter analyze`; `flutter build web --release --wasm --base-href /`; Chromium captures for homepage, project pages and design-system route at 375/768/1440 and both themes; `git diff --check`.
  - Files: affected UI/test/docs and `docs/screenshots/`.

### Checkpoint: Complete
- [ ] All acceptance criteria from `docs/specs/portfolio-redesign.md` are verified.
- [ ] Tests/build pass and responsive/theme screenshots have been reviewed.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|---|---|---|
| Existing media are public store captures, not proof of authored screens. | High | Label them as product context; keep contribution copy separate; use only approved assets. |
| A bespoke layout can obscure content or break at tablet/mobile widths. | Medium | Design mobile-first and test 375/768/1440 after each vertical slice. |
| Light/dark contrast may vary for sand accents. | Medium | Keep semantic theme tokens; check contrast and focus in both modes. |
| The existing HTML splash repeats the wave motif and can mask the real page during browser checks. | Medium | Simplify splash styling and wait for Flutter's first frame during capture. |
| The user requested a compact design system without a public nav item. | Low | Add an unlinked direct route and document its URL. |

## Open Questions
None blocking. Use existing content/assets and the supplied design brief as the approved direction.