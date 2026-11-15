# Portfolio content and media

The site retains Flutter Web, Bloc theme state, existing responsive helpers and GitHub Pages deployment. Project case studies use Flutter's default hash routing so direct links work without server rewrites:

- `/#/projects/nuex`
- `/#/projects/nuex/food-logging-reliability`
- `/#/projects/nuex/nutrition-progress-history`
- `/#/projects/grounds`
- `/#/projects/shadow-hills-manor`
- `/#/projects/portfolio-engineering`
- `/#/projects/portfolio-engineering/responsive-portfolio-ui`
- `/#/projects/portfolio-engineering/cubit-state-management`
- `/#/projects/portfolio-engineering/flutter-web-delivery`

Project content is owned by project-specific modules under `lib/features/portfolio/data/`; `PortfolioData.projects` preserves the public catalog order. Skills and experience are in `skills_data.dart` and `experience_data.dart`, with the existing `PortfolioData` access points retained. The immutable models support reusable sections, engineering stories, captioned media, source links, optional video/demo URLs and before/after media. Empty sections are hidden. English strings are separated from presentation in the data model to support later localization; no language proficiency or translation is claimed.

## Nuex case studies

The Nuex project now leads with two user-impact stories grounded in Hamza’s authored history. Food search, personal foods, portions and safe meal writes (`be21b35`, `edc3b7f`, `e04ea95`, `c4c761c`, `35d3357`, `e47ee68`); per-day goals, live home intake and calorie composition (`9266a57`, `19164c4`, `f891f28`, `54598e5`, `074261a`). The false empty-search state occurred when the API returned exactly one match as an object and the client expected a list. A smaller change deferred Health Connect status checks until the user opened that feature (`d86b53b`); the wider step-tracking integration was team-built. The public Google Play listing capture provides product context only; no private feature screenshots or product metrics were supplied. The studies describe concrete capabilities and use implementation-flow diagrams without quantified impact claims.

## Portfolio Engineering case study

This case study is about building this portfolio; its commit history is not evidence of implementation work on Nuex, Grounds or the games. Hamza confirmed the following repository identities as his: `hamza-saleem <hamza.saleem87@gmail.com>`, `hamza-saleem-s93 <hamza.saleem@studio93.io>`, and `Muhammad Hamza Saleem (Scapegoat)` with `hamza.saleem87@gmail.com` or `50026474+hamza-saleem@users.noreply.github.com`. Some matching commits include Claude co-author attribution. Do not claim sole authorship. The assistant-created `80e74ac` skills-section commit is excluded from this case-study evidence.

Evidence for the public stories:

- Initial portfolio and its evolution: `34af5bc` creates the first full Flutter portfolio implementation; `7b28183` reorganizes shared code into core/feature areas. Responsive layout and shared UI utilities are further evidenced by `653fb07`, `e42bca9` (GridView-to-width-aware project rows), `06157d1` (HoverBuilder and text measurement), `21ab977` (ParallaxWidget and bundled fonts), `1e8781d` (responsive spacing and typography), and `d3a5869` (current mobile/game project tracks and case-study redesign). Current `projects_section.dart`, `hero_section.dart`, `responsive.dart`, and `hover_builder.dart` support the present implementation. Parallax and browser text measurement are historical; neither is currently wired into the page, and the text-measurement bridge was removed. Do not claim engagement, recruiter conversion, or performance outcomes.
- State management: `b87dd06` replaces Provider-based theme wiring with `flutter_bloc`, adds ThemeCubit, HeroCubit and HoverCubit and their tests; `a56ed32` adds `buildWhen` filters. Current `main.dart`, `app.dart`, and the navigation theme toggle show ThemeCubit runtime wiring. HeroCubit and HoverCubit are historical/tested components, not current runtime dependencies. HoverBuilder's runtime hover state remains widget-local; do not imply it uses HoverCubit.
- Web delivery/assets: `f14165e` adds the Pages workflow; `91886cc` sets root `--base-href`; `55d2e55` removes the deprecated renderer flag; `1dc3e86` adds the WebP splash logo, preload/fallback and Makefile; `b7016e0` records a later Google Fonts/HTML-renderer iteration; `d3a5869` returns the build workflow/Makefile to `--wasm` and bundles Flutter fonts. The current workflow, Makefile, `pubspec.yaml` and `web/index.html` corroborate current configuration. Git object sizes at `1dc3e86`: PNG 2,030,789 bytes and WebP 178,444 bytes (about 91% fewer bytes); this is only an asset-size comparison, not a page-load measurement.
- Case-study platform and game embeds: `d3a5869` introduces the structured project/story model and routed case-study pages; `43fff1b` adds the playable Odds & Edges case study/embed. Describe the portfolio's capabilities, not the underlying project's implementation as Hamza's.
- Maintenance history also includes project-layout overflow fixes, branding, dependency compatibility and year-only experience timelines (`9e61008`, `c8a3173`, `9c032a1`, `adccd4b`, `b3cfd61`). These are not presented as separate impact stories.

