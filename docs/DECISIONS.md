# Decisions

Record approved decisions separately from proposals. A proposal is not an implementation instruction until the user approves it.

## 2026-11-01 — Keep documentation factual and preserve the starter architecture

- **Status:** Adopted for documentation.
- **Decision:** Describe the current code as the Flutter counter scaffold and distinguish Figma evidence from implemented behavior and unconfirmed requirements.
- **Rationale:** Source code is still the starter app; the design file contains UI evidence but not a full product requirements or prototype specification.
- **Consequences:** Figma-derived architecture and navigation remain proposals until details are verified and the user approves them.

## Proposed — Feature-oriented Flutter structure and built-in navigation

- **Status:** Pending user approval.
- **Proposal:** Organize screens by feature, extract only evidenced shared UI into reusable widgets, use Flutter's built-in navigation/local state initially, and avoid a state-management package until data flows justify one.
- **Rationale:** Current code has no product architecture or additional dependencies; the design contains related screens and repeated visual patterns.
- **Alternatives considered:** None were documented in Figma. A router/state-management package could be considered later if verified flows or data complexity require it.
- **Consequences if approved:** Establish a modest app/theme/shared/features structure without committing to backend, persistence, or global state design. Route transitions, locale, SVG rendering, fonts, and platform targets remain separate decisions.

## 2026-11-01 — Splash font and loading presentation

- **Status:** Implemented per user instruction.
- **Decision:** Use the repository's Kalameh Light and SemiBold TTF files for the Splash copy. Use the user's Apple-style linear progress widget in a separate file below the subtitle, with the app theme's primary fill color; keep it active by default and let an optional startup `Future<void>` control when it ends.
- **Rationale:** Use the supplied font assets and avoid presenting a static loading SVG as an active loader. Do not invent a minimum display duration or a navigation destination.
- **Consequence:** Confirm the included font license permits redistribution with the application before release. The app entry point currently provides no startup future, so the indicator animates until a later navigation flow is established.
