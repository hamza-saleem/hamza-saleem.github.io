# Agent guide

This repository is a Flutter Web portfolio. Keep its architecture lean and feature-first; preserve existing routes, content attribution, approved media, themes, and responsive behavior.

## Working rules
- Read the relevant files, callers, data contracts, and tests before editing. For refactors, trace behavior and dependencies first; do not infer that code is unused from its name or one search result.
- Prefer cohesive modules, small composable widgets, clear names, and direct solutions. Avoid speculative layers, dependencies, or abstractions.
- Use TDD for behavior changes and refactor in small verifiable slices. Keep pure refactors behavior-preserving; add or retain tests before restructuring.
- Do not invent portfolio claims, project ownership, outcomes, or imagery. Keep contribution attribution and media provenance explicit.
- Preserve unrelated/uncommitted user changes. Do not stage or rewrite broad areas without checking the diff.

## Project references
- Product/design requirements: `docs/specs/portfolio-redesign.md`
- Content evidence and media boundaries: `docs/PORTFOLIO_CONTENT.md`
- Current implementation plan and verification sequence: `tasks/plan.md` and `tasks/todo.md`

## Commands
- Format: `dart format lib test`
- Analyze: `flutter analyze`
- Tests: `flutter test`
- Release build: `flutter build web --release --wasm --base-href /`