The `a56ed32` and `b7016e0` commit messages contain optimization estimates, but no benchmark methodology or before/after page-load measurements are present. Those estimates are deliberately excluded. No user, business, frame-rate or end-to-end load-time outcome is claimed.

## Content to provide

- Grounds: app-update decision criteria/presentation timing/registration rationale and original production-debugging reproduction/Sentry traces remain undocumented. The broader Grounds reflection is now grounded in Hamza’s authentication and logging accounts. The authentication/user-state lifecycle story and its reflection are supplied by Hamza.
- Shadow Hills Manor: the GameInstance reflection has been reviewed and approved by Hamza. The user confirms designing and implementing the team’s shared foundation for save, loading and other persistent game-wide systems. Specific loader internals, streaming techniques, APIs and measured outcomes are not documented and must not be invented.
- A reviewed resume at `web/resume/hamza-saleem-resume.pdf`; then set `PortfolioData.resumeUrl` to `resume/hamza-saleem-resume.pdf`. The Resume action is visibly disabled until then.
- Optional trailer/demo URL in `ProjectModel.videoUrl`.

## Asset convention

The browser captures are real public store-page screenshots, not captures of the running app/game and not evidence of individual screen ownership. Their URL and capture metadata are in each project's `source.json`. The UI shows provenance and this limitation.

Use `assets/images/projects/<slug>/`:

Public store-page captures:

- `nuex/hero.png` — public Google Play capture.
- `grounds/hero.png` — public App Store capture.
- `shadow-hills-manor/steam-store-capture.png` — user-approved public Steam capture; product context only.
- `grounds/feature-logging-cardio.jpeg` and `grounds/feature-logging-strength.jpeg` — supplied exercise-logging screenshots.
- `grounds/technical-state-flow.webp` — optional technical visual.
- `grounds/before.webp`, `grounds/after.webp` — optional comparison.

Shadow Hills Manor uses official public YouTube trailer embeds, links to Know Buddy Games, and the user-approved `assets/images/projects/shadow-hills-manor/steam-store-capture.png`. It is a 1440×1000 public Steam store-page capture, documented in `source.json`, and is labeled as product context—not as a gameplay screenshot authored by Hamza. Do not add internal code, Blueprint graphs or private project visuals.

After adding an image, set the corresponding `ProjectMedia.asset` to its full asset path and replace TODO captions/alt text with accurate descriptions. Provide `explanation` to distinguish personal contribution from product context. Asset directories are registered in `pubspec.yaml`. Avoid confidential logs, user data and unapproved internal material.

## Local development and checks

```sh
flutter pub get
flutter run -d chrome
# Or serve with Flutter's web-server device:
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080
dart format lib test
flutter analyze
flutter test
flutter build web --release --wasm --base-href /
```

GitHub Actions retains its existing Pages deployment. No new runtime dependency was added.

## Validation previews

`docs/screenshots/` contains browser screenshots of the local release build at 375, 768 and 1440 pixels: `home-<width>.png`, `grounds-<width>.png`, and `shadow-hills-manor-<width>.png`. Each direct case-study URL loaded in Chromium without JavaScript page errors. Widget coverage also checks navigation, theme switching and unavailable-media fallback.

Final checks: formatter unchanged on recheck, static analysis reported no issues, all 15 tests passed, and the release WebAssembly build succeeded. Light/dark theme switching and the mobile-work action were also exercised through Chromium’s accessible controls. Additional theme captures are `home-light-1440.png` and `mobile-work-{light,dark}-1440.png`. The SDK emitted a Cupertino font warning during icon tree shaking; the site uses Material icons and the tested controls rendered correctly.

