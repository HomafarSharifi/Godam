# Architecture

## Implemented architecture

- `lib/main.dart` calls `runApp`, configures the Material theme, and shows `SplashScreen` from `lib/screens/splash_screen.dart`.
- `SplashScreen` draws the exact local Figma decorative SVGs, RTL Kalameh text, and `AppleLinearProgress` from `lib/widgets/apple_linear_progress.dart`, colored from the theme primary. An optional `Future<void>` keeps the loader visible until startup data loading completes; no loading future is supplied by the current app entry point.
- `test/widget_test.dart` checks Splash content/assets, default loader presence, and loader visibility while a pending future completes.
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
