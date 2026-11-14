# Implementation Plan: Portfolio Engineering Case Study

## Overview
Add a separate, discoverable Portfolio Engineering entry with concise stories grounded in the repository history. The existing project-list model has only mobile/game categories, so introduce an explicit portfolio category rather than mislabeling the site as a mobile or game project. Keep source-control provenance in the content guide; do not expose unsupported claims or metrics.

## Architecture Decisions
- Add a `ProjectTrack.portfolio` category and a matching track label; render it as its own section in Selected Work.
- Reuse the existing `ProjectModel`, `EngineeringStory`, case-study page, and route scheme rather than create a parallel page system.
- Add explicit story navigation metadata for the new stories without changing existing project slugs or routes.
- Build three evidence-led stories: responsive presentation; Provider-to-Cubit state management; Flutter Web/GitHub Pages delivery and first-load iterations. Exact wording will only include facts confirmed by commit diffs and current/history source.
- Add commit hashes and evidence boundaries to `docs/PORTFOLIO_CONTENT.md` for internal auditability. Avoid claiming performance outcomes because no measurements are in this repository history.
- Preserve all current uncommitted user changes; edit those files surgically where integration requires it.

## Task List

### Phase 1: Evidence-backed content

#### Task 1: Add the Portfolio Engineering entry and stories
**Description:** Add the new project category and a Portfolio Engineering record containing three concise engineering stories. Give each story stable route/card metadata and record supporting commit IDs plus claim limits in the content guide.

**Acceptance criteria:**
- [x] The entry is explicitly categorized as Portfolio Engineering, not Mobile Applications or Game Development.
- [x] Each first-person claim is supported by inspected commit diffs and relevant source; outcomes/metrics not in evidence are omitted.
- [x] The three story routes and card summaries are stable and descriptive.

**Verification:** Run formatter, targeted model/content tests, and static analysis of touched files.

**Dependencies:** None.

**Files likely touched:**
- `lib/features/portfolio/models/project_model.dart`
- `lib/features/portfolio/data/portfolio_data.dart`
- `docs/PORTFOLIO_CONTENT.md`
- `test/portfolio_engineering_test.dart`

**Estimated scope:** Medium.

### Phase 2: Discoverability and navigation

#### Task 2: Render and route the new category and stories
**Description:** Add the category heading/description and project card to Selected Work; allow its project page and story pages to use the existing route/page infrastructure.

**Acceptance criteria:**
- [x] The entry appears in a distinct Portfolio Engineering group on mobile and desktop.
- [x] Its card opens the correct case study; each story's direct route opens the intended story.
- [x] Existing mobile/game headings, anchors, project routes, and story routes remain correct.

**Verification:** Run focused widget navigation tests at narrow and wide viewports and check for render exceptions.

**Dependencies:** Task 1.

**Files likely touched:**
- `lib/features/portfolio/presentation/sections/projects_section.dart`
- `lib/features/portfolio/presentation/pages/project_case_study_page.dart`
- `lib/app.dart`
- `test/portfolio_engineering_test.dart`

**Estimated scope:** Medium.

### Phase 3: Final evidence and verification

#### Task 3: Review claims and run project checks
**Description:** Adversarially review each story against its cited commit/source, verify no unrelated user work was changed, then run full repository checks and the web build.

**Acceptance criteria:**
- [x] No claim relies solely on a vague commit subject where code/diff evidence is available.
- [x] No fabricated metrics, user/business outcomes, or product-project contributions are introduced.
- [x] Existing uncommitted user changes are preserved.
- [x] New/old tests pass and web build succeeds.

**Verification:** `flutter test` passed (23 tests); the release WebAssembly build and `git diff --check` passed. `flutter analyze` reports one pre-existing info at `project_model.dart:70` in existing code; it was not changed.

**Dependencies:** Tasks 1-2.

**Files likely touched:** Only files from Tasks 1-2 if review finds a content correction.

**Estimated scope:** Small.

### Checkpoint: Complete
- [x] Portfolio Engineering entry and direct story navigation work responsively.
- [x] Every public claim is traceable to repository evidence.
- [x] Full tests and web build pass; unrelated working-tree changes are preserved.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|---|---|---|
| Adding a third project track affects existing grouping or section anchors. | Medium | Use an explicit switch for category headings/keys and add regression coverage for current mobile/game routes. |
| Existing navigation metadata relies on title-prefix fallbacks. | Medium | Add stable metadata for new stories and leave existing mappings/routes intact. |
| User's current working tree already modifies content, model, project page, and project widgets. | High | Apply narrow changes against the current file contents; inspect diffs and never reset or overwrite existing edits. |
| History documents decisions but not measured outcomes. | Medium | Describe implementation and iterations only; make no quantitative or causal performance claim. |

## Open Questions
- None; the spec was approved. Exact narrative wording is evidence-gated during Task 1.
