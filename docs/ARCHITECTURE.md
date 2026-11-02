# Architecture

## Implemented architecture

- `lib/main.dart` calls `runApp`, configures the Material theme, and shows `SplashScreen` from `lib/screens/splash_screen.dart`.
- `lib/main.dart` explicitly starts at `/`, mapped to `SplashScreen`, and exposes `/onboarding` and `/register`. `MyApp.startupLoading` is an optional hook for essential initialization.
- `SplashScreen` uses responsive `SafeArea`/`LayoutBuilder` placement for its exact local decorative SVGs, RTL Kalameh copy, and finite `AppleLinearProgress`. It replaces itself with onboarding only after the progress completes, supplied startup work completes (if any), and a 900 ms minimum display interval elapses. A navigation guard prevents duplicate route changes.
- `OnboardingScreen` owns the responsive three-page `PageView` and navigation state. Each page is a separate widget in `lib/screens/onboarding/`, using `OnboardingSlideFrame` for shared layout, typography and controls. The text group is slightly higher than its prior position. `OnboardingFrameBackground` paints the same animated teal/cream frame for all three pages, including page three.
- `RegistrationScreen` is built from native responsive Flutter text fields, checkbox, terms link, and start button, using the supplied `fo_onbrd_img.svg` illustration. It validates the required fields and consent; valid submission currently reports that the registration service is not connected. Terms copy/content and actual account creation remain unresolved.
- `test/widget_test.dart` covers Splash startup, loading completion, viewport layouts, RTL copy, separate onboarding page content, Next/Back/Skip/Finish and swipe navigation, and registration form interactions.
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
