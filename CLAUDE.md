# Claude Code Instructions for dotfiles

## This Repo

Personal dotfiles and global agent system configuration.

Key areas:
- `claude/` — global Claude Code config (`CLAUDE.md`, `settings.json`, `statusline-command.sh`)
- `skills/` — personal Claude Code skills, deployed to `~/.claude/skills/`
- `agents/commands/` — standalone slash commands (`sync-cursor-rules`)
- `agents/src/archive/` — retired agent prompts replaced by superpowers plugin

## Agent Workflow

Implementation workflows are provided by the **superpowers plugin**. System documentation uses the `system-documentation` personal skill (`~/.claude/skills/system-documentation/`). See `claude/superpowers-vs-implementation-manager.md` for migration context.

Custom commands in `agents/commands/`:
- `/sync-cursor-rules` — sync Claude Code rules to Cursor IDE

## Installation

`./install.sh` copies everything to the correct locations:
- `claude/CLAUDE.md` → `~/.claude/CLAUDE.md`
- `claude/settings.json` → `~/.claude/settings.json`
- `agents/commands/` → `~/.claude/commands/`

Run after any structural changes to verify installation still works.

## Principles

- Simplicity wins — if a prompt is too long, it's a bug
- Test agent prompt changes on real projects before committing
- REWRITE docs, don't append
