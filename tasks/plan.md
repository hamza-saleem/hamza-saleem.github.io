# Implementation Plan: Improve Skills Section Readability

## Overview
Address the feedback that the Engineering & Skills section is harder to scan because its content competes with the decorative background. Preserve the portfolio's restrained layout, content, and light/dark mode while giving skill groups clearer separation and readable contrast, using Work History as the existing visual reference.

## Assumptions
- Scope is limited to the Engineering & Skills section; the feedback otherwise praises the current portfolio and theme toggle.
- The intended fix is a surface/border treatment similar to Work History cards, not a broader redesign or content rewrite.
- The referenced photo was not available in this conversation, so implementation should be guided by the current UI and code.
- Existing uncommitted changes are unrelated and must remain untouched.

## Architecture Decisions
- Prefer existing theme tokens (`cardColor`, `ruleColor`, text/accent colors) so the treatment works in both themes.
- Keep the current grouped skills content and responsive arrangement; avoid changing information architecture unless inspection shows it is necessary for legibility.
- Match existing card styling rather than introducing new dependencies or a new design system.

## Task List

### Phase 1: Inspect and define
- [x] Task 1: Inspect the Skills section, theme tokens, and current responsive behavior in light and dark modes; identify the smallest effective card/surface treatment.

### Phase 2: Implement and verify
- [x] Task 2: Apply the agreed background/border treatment to skill groups, preserving content and mobile/tablet/desktop layout.
- [x] Task 3: Add or update focused widget coverage and verify rendering/contrast in both themes and at narrow and wide widths.

### Checkpoint: Complete
- [x] Skills are easy to scan without decorative shapes competing with text.
- [x] Both themes remain readable and consistent with Work History styling.
- [x] Existing theme switching, section content, and other portfolio areas are unchanged.
- [x] Flutter tests and build pass; widget checks cover mobile and desktop widths.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|---|---|---|
| Card background may not sufficiently separate text from the decorative pattern in one theme. | Medium | Verify both themes in a running browser and tune using existing semantic theme tokens. |
| Adding a card around each group could create excess visual weight or vertical length. | Low | Keep treatment subtle and validate scanning/layout at mobile and desktop widths. |
| Current working tree contains unrelated in-progress changes. | High | Limit changes to skills-related files and avoid touching existing modified files unless necessary; inspect diffs before finishing. |

## Open Questions
- None blocking at planning stage. The missing attachment limits comparison to that exact image; current source and rendered page will be the reference.
