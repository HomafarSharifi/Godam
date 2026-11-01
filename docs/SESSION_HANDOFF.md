# Session handoff

**Updated:** 2026-11-01
**Task:** Implement and refine the Splash screen for Figma frame `318:200`.

## Status

The design blueprint is recorded in `docs/DESIGN_SPEC.md`. Splash uses user-provided Kalameh fonts and the separate Apple-style linear progress widget, filled with the theme primary color. Implementation is staged/unstaged and unverified on emulator. Preserve the user's staged work and manual Splash positioning edits.

## Changes

- Replaced the starter counter home with a minimal Material app and `SplashScreen`.
- Added exact Figma SVG exports `pattern-1.svg`, `ellipse-3.svg`, and `loading-default.svg` in `assets/figma/splash/`.
- Added `flutter_svg` and asset declaration; replaced counter widget test with a Splash structure/render test.
- Registered the user-provided Kalameh TTF weights, aligned the custom animated progress bar 12 px below the text, made it respect reduced-motion settings, and added widget tests for its spacing and pending-data duration.
- Replaced the three-circle painter with the supplied `AppleLinearProgress` in `lib/widgets/apple_linear_progress.dart`, sized 173 × 6 in the same centered loader slot, with theme primary fill and data-future visibility behavior.
- Updated design, architecture, decision, current-state and handoff documentation to reflect the refinement.
- Updated `docs/CURRENT_STATE.md` to record implementation and verification status. Private guidance (`AGENTS.md`, `.agents/`) was not modified.

## Checks and open items

- `dart format` formatted the changed Dart sources (latest run: 0 files changed); its process exits nonzero after formatting because it cannot access the Dart analytics session file under the user profile.
- `flutter pub get` failed because the installed SDK is Dart 3.11.1 but `pubspec.yaml` requires `^3.13.7`. Consequently analyzer/tests could not run.
- Figma exact-frame screenshot re-request was blocked by the MCP Starter-plan request limit. This implementation uses previously retrieved exact frame context; runtime comparison is outstanding.
- Android emulator/SDK availability was not confirmed. Kalameh fonts are registered from the supplied repository assets; confirm redistribution rights from the included license documents before release.
- No commit or push was made.

## Next safe action

Use a Dart/Flutter SDK compatible with `^3.13.7`, run `flutter analyze` and `flutter test`, then launch on an Android emulator and compare frame `318:200`. Obtain licensed Kalameh font files for exact typography. Next product milestone is the onboarding screen after this verification and user direction. Do not commit or push without authorization. If interrupted, update this snapshot while preserving the distinction between committed and uncommitted work.
