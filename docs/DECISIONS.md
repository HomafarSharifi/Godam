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
- **Decision:** The Splash progress runs once to completion (1.8 s) alongside an optional startup future, remains full while that future is pending, and navigates only after progress, startup work, and a 2500 ms minimum display interval complete. With no startup future, it still advances automatically. Startup errors currently release the gate and continue to onboarding.
- **Rationale:** Coordinate the visible loader with initialization and prevent an endless Splash when the app has no startup task.
- **Consequence:** Progress is visual and does not report a real data percentage. Error recovery is not specified.

## 2026-11-02 — Responsive onboarding and navigation

- **Status:** Implemented per user instruction; the later page-separation decision below supersedes its initial screen/background implementation. Final verification is pending.
- **Decision:** The initial implementation used a responsive three-slide `PageView`, native Next/Back/Skip/Finish controls, RTL content, and the custom-painted teal/cream animated boundary on slides one and two. It used the supplied individual illustration SVGs without cropping full-screen reference exports. Finish/Skip opened the local registration design; its back hit target returns to onboarding.
- **Rationale:** Satisfy requested onboarding behavior and small-screen support while preserving the supplied artwork and keeping the moving color transition within the frame background.
- **Consequence:** These transitions are implementation choices requested for the app flow, not verified Figma prototype reactions. At this decision's original milestone, `/register` was a visual-only preview; that implementation has been superseded by the native form decision below. The earlier choice to show the solid teal third-page background was later superseded by the request to use the animated teal/cream frame consistently on all three pages. Emulator verification remains outstanding.

## 2026-11-02 — Separate onboarding pages and native registration form

- **Status:** Implemented per user instruction; verification pending.
- **Decision:** Keep `OnboardingScreen` as the PageView/navigation owner, move each page into its own Dart file, and reuse a shared slide layout. Paint the animated teal/cream background on every slide. Implement registration fields, consent checkbox, terms link, and start action as native widgets, using the supplied `fo_onbrd_img.svg` illustration.
- **Rationale:** Make page edits independent, fix the third page's missing light section, and replace the static registration screenshot with functional Flutter controls.
- **Consequence:** Start validates the local form and consent but cannot create an account because authentication/backend behavior and the legal terms text are not supplied. A visible message states the service is not connected. The terms link explains that its body is unavailable.

## 2026-11-02 — Explicit Splash initial route

- **Status:** Implemented per high-priority user instruction; verification pending.
- **Decision:** Set `/` as `MaterialApp.initialRoute` and map it directly to `SplashScreen`; keep the one-pass loader gate before replacing Splash with onboarding.
- **Rationale:** Make the intended cold-start entry unambiguous while ensuring the loading animation can finish before the route changes.
- **Consequence:** With no startup future the loader completes after its configured 1.8 second animation; when supplied, the bar stays full until startup work finishes.
