# Project

## Verified identity and purpose

The repository/package is named `godam` and contains a Flutter application scaffold (`pubspec.yaml`). The README and package description still call it a new Flutter project.

The Figma page [Godam UI/UX](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=318-177) depicts a mobile app for managing a warehouse/shop, including inventory, sales, expenses, and profit. This purpose is evidenced by the design copy and screen labels; it is not a separate product requirements brief. Target user roles and formal business requirements remain unknown.

See [`DESIGN_SPEC.md`](DESIGN_SPEC.md) for frame references, verified design details, visual estimates, and unresolved Figma questions.

## Requirements and scope

- Confirmed repository task: provide maintainable project documentation and agent continuity guidance (the user-provided task on 2026-11-01).
- Confirmed design scope: Figma frames for splash, onboarding, registration, dashboard, inventory, expenses, sales, empty states, menu, and new-item entry.
- Implemented product requirements in code: none beyond the Flutter counter starter.
- Business rules, data contracts, backend, persistence, account/auth behavior, accessibility requirements, and release targets: unknown.

## Platforms and constraints

Flutter platform scaffold directories are present for Android, iOS, web, Linux, macOS, and Windows. Their presence does not establish which platforms are supported or intended for release. Confirm target platforms before making platform-specific product assumptions.

The package constraint is Dart SDK `^3.13.7`; current declared runtime dependency is Flutter SDK, with `cupertino_icons`. Development dependencies are `flutter_test` and `flutter_lints`. See [`ARCHITECTURE.md`](ARCHITECTURE.md) for implementation evidence and [`CURRENT_STATE.md`](CURRENT_STATE.md) for limitations.

## Open questions

1. Who are the target users, and what formal product requirements/acceptance criteria apply?
2. Which platforms are intended, and what backend, persistence, accessibility, or regulatory constraints apply?
3. What locale and date/number/currency formatting rules are required?
