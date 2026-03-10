# Dotfiles

Personal development environment configuration.

## New Machine Setup

See [setup.md](setup.md) for the full from-scratch MacBook setup guide.

## Installation

```bash
git clone https://github.com/ahoydave/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` copies everything to the correct locations (no symlinks). Run it again after any changes.

## Contents

### Shell & Terminal
- `zsh/zshrc` → `~/.zshrc`
- `ghostty/config` → `~/.config/ghostty/config`

### Vim / Neovim
- `vim/vimrc` → `~/.vimrc` — portable, works on any server with plain vim
- `nvim/` → `~/.config/nvim/` — full neovim with LSP, plugins, fuzzy finding

Prerequisites for full setup: `brew install neovim fzf fd ripgrep lazygit pyright typescript-language-server`

See `nvim/README.md` and `nvim/QUICKREF.md` for details.

### Git
- `git/gitconfig` → `~/.gitconfig`
- `git/gitconfig-work` → `~/.gitconfig-work`

### Claude Code
- `claude/CLAUDE.md` → `~/.claude/CLAUDE.md` — global agent instructions
- `claude/settings.json` → `~/.claude/settings.json`
- `agents/commands/` → `~/.claude/commands/` — slash commands (`/sync-cursor-rules`)
- `skills/` → `~/.claude/skills/` — personal skills (devcontainer-setup, system-documentation, unity-development, unity-jira)

Implementation workflows are provided by the [superpowers](https://github.com/bkrabach/claude-code-superpowers) plugin.

### Gemini CLI & Codex CLI
- `gemini/commands/` → `~/.gemini/commands/`
- Agent commands are also synced to `~/.codex/prompts/`

### Helper Scripts → `~/.local/bin/`
- `dc-connect` / `dc-claude` / `dc-rebuild` — dev container management (requires `@devcontainers/cli`)
- `sprite-*` — sprite management scripts

### Launchd
- `launchd/*.plist` → `~/Library/LaunchAgents/` — loaded automatically by install.sh

## Principles

- Simplicity wins — if a prompt is too long, it's a bug
- Test agent prompt changes on real projects before committing
- REWRITE docs, don't append
