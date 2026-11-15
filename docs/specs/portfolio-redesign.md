# Spec: Hamza Saleem Portfolio Redesign

## Objective
Redesign Hamza Saleem's existing Flutter Web portfolio so recruiters and engineering teams can quickly understand his primary experience building Flutter mobile applications, his complementary hands-on game-development work, and his specific contributions. Refine the existing warm editorial identity rather than replacing it with a generic portfolio template.

## Capability Map

| Module | Responsibility | Depends on |
|---|---|---|
| `design-system` | Shared color/type/spacing/interaction tokens and a compact responsive style-guide route | — |
| `homepage` | Responsive navigation, editorial hero, selected work, skills, experience, about and contact | `design-system` |
| `case-study-template` | Reusable project and story pages with clear role/contribution, approved media and responsive reading layout | `design-system` |

Build order: `design-system` → `homepage` → `case-study-template` → cross-page verification.

## Design Contract
- Preserve the warm charcoal, cream and sand/beige palette and both light and dark themes.
- Keep the bundled Noto Serif JP display face and Poppins body face; use the serif for editorial display/headings and the sans-serif for readable interface/body copy.
- Keep the seigaiha wave as a small, low-contrast hero signature only. Remove repeated/full-page wave texture, including the splash screen.
- Use restrained borders, flat surfaces and compact corner radii; avoid heavy shadows, prominent gradients, glass effects and oversized rounded-card grids.
- Use a content-first layout with clear role labels, intentional whitespace and a visible keyboard focus state. Hover is supplementary, never the sole indication of interactivity.
- Primary professional track: Flutter mobile engineering. Game development with Unreal Engine/Unity remains explicitly complementary.

## Scope and Acceptance Criteria
### Homepage
- Design and verify widths 1440px, 768px and 375px, in both themes.
- Navigation presents Hamza's name, section links and an accessible theme toggle. At narrow widths, links remain reachable through a touch-friendly menu.
- The first screen establishes Hamza as a software engineer whose primary professional experience is Flutter mobile applications; game-development experience is described as additional hands-on work.
- Provide one primary "Explore selected work" action and one secondary contact action. Do not show a usable Resume action while `PortfolioData.resumeUrl` is null.
- Make Nuex and Grounds the primary mobile-work entries; feature Shadow Hills Manor and Odds & Edges as the complementary game track. Preserve Portfolio Engineering as a smaller, separate supporting item.
- Each project presentation distinguishes Hamza's role/contribution from team/product context and links to its existing case-study page.
- Use only approved local project media. Public store-listing captures are labelled as product context, not as Hamza-authored screens. Shadow Hills Manor may use the user-approved Steam store-page capture as product context; do not present it as an authored gameplay screenshot or add fabricated/private project visuals.
- Keep the lower-page skills, experience, about and contact sections concise and scannable.

### Case-study template
- Reuse one template for project and engineering-story routes at desktop and mobile widths.
- Establish project name, track, role and team context before details; give Hamza's contribution clear visual priority without implying ownership of team work.
- Use existing descriptions, routes, approved media, diagrams and official trailers only. Retain clear media provenance/captions; do not invent metrics, outcomes, responsibilities or implementation details.
- Preserve Play Store/App Store/Steam/external links with accurate labels, the playable Odds & Edges experience, and existing story routes.

### Compact design system
- Add a direct, unlinked `/design-system` preview route that demonstrates semantic light/dark colors, display/body typography, spacing scale, buttons, project-card treatment, navigation, and keyboard focus/hover states at desktop and mobile widths.
- Keep it out of the public primary navigation so it does not distract from the portfolio.

## Tech Stack and Commands
- Flutter Web / Dart using the current project dependencies, bundled fonts, theme Cubit and project/story data.
- No new runtime dependency or project-data claim is planned.
- Tests: `flutter test` (focused tests under `test/`).
- Analysis: `flutter analyze`.
- Build: `flutter build web --release --wasm --base-href /`.

## Project Structure
- `lib/core/theme/`: semantic colors, typography, spacing and component theme.
- `lib/features/portfolio/presentation/pages/`: homepage, existing case-study page and the design-system preview.
- `lib/features/portfolio/presentation/sections/`: navigation, hero, work and lower-page content.
- `lib/features/portfolio/presentation/widgets/`: reusable project/media/action treatments.
- `lib/features/portfolio/data/`: existing factual project-specific content and skills/experience catalogs, aggregated through `PortfolioData`; edit wording only to clarify primary-vs-complementary emphasis.
- `web/index.html`: splash styling, limited to match the signature motif and current theme direction.
- `test/`: responsive navigation, project/story content, theme, focus and design-system coverage.
- `docs/screenshots/`: reviewed local-browser previews for target widths/themes.

## Code Style
Keep project-owned content in the portfolio data modules exposed through `PortfolioData`, presentation in feature widgets/pages, and shared styling in semantic theme tokens. Prefer existing immutable models and small composable widgets. Avoid project-specific slug checks in shared UI when data metadata or a generic component supports the behavior.

## Testing Strategy
- Widget tests assert the hero's role positioning, project order/contribution labels, route navigation, resume unavailability, and theme toggle.
- Test homepage and project/story templates at 375px, 768px and 1440px without overflow or Flutter exceptions.
- Test the design-system route at desktop/mobile and both theme states, including semantic colors and visible focus behavior.
- Run full Flutter tests, analyze, release WebAssembly build and real Chromium captures. Compare homepage, case-study and design-system outputs in both themes; inspect runtime console/log output where the available browser tooling permits.

## Boundaries
- **Always:** preserve existing projects/story routes; use only existing facts and approved imagery; keep contribution attribution clear; preserve the resume-unavailable state; make layouts keyboard/touch accessible and responsive.
- **Ask first:** adding dependencies, publishing/removing content, using new or externally sourced project imagery, adding a resume, or making new claims about project ownership/outcomes.
- **Never:** invent a portrait, app UI, metric, responsibility, employer or outcome; present team deliverables as Hamza's solo work; add repeated decorative waves or interaction that is available only on hover.

## Success Criteria
- The homepage's initial view clearly says Flutter mobile engineering is primary and game development is complementary.
- The four requested projects are immediately discoverable and show accurate contribution/context, with approved media or deliberate typographic treatment.
- The reusable project/story template and compact design-system route render clearly in light/dark themes at 375px, 768px and 1440px.
- No unapproved imagery, invented claims, unavailable-resume action, major overflow, inaccessible-only hover interaction, or repeated page-wide wave remains.
- Full tests and the release WebAssembly build pass; any pre-existing analyzer finding is reported rather than hidden.

## Open Questions
None blocking; use the existing portfolio content and media as the source of truth.