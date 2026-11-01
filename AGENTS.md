# Agent entry point

Before changing code, read this file and the relevant sections of [`docs/PROJECT.md`](docs/PROJECT.md), [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md), [`docs/DESIGN_SPEC.md`](docs/DESIGN_SPEC.md), [`docs/CURRENT_STATE.md`](docs/CURRENT_STATE.md), [`docs/DECISIONS.md`](docs/DECISIONS.md), or [`docs/ROADMAP.md`](docs/ROADMAP.md). `docs/DESIGN_SYSTEM.md` points to the design source of truth. Treat any architecture labeled proposed or approval-pending as unapproved. Use [the continuity skill](.agents/skills/flutter-project-continuity/SKILL.md) for repository work and interrupted-task recovery.

## Engineering workflow

- Inspect `git status`, staged changes, recent commits, relevant code/tests, and dependencies before editing. Preserve all pre-existing changes.
- Verify material documentation claims against the repository. Confirm task scope, risks, dependencies, and acceptance criteria before implementation; record unknowns rather than guessing.
- Follow the existing Flutter/Dart conventions. Make the smallest coherent change; avoid unrelated refactors, speculative features, and new dependencies without a demonstrated need.
- Add or update focused tests where appropriate. Never conceal failures or claim unverified behavior works. Do not commit secrets, credentials, generated build output, or local environment files.
- For long tasks, work in independently verifiable milestones. Inspect staged changes before any commit. Commit only when authorized by the user or project policy; never push without authorization. Preserve incomplete work.
- Before completion, format changed Dart files, run `flutter analyze` and relevant `flutter test` checks, plus any checks required by the change. Review the final diff and investigate regressions. Do not report checks that were not run.
- If interrupted, update [`docs/SESSION_HANDOFF.md`](docs/SESSION_HANDOFF.md) with the current task, committed and uncommitted work, checks and failures, risks, exact paths/commands, and the next safe action. Keep it an actionable snapshot, not a transcript.
- Update project documentation when implementation, decisions, or project status materially changes. At completion, report changes, verification, failures, and remaining work.

## Repository checks

Run from the repository root:

```sh
dart format <changed-dart-files>
flutter analyze
flutter test
```

Choose relevant checks for the change; do not run unrelated platform builds by default.
