# Claude Code Instructions for dotfiles

## This Repo

Personal dotfiles and global agent system configuration.

Key areas:
- `claude/` — global Claude Code config (`CLAUDE.md`, `settings.json`, `statusline-command.sh`)
- `agents/src/` — agent prompt source files (edit these, not `agents/commands/`)
- `agents/commands/` — built prompts, symlinked to `~/.claude/commands/` (generated, do not edit)

## Updating Agent Prompts

1. Edit source files in `agents/src/`: `_core.md`, `_implement.md`, `_implementation-manager.md`
2. Retired agents are in `agents/src/archive/`
3. Run `./build_prompts.sh` to regenerate `agents/commands/` and `gemini/commands/`
4. Verify output in `agents/commands/`
5. Update `agents/meta/status.md` with a refinement summary

**Never edit `agents/commands/` directly — those files are generated.**

## Installation

`./install.sh` symlinks everything to the correct locations:
- `claude/CLAUDE.md` → `~/.claude/CLAUDE.md`
- `claude/settings.json` → `~/.claude/settings.json`
- `agents/commands/` → `~/.claude/commands/`

Run after any structural changes to verify installation still works.

## Principles

- Simplicity wins — if a prompt is too long, it's a bug
- Test agent prompt changes on real projects before committing
- REWRITE docs, don't append
