---
name: unity-development
description: Use when working in a Unity project — covers C# workflow, domain reload, logging, and worktree constraints that override default superpowers behavior
---

# Unity Development

## C# Workflow

1. Do not create `.meta` files — Unity generates these on domain reload.
2. Use `unity-cli` to reload the domain, read logs, run tests, play/stop. Run `/unity` for full usage reference.
3. After editing any `.cs` file, run `unity-cli reload --json` to trigger domain reload and check for compile errors.

## Worktrees

**Git worktrees are not used in Unity projects.** The `using-git-worktrees` step from `subagent-driven-development` does not apply:
- Running a Unity Editor instance per worktree is impractical
- Gitignored credentials (e.g. integration test config) live in the working directory and don't carry to worktrees

**For isolation instead:**
- Single-agent work: implement in the current working directory
- When true isolation is needed: use a separate full clone (credentials and configuration are already present)

## Multi-Task Plans

Use `subagent-driven-development` for multi-task plans — two-stage review (spec compliance then code quality) per task. Skip the worktree setup step.