Exercise logging was expanded from Hamza’s first-hand account: the cardio-unit requirement revealed the weight/reps model limitation; V2 stores value1/value2; exercise-specific meanings and units are selected in code/frontend and are not stored with the logged values, while historical records retain the V1 path. No historical-data migration is claimed. The original codebase is unavailable, so do not invent class names, code, logs or test cases. Verification sections were removed at Hamza’s request.

User-provided exercise-logging screenshots are included unchanged at `assets/images/projects/grounds/feature-logging-cardio.jpeg` and `assets/images/projects/grounds/feature-logging-strength.jpeg`. They appear directly under the exercise-logging story with portrait proportions, captions and alt text. The screenshots show frontend fields and do not establish whether the displayed records are V1 or V2.

Official Shadow Hills Manor videos: announcement `0aG555ZLJio`, gameplay `IjMZEyl3XXs`. Responsive 16:9 iframe embeds use YouTube’s privacy-enhanced domain, no autoplay, an accessible title and a strict-origin-when-cross-origin referrer policy. Each has a direct YouTube fallback link. The announcement trailer also appears on the selected-work card. No runtime dependency was added.

Trailer integration checks: analysis passed, all 15 widget/cubit tests passed and the WebAssembly release build succeeded. Chromium loaded both correctly titled official players at desktop and mobile sizes; the layout uses two columns on wide screens and one column on mobile. The old Steam-page image is absent from deployed assets.

Shadow Hills Manor’s primary contribution is now the dedicated GameInstance architecture, based on Hamza’s account. The study covers the team’s need, architectural decision, runtime lifetime, support for save/loading systems, maintainability/reuse/scalability and Hamza’s implementation role. It does not claim ownership of the project or authorship of every system. GameInstance lifetime was checked against [Epic’s gameplay framework documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-framework-in-unreal-engine); this engine-level reference is not evidence of private implementation details.

Grounds authentication case study: the user’s account supports an incremental GetX production refactor covering identity ownership, user/profile state, readiness, startup cost for logged-out users, registration, cleanup and defensive handling. The combined native Flutter diagram communicates conceptual responsibility boundaries and intended lifecycle, not an exact production dependency graph. No metrics or claim of eliminating all coupling is made. Supporting commit subjects (internal provenance only): `6487ca1d3`, `b8c8612c8`, `d9f13af81`, `970253645`, `6c511041c`, `26597293e`. Do not infer private method names, registration mechanisms or startup measurements from these subjects.

Authentication study checks: formatter and analysis passed; all 15 tests passed; the release WebAssembly build succeeded. Browser previews of the conceptual diagram are `docs/screenshots/grounds-auth-diagram-1440.png` and `grounds-auth-diagram-375.png`. On narrow screens the logged-out/logged-in branches stack to preserve readable labels.

App Update story expanded from supplied commit subjects: app-update page/controller/bindings (`bdf45dc25`); models and versioning (`9b18b6a00`, `cdeba8655`); bindings/dependencies/UI interactions and binding-file removal (`869e9eaaa`, `d250fe071`, `b3795fff6`); dashboard button/route and subsequent removal (`2d12fb7e8`, `fbea47b31`); UI organization/tiles/modal/text layout (`2e5fd85d3`, `c34b67a8c`, `b5a85bc3f`, `515f064d5`); dashboard sheet management (`ba44d989f`). Commit subjects establish work scope, not production rollout, update-trigger rules, mandatory/optional update policy, version-comparison algorithms or measured outcomes. The new dependency is unnamed; do not invent its identity. No app-update screenshot is available, and its placeholder has been removed. Reflection remains unwritten rather than inferred from commit messages.

Production debugging expanded from supplied history, with implementation scope separated from missing investigation evidence:

- Lifecycle/scroll: `a8cf95ef7` (mounted check before comment scrolling), `19fd9742f` (guard scrolling/clamp indices).
- Async UI state: `3d57baac2` (processing navigation), `0ffe70d26` (loading navigation), `4620d1cdb` (planner logging loading state).
- Data/errors: `ee73c0be4` (empty workout list), `6c511041c` and `26597293e` (controller null/error handling), `ca8c9020d` (post-stream errors), `3aaed66ae` (workout participant service errors/debug logging).
- Planner/calendar: `ecb65b8dd` (year/month navigation), `a56619611` (duplicate-workout filtering using createdAt).
- Subscriptions: `7b87e3eda` (trial status/error logging), `b103c67ed` (availability check).

