---
name: flutter-project-continuity
description: Use when inspecting, implementing, verifying, or handing off work in this Flutter/Dart repository so changes follow the actual project architecture and remain recoverable across sessions.
---

# Flutter project continuity

## When to use

Use for repository tasks involving project inspection, Flutter/Dart implementation, verification, recovery after interruption, or updating project knowledge. The root `AGENTS.md` is the concise entry point; this skill supplies the task workflow.

## Required inputs

- The user request and its acceptance criteria; clarify material ambiguity where it cannot be resolved from repository evidence.
- The repository checkout and current Git state.
- Relevant project documentation and implementation/tests for the requested area.
- Available Flutter/Dart tooling for the checks appropriate to the change.

## Procedure

### 1. Establish context and baseline

1. Read root `AGENTS.md` and only the relevant project docs. For broad product or architecture work, consult `docs/PROJECT.md`, `docs/ARCHITECTURE.md`, `docs/DESIGN_SYSTEM.md`, `docs/CURRENT_STATE.md`, `docs/DECISIONS.md`, and `docs/ROADMAP.md` as applicable.
2. Inspect `git status` including staged changes, current branch, and recent commits. Preserve pre-existing user work; never reset, overwrite, or discard it to manufacture a clean baseline.
3. Inspect relevant implementation files, tests, dependencies, and conventions. Verify material claims from docs against source. Treat undocumented behavior and unavailable product/design requirements as unknown.
4. State task scope, risks, dependencies, and acceptance criteria. Identify independently checkable milestones for long tasks.

### 2. Implement narrowly

1. Follow actual project architecture and approved design system; distinguish established practice from a proposal.
2. Make the smallest coherent change that satisfies acceptance criteria. Avoid unrelated refactoring, speculative functionality, duplicate implementations, and dependencies without a concrete need.
3. Add or update focused tests where appropriate. Do not conceal failures or say behavior works without evidence.
4. Keep secrets, credentials, local environment files, and generated build artifacts out of commits. Inspect staged content before any authorized commit. Do not automatically commit or push.

### 3. Verify and review

1. Format changed Dart files with `dart format <changed-dart-files>`.
2. Run `flutter analyze`, relevant `flutter test` targets (or `flutter test` when appropriate), and additional checks required by the change. If tooling or a check is unavailable/fails, record the exact command and outcome; do not imply success.
3. Review `git diff` and status for unintended changes and regressions. Check docs/links when documentation changed.
4. Update durable project docs only when implementation, decisions, or project status materially changes. Keep `docs/CURRENT_STATE.md` evidence-based and `docs/ROADMAP.md` clear about confirmed requirements versus proposals.

### Local SVG preview without a system renderer

- First use an already installed local renderer (for example, Inkscape, `rsvg-convert`, or CairoSVG); do not install a package just to preview an asset.
- If none is available but the app already includes `flutter_svg`, render the local SVG in a temporary focused widget test and inspect its generated golden with the image viewer. This needs no public URL or Computer Use.
- Keep generated previews outside the repository when possible. If Flutter golden tooling writes them into the project, verify the exact generated paths and remove only those temporary files and the temporary test after inspection.
- Do not crop a full-screen reference SVG to use as an illustration when a dedicated illustration asset exists; preserve the complete screen layout in Flutter.

### Multi-screen onboarding and form follow-through

- For a paged onboarding flow, keep the `PageView` and navigation state in one coordinator, and put each authored page's copy/assets in a separate screen/widget file. Share only the repeated layout/control shell.
- Keep full-frame animated backgrounds consistent across pages unless a supplied frame verifies a different variant; test the final page explicitly to catch state-dependent missing regions.
- For a supplied registration SVG, use it as the visual reference, not as the screen widget. Rebuild visible fields, checkboxes, links, and primary actions as native widgets while reusing its dedicated illustration asset. Preserve SVG geometry and copy evidence.
- Keep the Splash route explicit as the app's cold-start route and test both its initial visibility and the completion gate before verifying the destination screen.
- Do not report a registration as complete when a backend/terms destination is absent; provide honest local validation/feedback and document the missing integration.

### 4. Recover or hand off

If work is interrupted or remains incomplete, update `docs/SESSION_HANDOFF.md` with:

- Current task and acceptance criteria.
- Completed and in-progress work with exact file paths.
- What is committed and what remains uncommitted.
- Checks run, failures, and checks still needed, with exact commands.
- Known risks, dependencies, and unresolved questions.
- The next safe action.

Keep this file as the latest actionable snapshot, not a chat transcript. Do not claim a change is recoverable from a commit unless it was committed.

## Completion criteria

- Acceptance criteria are met, or remaining work and blocker are explicit.
- Appropriate formatting, analysis, tests, and additional checks have been run and accurately reported.
- Final diff/status were reviewed and no unrelated user work was lost.
- Material project documentation and the handoff reflect the resulting state.
- Final report states what changed, what was verified, what failed, and what remains; generated code alone is not proof of feature completion.
