# Roadmap

This roadmap is a proposal derived from the design. Completed user-authorized screen work is listed separately from remaining proposed milestones. Confirm open items in [`DESIGN_SPEC.md`](DESIGN_SPEC.md) and review pending decisions in [`DECISIONS.md`](DECISIONS.md).

## Confirmed

### Empty-state Home shell and tab navigation — implemented 2026-11-04

- **Scope:** Implement the four supplied empty-state frames and right-to-left tab switching within the existing Home route.
- **Dependencies:** Local full-frame and illustration SVG references; `flutter_svg` and Kalameh were already declared.
- **Acceptance:** Each of Home, Inventory, Expenses, and Sales renders its frame-specific copy/artwork; the selected tab matches the rendered page; compact and tall viewports avoid layout exceptions. CTA destinations and header-control behavior remain outside this milestone pending evidence.
- **Status:** Implemented and verified with 16 widget tests and static analysis. Emulator screenshot comparison remains outstanding. Populated tabs and CTA destinations are not included.

### Establish repository continuity guidance — completed 2026-11-01

- **Acceptance criteria:** Root agent instructions, factual project/architecture/design/current-state/decision/roadmap/handoff documents, and a reusable Flutter project continuity skill are present and cross-linked.
- **Evidence:** Files in `AGENTS.md`, `docs/`, and `.agents/skills/flutter-project-continuity/`.

### Figma design analysis — completed as analysis, 2026-11-01

- **Acceptance:** Page hierarchy and screen contexts inspected; a blueprint with verified facts, estimates, and unresolved Figma details recorded in `DESIGN_SPEC.md`.
- **Limitations:** Prototype reactions and individual screenshot review were unavailable after the Figma MCP Starter-plan call limit; detailed context for `3_Onboard` and `07 New_item` is incomplete.

### Splash, onboarding and native registration screen — implemented in source, verification pending

- **Scope:** Responsive Splash-to-onboarding startup, independently implemented onboarding page files, and a native registration form using the local illustration asset.
- **Acceptance:** Startup explicitly begins at Splash and waits for finite progress plus optional initialization; all onboarding pages use the integrated animated teal/cream background; responsive layouts use system safe areas and can scroll; Next, Back, Skip, Finish, swipe, form validation, consent checkbox, terms link, and Start feedback work.
- **Verification status:** Focused tests cover the flow and controls. Run formatting, analysis, tests and runtime checks on two viewport sizes; emulator validation remains outstanding.

## Proposed implementation sequence — approval required

### 0. Close design and product unknowns

- **Dependencies:** Figma access for missing frames and prototype data; product-owner confirmation of locale, viewport/platform, and functional scope.
- **Acceptance:** Exact copy/assets for `344:2011` and `656:490`, prototype transition map, font files/licensing, RTL/formatting rules, scrolling, and target Android viewport are documented.

### 1. Build Flutter foundation and shared design layer

- **Dependencies:** Milestone 0; approval of proposed architecture in `ARCHITECTURE.md`.
- **Acceptance:** App theme reflects confirmed tokens/fonts; RTL and safe-area handling are correct; shared components match repeated design patterns; app responds at agreed sizes.

### 2. Implement entry screens

- **Dependencies:** Foundation and confirmed onboarding transitions/assets.
- **Acceptance:** Splash, onboarding and registration match Figma copy, layout, typography and exact local assets; only confirmed interactions are wired.

### 3. Implement main shell and menu

- **Dependencies:** Foundation and prototype confirmation for tabs/menu.
- **Acceptance:** Four-tab navigation, active-tab visuals, header controls and menu overlay match the design and verified behavior.

### 4. Implement populated Home, Inventory, Expense and Sell screens

- **Dependencies:** Shared shell, exact assets/fonts, confirmed sample-data and scroll behavior.
- **Acceptance:** Hierarchy, charts, summary cards, filters, inventory rows, transactions and status colors match respective frames; overflow behaves as specified.

### 5. Implement empty states and New Item

- **Dependencies:** Shared shell, exact empty-state assets, detailed `656:490` context, and confirmed CTA destinations/form rules.
- **Acceptance:** Each empty state uses its own exact illustration/copy; New Item fields, validation and save behavior match confirmed requirements.

### 6. Verify the Android experience

- **Dependencies:** Implemented screens and available Android emulator matching the approved viewport.
- **Acceptance:** `dart format`, `flutter analyze`, focused widget tests and screenshot comparisons at agreed sizes pass; assets resolve locally and match their Figma placements.

## Not committed to this roadmap

Backend integration, persistence, authentication rules, analytics, platform expansion and production data behavior are not defined by the frames and remain out of scope until requirements are confirmed.
