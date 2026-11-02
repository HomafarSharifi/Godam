# Current state

**Updated:** 2026-11-02. Repository snapshot: branch `main`, HEAD is `c7f1539 Implement splash screen UI`. The local screen SVG bundle is untracked user input. Preserve it and all other changes.

## Implemented

- Splash screen based on Figma frame `318:200` and onboarding based on local `1_Onboard.svg`, `2_Onboard.svg`, and `3_Onboard.svg`; see [`DESIGN_SPEC.md`](DESIGN_SPEC.md), `lib/screens/splash_screen.dart`, and `lib/screens/onboarding_screen.dart`.
- The themed Material app retains Splash as home; onboarding is available via named route `/onboarding` (`lib/main.dart`).
- Splash uses a finite single-pass progress indicator and waits for its completion, optional startup work, and a 900 ms minimum display interval before replacing itself with onboarding.
- Onboarding uses responsive SafeArea/scrolling layout and a three-page PageView with exact separate illustration assets. Its custom-painted backdrop includes the moving teal/cream boundary (no crop or foreground divider); reduced-motion preferences are honored.
- Onboarding Next, Back, Skip, Finish, and swipe controls are wired. Skip and Finish open `/register`; registration displays the supplied full-frame SVG with a working back hit target, while its form interactions remain unimplemented.
- Added the exact available Splash vector exports under `assets/figma/splash/`, registered the asset directory, and declared `flutter_svg` for rendering these SVGs.
- Registered Kalameh Light (300) and SemiBold (600) from the user-provided TTF assets and applied them to the Splash text.
- Replaced the static loading SVG in the screen with `AppleLinearProgress` (`lib/widgets/apple_linear_progress.dart`), in a centered 173 × 6 slot and colored from the theme primary. It retains the manually adjusted Splash text and tracks an optional startup `Future<void>`.
- Replaced the starter counter test with a Splash rendering/widget-structure test (`test/widget_test.dart`).
- Flutter platform scaffolding exists for Android, iOS, web, Linux, macOS, and Windows.
- Continuity documentation exists in the repository root `AGENTS.md`, `docs/`, and `.agents/skills/flutter-project-continuity/SKILL.md`.
- Kalameh TTF files and license documents are present in the repository. Confirm rights for redistribution in the shipped application.

## Completed analysis

- Re-read the page hierarchy for Figma page `318:177` and retrieved child design context for most frames; see [`DESIGN_SPEC.md`](DESIGN_SPEC.md).
- Recorded screen IDs/dimensions, returned design tokens and typography, asset categories, RTL evidence, proposed architecture, and implementation sequence.
- Figma analysis is complete as a blueprint milestone, not complete frame-level verification. Prototype reactions and individual screenshot checks were not retrieved; detailed context for `3_Onboard` (`344:2011`) and `07 New_item` (`656:490`) remains missing after the Figma MCP Starter-plan call limit.

## Verification and limitations

- Local Flutter 3.47.9 / Dart 3.13.7 SDK was found and `flutter pub get --offline` succeeded.
- The earlier expanded test run passed responsive layout and basic onboarding rendering but exposed failures in startup gating and Next/Back/swipe assertions. Follow-up code and tests address those findings, but the latest test run was not permitted by the command approval review. Do not treat the fixes as runtime-verified.
- Latest direct `dart analyze` reported `No issues found!` on the source, then exited nonzero because it could not update the user-profile analytics file. The Flutter wrapper `flutter analyze` was not rerun after the latest changes.
- `dart format` was run on changed Dart files and reported no pending formatting changes; its process then exited with a permission error updating the user-profile analytics file.
- The onboarding SVGs were rendered locally using installed Chrome and a temporary Flutter golden-preview test, then visually inspected. Temporary test/golden files were removed. A Flutter app runtime comparison was not completed.
- Pixel_7 was listed as an available emulator, but the request to launch it was rejected by the permission review. The app was not launched on the emulator.
- Figma's exact-frame screenshot endpoint could not be re-queried due the MCP Starter-plan limit. Positioning follows the previously retrieved exact frame context, not a whole-page screenshot.
- Figma prototype transitions remain unverified; the implemented Skip/Back/Next/Finish destinations follow the explicit app-flow request, not retrieved prototype evidence.
- [`ARCHITECTURE.md`](ARCHITECTURE.md) records current code plus a separate pending architecture proposal; other product screens and backend behavior remain unimplemented.

## Next action

When command approval allows it, rerun `flutter analyze` and `flutter test`, address any remaining failures, then launch the app on two emulator sizes and compare Splash/onboarding against the local SVG references. Confirm Kalameh redistribution rights before release. Preserve current untracked SVGs and do not commit or push without authorization.
