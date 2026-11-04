# Session handoff

**Updated:** 2026-11-04
**Task:** Implement the four reference empty states and functional Home / Inventory / Expenses / Sales tab navigation. The original Home-only handoff below is retained as history; current task status follows it.

## Previous Home-only handoff (historical)

The Home Empty State screen has been reconstructed using native Flutter widgets matching the reference SVG down to layout order, exact Persian copy, RTL element positioning, and design tokens:
1. **Header Layout (RTL alignment):**
   - In RTL, the start of the row is on the screen's right edge. The Hamburger menu (3 horizontal teal lines) is at the start (right edge, matching `x=340..358`).
   - The Notification bell (36×36 circular `#E6F5F5` container with `#004D4D` bell icon) is at the end (left edge, matching `x=32..68`).
2. **Body Hierarchy and Exact Copy:**
   - Decorative illustration: `assets/ScreenShots/illustrations/h_empty_img.svg` (width: 224, height: 214).
   - Headline: "هنوز آیتمی وجود ندارد" (`#1C1A15`, Kalameh Bold, 18px) positioned above the subtitle.
   - Subtitle: "برای شروع یک جنس جدید ثبت کنید یا از طریق خریداری وارد کنید" (`#645F50`, Kalameh Regular, 13px, single-line centered) positioned below headline.
   - CTA button: 159×50, corner radius 16, fill `#008081`. In RTL, text "افزودن جنس" (Kalameh SemiBold, 15px, white) is positioned on the right and the plus icon (`+`, white) is on the left.
3. **Bottom Navigation Pill (Floating Nav):**
   - Dimensions: 252×56, corner radius 28, fill `#E6F5F5`, border `#99D6D6` (width 1).
   - Four tabs in RTL order (from right to left):
     - Tab 0: "خانه" (Home) — active tab indicator pill (`#99D6D6`, 64×48, r=24), active icon and text `#006667`.
     - Tab 1: "گدام" (Godam / Inventory) — inactive icon and text `#008081`.
     - Tab 2: "مصارف" (Expenses) — inactive icon and text `#008081`.
     - Tab 3: "خریداری" (Purchases) — inactive icon and text `#008081`.

## Previous modified files (historical)

- `lib/screens/home_screen.dart`
- `pubspec.yaml`
- `docs/SESSION_HANDOFF.md`

## Cross-cutting verification follow-up — 2026-11-04

- Splash loader now runs concurrently with optional startup work, completes in 1.8 seconds, remains full until startup work completes, and requests a frame before its post-frame onboarding route replacement. The existing 2500 ms minimum Splash time still applies.
- The registration widget test supplies the `/home` route and verifies its current route after valid submission; route lookup uses `HomeScreen.routeName`.
- The existing Home screen's CTA and bottom-navigation labels now scale down within their allotted space to prevent RenderFlex overflows when the registration destination is rendered.
- `flutter test --no-pub` passed all 14 tests. `flutter analyze --no-pub` reported no issues. Dart formatting completed with no pending changes.

## Previous next-safe-action note

The earlier implementation order below is historical; Inventory, Expenses and Sales empty states are now part of the current Home shell. Do not commit or push without explicit authorization.

## Latest task status — four empty-state tabs

- **Changed for this task:** `lib/screens/home_screen.dart`, new `lib/screens/empty_state_page.dart`, `test/widget_test.dart`, `docs/ARCHITECTURE.md`, `docs/DESIGN_SPEC.md`, `docs/CURRENT_STATE.md`, and `docs/ROADMAP.md`.
- **Implementation:** Home route hosts four responsive empty-state views in an `IndexedStack`; local dedicated illustrations and exact visible copy are mapped in `DESIGN_SPEC.md`. Bottom tab navigation selects the matching view in RTL order. Menu, notification and CTA destinations remain unknown and unwired.
- **Pre-existing user changes:** Preserve all previously dirty files, including the existing Splash/onboarding/registration implementation and documentation edits. Do not reset or clean those changes.
- **Temporary previews:** Generated files `test/_svg_preview_test.dart`, `test/_empty_state_previews/`, and `.tmp_empty_state_preview/` were removed after inspection.
- **Checks:** `dart format lib/screens/home_screen.dart lib/screens/empty_state_page.dart test/widget_test.dart` completed; `flutter test --no-pub` passed all 16 tests; `flutter analyze --no-pub` reported no issues; `git diff --check` passed. The first test attempt caught an incompatible ButtonStyle constructor property; it was fixed using the SDK-compatible `FilledButton.styleFrom` before the successful suite.
- **Next safe action:** If requested, implement populated Home, Inventory, Expenses and Sales screens from their own references. Confirm destination requirements before connecting the empty-state CTAs or the header menu/notification. Compare on emulator when available. Do not commit or push.
