# Tasks: Portfolio Engineering Case Study

## Phase 1: Evidence-backed content
- [x] Task 1: Add `ProjectTrack.portfolio`, Portfolio Engineering project/story content, stable story metadata, provenance commit IDs, and focused tests.
  - Acceptance: Separate category; three evidence-supported stories; no unsupported metrics or project-work claims.
  - Verify: Focused Flutter widget/model test and targeted analysis.
  - Files: `lib/features/portfolio/models/project_model.dart`, `lib/features/portfolio/data/portfolio_data.dart`, `docs/PORTFOLIO_CONTENT.md`, `test/portfolio_engineering_test.dart`.

## Phase 2: Discoverability and navigation
- [x] Task 2: Render a Portfolio Engineering group and wire project/story routes through existing page infrastructure.
  - Acceptance: Card and direct story URLs work at mobile/desktop; existing groups/routes remain intact.
  - Verify: Focused responsive navigation tests with no render exceptions.
  - Files: `lib/features/portfolio/presentation/sections/projects_section.dart`, `lib/features/portfolio/presentation/pages/project_case_study_page.dart`, `lib/app.dart`, `test/portfolio_engineering_test.dart`.

## Phase 3: Final verification
- [x] Task 3: Audit every public claim against cited commits/source, preserve unrelated edits, run full checks/build.
  - Acceptance: Claims traceable; no invented outcome; working tree changes scoped.
  - Verify: `flutter test` passed (23 tests), WebAssembly build and `git diff --check` passed; analysis reports a pre-existing info at `project_model.dart:70`.

## Checkpoint: Complete
- [x] Portfolio Engineering entry and direct story routes work responsively.
- [x] All story claims are traceable to code/history and existing routes still work.
- [x] Tests and build pass; unrelated working-tree changes remain untouched.
