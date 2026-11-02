# Current state

**Updated:** 2026-11-02. Repository snapshot: branch `main`, HEAD is `841dd38 Implement onboarding screens`. The supplied screen SVG bundle is tracked project input. Preserve it and all other changes.

## Implemented

- Splash screen based on Figma frame `318:200` and onboarding based on local `1_Onboard.svg`, `2_Onboard.svg`, and `3_Onboard.svg`; see [`DESIGN_SPEC.md`](DESIGN_SPEC.md), `lib/screens/splash_screen.dart`, and `lib/screens/onboarding/`.
- The app explicitly starts with Splash at `/`; it replaces itself with onboarding at `/onboarding` after the loading gate completes (`lib/main.dart`).
- Splash uses a finite single-pass progress indicator and waits for its completion, optional startup work, and a 900 ms minimum display interval before replacing itself with onboarding.
- Onboarding uses responsive SafeArea/scrolling layout and a three-page PageView with each page in a separate Dart file and exact separate illustration assets. Its custom-painted backdrop includes the moving teal/cream boundary on all three pages (no crop or foreground divider); reduced-motion preferences are honored. The text group was moved slightly upward.
- Onboarding Next, Back, Skip, Finish, and swipe controls are wired. Skip and Finish open `/register`. Registration now uses native Flutter fields, checkbox, terms link and start button, plus the supplied `fo_onbrd_img.svg`; field/consent validation and honest disconnected-service feedback are implemented. No authentication or persistence is present.
- Added the exact available Splash vector exports under `assets/figma/splash/`, registered the asset directory, and declared `flutter_svg` for rendering these SVGs.
- Registered Kalameh Light (300) and SemiBold (600) from the user-provided TTF assets and applied them to the Splash text.
- Replaced the static loading SVG in the screen with `AppleLinearProgress` (`lib/widgets/apple_linear_progress.dart`), in a centered 173 × 6 slot and colored from the theme primary. It retains the manually adjusted Splash text and tracks an optional startup `Future<void>`.
- Expanded the starter test suite with Splash, onboarding flow, responsive layout and registration interaction coverage (`test/widget_test.dart`).
- Flutter platform scaffolding exists for Android, iOS, web, Linux, macOS, and Windows.
- Continuity documentation exists in the repository root `AGENTS.md`, `docs/`, and `.agents/skills/flutter-project-continuity/SKILL.md`.
- Kalameh TTF files and license documents are present in the repository. Confirm rights for redistribution in the shipped application.

## Completed analysis

- Re-read the page hierarchy for Figma page `318:177` and retrieved child design context for most frames; see [`DESIGN_SPEC.md`](DESIGN_SPEC.md).
- Recorded screen IDs/dimensions, returned design tokens and typography, asset categories, RTL evidence, proposed architecture, and implementation sequence.
- Figma analysis is complete as a blueprint milestone, not complete frame-level verification. Prototype reactions and individual screenshot checks were not retrieved; detailed context for `3_Onboard` (`344:2011`) and `07 New_item` (`656:490`) remains missing after the Figma MCP Starter-plan call limit.

## Verification and limitations

- Figma Register context retrieval was attempted for node `345:2117` but the Figma MCP Starter-plan call limit prevented the request. The local `Register.svg` was rendered with local headless Chrome and used to verify the visible labels, arrangement, colors, field/button geometry, and `fo_onbrd_img.svg` dimensions. Runtime screenshot comparison remains outstanding.

- Local Flutter 3.47.9 / Dart 3.13.7 SDK was found and `flutter pub get --offline` succeeded.
- The widget tests cover initial Splash visibility, Splash-to-onboarding completion, all onboarding pages/background/navigation, registration validation/consent/terms, and compact/tall viewport layouts. A user-run full suite reported two test failures: the Finish case expected an obsolete SVG semantics label, and the terms finder tried to match a substring inside combined rich text. The test now checks native registration widgets, and the terms action is a keyed `InkWell` in a responsive `Wrap`. The focused Flutter rerun in this environment produced no output and was interrupted; direct `dart test` could not resolve `flutter_lints` because the network socket to `pub.dev` was unavailable. These fixes are not runtime-verified here.
- Latest direct `dart analyze` reported `No issues found!`, then exited nonzero because it could not update the user-profile analytics file. `flutter analyze --no-pub` also remained unresponsive without output and was interrupted.
- `dart format` formatted the changed Dart files and the final pass reported no pending formatting changes; it exits afterward because the user-profile analytics file is inaccessible.
- The onboarding SVGs were rendered locally using installed Chrome and a temporary Flutter golden-preview test, then visually inspected. Temporary test/golden files were removed. A Flutter app runtime comparison was not completed.
- Pixel_7 was listed as an available emulator, but the request to launch it was rejected by the permission review. The app was not launched on the emulator.
- Figma's exact-frame screenshot endpoint could not be re-queried due the MCP Starter-plan limit. Positioning follows the previously retrieved exact frame context, not a whole-page screenshot.
- Figma prototype transitions remain unverified; the implemented Skip/Back/Next/Finish destinations follow the explicit app-flow request, not retrieved prototype evidence.
- [`ARCHITECTURE.md`](ARCHITECTURE.md) records current code plus a separate pending architecture proposal; other product screens and backend behavior remain unimplemented.

## Next action

Diagnose why Flutter CLI commands remain unresponsive in this environment, then rerun `flutter analyze` and `flutter test`, address any failures, and launch Splash/onboarding/registration on two emulator sizes to compare against local SVG references. Confirm Kalameh redistribution rights before release. Preserve user assets and do not commit or push without authorization.
