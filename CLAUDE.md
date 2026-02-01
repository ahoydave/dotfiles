# Agent Instructions

## On Startup
Read `README.md` first to understand repo structure.

## Documentation
Update `README.md` when changes affect user setup or workflow. Keep it:
- Getting started focused (overview, not implementation details)
- Concise (details belong in code or component-specific docs)

## Installation
After adding features, run `./install.sh` to install. Keep install script idempotent.

Install should handle:
- Symlinking dotfiles to proper locations
- All executable scripts in `scripts/`
- Agent commands to `~/.claude/commands`
- Settings to appropriate config directories
