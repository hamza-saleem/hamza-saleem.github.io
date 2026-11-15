# Tasks: Portfolio Redesign

## Phase 0: Comprehension and lean feature-first refactor
- [x] Read and map source, tests, data flow, state ownership, routes, assets, platform boundaries, and deployment before structural edits; write `docs/specs/portfolio-architecture.md` with the evidence-backed current map and target boundaries.
- [x] Add a concise root `AGENTS.md` based on `arranged_transcript.md`: project-wide rules only, links to focused docs, no duplicated task-specific checklists or brittle detailed file maps.
- [x] Establish and record baseline tests/analyzer/build results; keep existing failures visible and do not lower quality gates. Initial baseline and current results are recorded in `docs/specs/portfolio-architecture.md`; all 47 tests pass, analyzer is clean, and the release WASM build succeeds.
- [x] Refactor app bootstrap/routing without changing existing routes or navigation behavior. Moved route generation to `lib/app_routes.dart`; project, story, and fallback contracts are covered in `test/app_routes_test.dart`.
- [ ] Refactor portfolio content/models into cohesive feature-owned modules where the audit shows a readability benefit; preserve claim meaning, typed contracts, stable slugs, links and media metadata. Project records, skills, and experience are in cohesive data modules behind `PortfolioData`; story slugs, card titles, and summaries are now required explicit metadata, with catalog tests preserving current values.
- [ ] Decompose oversized presentation files by cohesive responsibility; trace callers and existing behavior before each change; keep visual redesign separate from pure refactoring. In progress: shared `StudyLayout`, project overview/contribution widgets, and story chapter/index/body are extracted; assess remaining page-specific media/reflection helpers before splitting further.
- [ ] Audit shared core utilities/widgets/state; relocate/remove only verified unused code after searching runtime, test and documentation references. First slice removed the unreferenced `HorizontalRule` and full-background `SeigaihaBackground` wrapper; retain `SeigaihaPainter` for the approved hero signature. The unreferenced text-measurement API/jsDelivr bridge and runtime-unused Hero/Hover Cubits, HeroState, and `ParallaxWidget` are removed after source/test/docs/history review; their historical use remains documented with commit evidence.
- [ ] Use small TDD-guided refactor slices; each slice retains existing behavior, compiles, and passes relevant focused tests before proceeding.
- [ ] Review architecture/refactor diffs for clean names, cohesive responsibilities, minimal abstraction, no unrelated churn, and preservation of all user changes.

## Phase 1: Design foundation
- [x] Task 1: Define semantic design tokens and build a responsive `/design-system` preview route.
  - Acceptance: Demonstrates both theme palettes, type, spacing, buttons, navigation, project cards, and focus/hover behavior.
  - Verify: Focused widget tests; formatter/analyze.
  - Files: `lib/core/theme/`, `lib/app.dart`, new preview page/widgets, `test/`.

## Testing approach (applies to each fix)
- [ ] Use TDD: write a failing focused unit/widget test first, implement the fix, then refactor with tests green.
- [ ] Run unit/widget tests before full-app integration tests (responsive rendering, navigation, theme behavior).
- [x] Perform tear-down tests: unmount/navigate away and verify owned controllers, listeners, timers, and callbacks are disposed cleanly; record when no disposable resources are owned. The navigation integration test unmounts the app after route/theme interactions and asserts no teardown exception.
- [ ] Profile representative browser viewports only after correctness is established; document findings and optimize measured hotspots only.

## Blocking regression: Grounds feature layout
- [x] Reproduce the reported Grounds exception and verify the desktop `_GroundsFeature` row's `crossAxisAlignment: stretch` was the root constraint issue; downstream hit-test/RenderBox assertions were cascading.
- [x] Fix the constraint at its source while preserving natural content height and contribution copy (`CrossAxisAlignment.start`; no clipping or arbitrary height).
- [x] Following TDD, add a failing widget test, then fix and refactor; cover 375, 768, 900, 1024, and 1440px with no exceptions/overflow and visible media/contribution content.
- [ ] Add integration checks for responsive rendering, theme switching, and project navigation; verify browser rendering at target widths and both themes. Widget navigation/layout/theme checks cover 375, 768, 900, 1024, and 1440px; headless Chrome review covered dark home at all widths and light home/Grounds at 375/1440px. Capture light mode at remaining widths.
- [x] Tear down/unmount after navigation and confirm no post-disposal exceptions or leaked callbacks. The responsive navigation test unmounts after route/theme interactions and checks for exceptions after disposal.
- [ ] After tests pass, profile representative browser viewports and document evidence-backed performance findings.

## Phase 2: Homepage
- [ ] Task 2: Redesign hero/navigation with a clear Flutter-first role statement, one primary work action, contact action, approved image composition, and hero-only wave signature.
  - Acceptance: Resume remains unavailable; tablet/mobile nav is reachable; no invented portrait/UI.
  - Verify: Widget and Chromium checks at 375/768/1440px in light/dark themes.
  - Files: `portfolio_page.dart`, `hero_section.dart`, `nav_bar.dart`, splash/wave usage, `test/`.
- [ ] Task 3: Make selected projects differentiated and scannable, with mobile engineering leading game-development work.
  - Acceptance: Nuex, Grounds, Shadow Hills Manor and Odds & Edges are featured accurately; approved assets only; Portfolio Engineering is subordinate.
  - Verify: Project data/navigation/media tests and responsive browser previews.
  - Files: `projects_section.dart`, project widgets, `test/`.
- [ ] Task 4: Refine skills, experience, about and contact sections for concise scanning.
  - Acceptance: Existing facts retained; no unbroken text/card wall or new claims.
  - Verify: Responsive widget tests and overflow checks.
  - Files: lower-page section widgets and `test/`.

## Checkpoint: Homepage
- [ ] Desktop, tablet and mobile layouts are reviewed in light and dark themes.
- [ ] Grounds feature regression passes without layout or browser console errors.
- [ ] Flutter mobile work reads as primary; game work as complementary.

## Phase 3: Case-study template
- [ ] Task 5: Refine project/story pages for role, contribution, team context, approved media, links and responsive reading.
  - Acceptance: All current direct routes and story/game/media links remain valid.
  - Verify: Route/template widget tests at 375/768/1440px; visual review in both themes.
  - Files: case-study page, project widgets, tests.

## Phase 4: Final verification
- [ ] Task 6: Run full tests, analyze, WebAssembly release build, and browser visual/accessibility review; save representative screenshots.
  - Acceptance: No overflow, Flutter exceptions, missing assets, repeated page-wide wave or resume action; evidence boundaries preserved.
  - Verify: `flutter test`, `flutter analyze`, `flutter build web --release --wasm --base-href /`, `git diff --check`.
  - Files: `test/`, `docs/screenshots/`, any reviewed UI fixes.
