# Superpowers vs Implementation Manager

Switched from homegrown `/implement` + `/implementation-manager` to the superpowers plugin (2026-03-10).

## What Superpowers Replaces

| Homegrown | Superpowers Equivalent |
|---|---|
| `/implement` (4-phase TDD) | `test-driven-development` + `executing-plans` |
| `/implementation-manager` (orchestration) | `subagent-driven-development` + `dispatching-parallel-agents` |
| Ad-hoc planning in main session | `brainstorming` → `writing-plans` (structured, produces spec + plan docs) |
| Manager checks implementor report | Two-stage review: spec compliance + code quality (separate sub-agents) |

## What Superpowers Doesn't Cover

- **`/setup-spec`** and **`/sync-cursor-rules`** — kept as standalone commands
- **Cross-tool portability** — superpowers is Claude Code only (old system worked with Gemini, Codex)
- **Context budget hard stops** (40%/60%) — not enforced by superpowers
- **Proof-required testing** ("paste actual output") — superpowers `verification-before-completion` is similar but less strict

## Key Gap: Session Resilience

The old system wrote progress to `manager-progress.md` so new sessions could resume. Superpowers tracks progress via `TodoWrite` (in-memory, lost on session crash).

What survives a crash: plan file (`docs/superpowers/plans/...`), spec doc, git commits.
What's lost: TodoWrite state, in-flight sub-agent work.
Recovery: read the plan, check git log, manually determine where to resume.

For features that fit in one session this is fine. For multi-day work, the lack of persistent progress tracking is a real gap.

## Superpowers Workflow

1. Describe what you want → `brainstorming` (questions, approaches, design approval)
2. Design doc saved to `docs/superpowers/specs/YYYY-MM-DD-<name>-design.md`
3. `writing-plans` produces `docs/superpowers/plans/YYYY-MM-DD-<name>.md`
4. `subagent-driven-development` executes: implementer → spec reviewer → code quality reviewer per task
5. `finishing-a-development-branch` completes (merge, PR, keep, or discard)

## Archived Source Files

Old agent sources in `agents/src/archive/`: `_core.md`, `_implement.md`, `_implementation-manager.md`, plus previously retired `_planning-agent.md`, `_research.md`, `_task-agent.md`.
