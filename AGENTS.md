# Agent Instructions for Dotfiles Repository

## This Repo

Personal dotfiles and global agent system. The agent prompt system is the main area to be careful with.

## Updating Agent Prompts

1. Edit source files in `agents/src/`: `_core.md`, `_implement.md`, `_implementation-manager.md`
2. Retired agents are in `agents/src/archive/`
3. Run `./build_prompts.sh` — regenerates `agents/commands/*.md` and `gemini/commands/*.toml`
4. Verify output in `agents/commands/`
5. Update `agents/meta/status.md`

**Never edit `agents/commands/` directly — they are generated.**

## File Structure

| Path | Purpose |
|------|---------|
| `claude/CLAUDE.md` | Global Claude instructions (symlinked to `~/.claude/CLAUDE.md`) |
| `agents/src/` | Agent prompt source files |
| `agents/commands/` | Built prompts (generated) |
| `agents/src/archive/` | Retired agent prompts |
| `gemini/commands/` | Generated Gemini TOML files |

## Installation

`./install.sh` symlinks all config to correct locations. Run after structural changes.

## Context Budget

40-50% wrap up. 60% hard stop.