Sentry work is already documented in the original portfolio and the supplied branch history. Do not assert a specific exception type, reproduction trace, logging payload, fix rollout or crash-rate reduction from commit subjects. A concrete investigation still needs Hamza’s account; the broader reflection is filled from his authentication and logging explanations. No verification section or screenshot placeholder was added.

TODO completion pass: filled Grounds’ project reflection using the supplied authentication/lifecycle reflection and V1/V2 logging account. The app-update study already contains the supported page/controller/models, UI, dashboard integration and dependency evolution; its remaining unknown decision criteria were moved out of the public story into the pending-content list above. Replaced the debugging placeholder with the documented mounted-check comment-scrolling fix, while explicitly noting that the original exception/reproduction trace is unavailable. KageMichi’s second-title status and a reviewed resume remain unresolved. Do not infer employment end dates from the last supplied commit date.

Recruiter review follow-up: removed public employment TODOs; omitted the unknown second-title status and hide the resume action until a reviewed asset is supplied. The user later supplied the employment periods now shown in `PortfolioData.experience`. Outstanding facts remain in this internal document. Grounds now leads with a contribution summary and story navigation, authentication first. Product-listing capture is smaller; logging screenshots display a focused panel with full originals available in a zoomable dialog. Body text is larger and dark secondary text brighter. Overview and experience copy now describe supported app-update UI/dashboard integration and reliability work without criticality or broad version-management claims. Shadow Hills Manor's technical contribution is unchanged. The approved public Steam store-page capture adds product context only; no proprietary game media or additional architectural claim was added.

Shadow Hills Manor clarification: Hamza confirmed save/load as the primary requirement, covering inventory, stats, player position and other essential game state. GameInstance combined directly held persistent state with coordination of separate systems. The story now states this explicitly; which individual values lived where, serialization and subsystem interfaces remain unspecified.

Simplified reading flow: Grounds overview now links to four standalone, directly addressable engineering story pages. Detailed content, conceptual authentication diagram and original logging screenshots are retained in those stories. Removed the store-page capture from the overview reading flow. Shadow Hills Manor is condensed to need, architecture, save/load and maintainability, contribution and reflection, followed by official trailers. No new technical claims added.

Odds & Edges added as a released KageMichi Dev game jam project. Hamza confirmed he is Scapegoat0442, the game designer and producer responsible for creative direction, and that the team participated as KageMichi Dev. Public source: https://lucasananin.itch.io/odds-edges (credits: lucasananin programming/art, Lucy music/audio, Scapegoat0442 Lead; Unity; released; HTML5 and Windows; DTJ36 #20). No programming contribution, specific design mechanics, metrics or learning reflection inferred. Added playable link and work-history project link.

Odds & Edges GDD read via Google Drive: https://docs.google.com/document/d/1en9uOjG0pXXL9KM5cxF-nrwG9tM4bWZTEz9tUTr8upI/edit . Prototype-stage plan supports Scapegoat as lead/designer responsible for game design, scope management and documentation; lucasananin also listed as co-designer/lead programmer. Design intent: slash/blunt/pierce with dynamic hit chances; three-tier feature scope. Hamza explicitly corrected final art to pure 2D, overriding initial GDD 3D plans. Public overview describes proposed mechanics as GDD intent rather than verified shipped mechanics. Do not infer jam schedule execution, exact balance, final wave/win conditions or sole design authorship. GDD link kept internal; sharing settings unchanged.

Odds & Edges media: captured actual Unity canvas screenshots from the public itch.io browser build (instructions and combat after a slash, showing 60%/100%/100% odds). No generated artwork. Playable source read directly from the public page data-iframe: https://html-classic.itch.zone/html/15835563/index.html?v=1784027018 . The public /embed endpoint supplies the purchase/link widget, so the game uses the published hosted HTML5 build with click-to-load and a separate itch.io link. Future upload changes may require refreshing this source URL. Screenshots enlarge in a dialog; no game requests before clicking Play here.

Embed verification: direct html-classic source redirected to itch.io embed-hotlink protection from the portfolio. Switched to the supported playable endpoint https://itch.io/embed-upload/15835563?color=141412, verified it loads the actual hosted Unity frame. No referrer spoofing or bypass used.
