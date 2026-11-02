# Architecture

## Implemented architecture

- `lib/main.dart` calls `runApp`, configures the Material theme, and shows `SplashScreen` from `lib/screens/splash_screen.dart`.
- `lib/main.dart` exposes `/onboarding` and `/register`, while keeping Splash as the initial route. `MyApp.startupLoading` is an optional hook for essential initialization.
- `SplashScreen` uses responsive `SafeArea`/`LayoutBuilder` placement for its exact local decorative SVGs, RTL Kalameh copy, and finite `AppleLinearProgress`. It replaces itself with onboarding only after the progress completes, supplied startup work completes (if any), and a 900 ms minimum display interval elapses. A navigation guard prevents duplicate route changes.
- `OnboardingScreen` uses a responsive three-page `PageView`, dedicated illustration SVGs, native copy/control widgets, vertical scrolling for short viewports, and RTL direction. `OnboardingFrameBackground` paints the full teal/cream background as one animated frame; it is not a foreground divider overlay.
- `RegistrationScreen` is the final onboarding destination and displays the provided registration SVG responsively. Its form controls remain a visual reference; native entry/validation/submission are not implemented.
- `test/widget_test.dart` covers loading completion, startup gating, viewport layouts, RTL copy, Next/Back/Skip/Finish and swipe navigation.
- `pubspec.yaml` declares Flutter, `cupertino_icons`, `flutter_svg`, Splash SVG assets, and the Kalameh fonts used by this screen. `flutter_test` and `flutter_lints` are development dependencies.
- `analysis_options.yaml` includes Flutter lints and excludes generated/platform directories.
- Platform scaffolds exist for Android, iOS, web, Linux, macOS, and Windows; target release platforms are unconfirmed.

## Proposed architecture — requires user approval

This is a proposal based on the Figma page, not implemented code or an approved project convention. Design evidence and gaps are in [`DESIGN_SPEC.md`](DESIGN_SPEC.md).

```text
lib/
  main.dart
  app/
    godam_app.dart
    app_shell.dart
  theme/
    app_theme.dart
    app_colors.dart
    app_typography.dart
  shared/widgets/
    app_header.dart
    bottom_navigation.dart
    primary_button.dart
    form_field.dart
    period_selector.dart
    summary_card.dart
    empty_state.dart
  features/
    onboarding/     # splash, onboarding, registration
    home/            # dashboard and menu overlay
    inventory/       # inventory and new-item form
    expenses/
    sales/
assets/
  fonts/
  illustrations/
  icons/
test/widgets/
```

### Proposed technical choices

- Keep `main.dart` as entry point and place app configuration in `GodamApp`; organize screens by feature. Extract a shared widget only where repeated design evidence supports it.
- Use Flutter's built-in navigation and local widget state initially. Confirm prototype connections before fixing transitions or deciding whether tabs preserve screen state. No state-management or routing package is currently justified.
- Apply RTL direction at app/screen level, with explicit direction for mixed-direction text, numbers, and icons where needed. Confirm product locale and date/number rules before adding localization infrastructure.
- Define theme colors and text styles from [`DESIGN_SPEC.md`](DESIGN_SPEC.md). Obtain font files and verify licensing before registering them.
- Export exact Figma assets locally. Choose raster or SVG rendering after inspecting exports; add an SVG package only if retaining SVG assets is necessary for fidelity and scale.
- Use responsive Flutter layout and safe areas, not a direct translation of absolute Figma coordinates. Confirm scroll behavior, especially for the 393 × 1039 Home frame.

### Decisions that remain open

Architecture, route map, supported platforms, locale, state/data boundaries, persistence/backend, font bundling, and SVG strategy require confirmation or further evidence. See [`DECISIONS.md`](DECISIONS.md).

## Conventions evidenced by current code

The starter uses Flutter Material widgets and a single stateful counter screen. It establishes no feature folder layout, reusable product widgets, navigation convention, dependency injection, or app-level state-management pattern.
