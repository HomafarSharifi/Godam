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

- **Status:** Initial behavior superseded by the 2026-11-02 completion decision below.
- **Decision:** Use the repository's Kalameh Light and SemiBold TTF files for the Splash copy and the user's Apple-style progress widget below the subtitle, with theme primary fill.
- **Rationale:** Use supplied font assets and avoid presenting a static loading SVG as an active loader.
- **Consequence:** Confirm the included font license permits redistribution before release.

## 2026-11-02 — Splash completion and onboarding entry

- **Status:** Implemented per user instruction.
- **Decision:** The Splash progress runs once to completion (1.8 s), remains full while an optional startup future is pending, and navigates only after progress, startup work, and a 900 ms minimum display interval complete. With no startup future, it still advances automatically. Startup errors currently release the gate and continue to onboarding.
- **Rationale:** Coordinate the visible loader with initialization and prevent an endless Splash when the app has no startup task.
- **Consequence:** Progress is visual and does not report a real data percentage. Error recovery is not specified.

## 2026-11-02 — Responsive onboarding and navigation

- **Status:** Implemented per user instruction; final verification pending.
- **Decision:** Use a responsive three-slide `PageView`, native Next/Back/Skip/Finish controls, RTL content, and a custom-painted full-frame teal/cream background with an animated boundary on slides one and two. Use the supplied individual illustration SVGs without cropping full-screen reference exports. Finish/Skip open the local registration design; its back hit target returns to onboarding.
- **Rationale:** Satisfy requested onboarding behavior and small-screen support while preserving the supplied artwork and keeping the moving color transition within the frame background.
- **Consequence:** These transitions are implementation choices requested for the app flow, not verified Figma prototype reactions. `/register` is currently an image-based design preview; editable fields, validation, and submission are not implemented. Emulator verification remains outstanding.
