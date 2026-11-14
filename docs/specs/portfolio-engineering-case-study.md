# Spec: Portfolio Engineering Case Study

## Objective
Add a standalone “Portfolio Engineering” case study to the portfolio, based on Hamza's work in this repository since its initial commit. The intended audience is recruiters and engineering reviewers. The case study should turn verified implementation history into concise, first-person engineering stories without presenting portfolio work as product-project work.

## Scope
- Add one discoverable portfolio-engineering project/case-study entry and direct routes for its engineering stories.
- Build stories from the user-confirmed author identities and inspectable commit diffs/current source.
- Candidate story themes, subject to evidence review:
  1. Responsive portfolio UI and visual/layout iterations.
  2. Moving UI state to focused Cubits with tests.
  3. Flutter Web delivery, deployment and first-load implementation iterations.
- Maintain internal provenance (relevant commit IDs and code paths) in the content guide so every public claim can be audited.

## Evidence and Claim Bar
- Treat the user's confirmation as establishing authorship for commits under `hamza-saleem <hamza.saleem87@gmail.com>`, `hamza-saleem-s93 <hamza.saleem@studio93.io>`, and `Muhammad Hamza Saleem (Scapegoat)` with either confirmed email.
- Verify each implementation claim against its commit diff and/or current source; commit subjects alone may identify a topic but are insufficient to claim internals or outcomes.
- Make no unmeasured performance, user, business, or quality-impact claims. Describe changes made, not presumed results.
- Do not infer any Nuex, Grounds, or game-project work from this repository's portfolio commits.

## Tech Stack
Flutter Web / Dart using the existing project models, centralized `PortfolioData`, named route generation, and widget tests. No new dependency is planned.

## Commands
- Focused tests: `flutter test test/portfolio_navigation_test.dart`
- Full tests: `flutter test`
- Static analysis: `flutter analyze`
- Web build: `flutter build web`

## Project Structure
- `lib/features/portfolio/data/portfolio_data.dart`: new case-study content.
- `lib/features/portfolio/models/project_model.dart`: category/story navigation metadata if required.
- `lib/features/portfolio/presentation/sections/projects_section.dart`: discoverable card/group rendering.
- `lib/app.dart` and `lib/features/portfolio/presentation/pages/project_case_study_page.dart`: project/story routes and presentation.
- `test/`: navigation and case-study coverage.
- `docs/PORTFOLIO_CONTENT.md`: private-to-repo evidence provenance and claim boundaries.

## Code Style
Follow existing Flutter conventions: immutable `const` data models; keep content in `PortfolioData`; keep route/page rendering in presentation files; reuse existing layouts and avoid dependencies. Example:

```dart
EngineeringStory(
  'Moving UI state into focused Cubits',
  [CaseStudySection('What changed', 'Describe only behavior verified in the source.')],
)
```

## Testing Strategy
- Widget tests verify the new entry is discoverable and its case-study/story routes render the correct content.
- Test at narrow and wide viewport sizes and verify no Flutter rendering exceptions.
- Run the full widget/unit test suite and web build. Static analysis findings in unrelated pre-existing working-tree changes should be reported, not fixed as part of this work.

## Boundaries
- **Always:** preserve existing user changes; trace public claims to evidence; retain responsive layout and existing routes; avoid unsupported impact claims.
- **Ask first:** changing or removing existing project content, adding dependencies, or using non-repository/private evidence.
- **Never:** claim the portfolio history proves implementation work on Nuex, Grounds, Shadow Hills Manor, or Odds & Edges; invent metrics or implementation details; overwrite unrelated uncommitted changes.

## Success Criteria
- A separate Portfolio Engineering entry is visible and its case study and stories have working direct routes.
- Every public first-person implementation claim is supported by identified history and inspected source/diff.
- No unsupported outcome or product-project contribution is included.
- Responsive widget tests, full tests, and web build pass.

## Open Questions
- None blocking; exact story copy and commit provenance will be finalized during implementation from inspected diffs.
