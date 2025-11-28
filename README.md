# Dotfiles

Personal development environment configuration.

## Contents

**Neovim Configuration**: Portable vim/neovim setup optimized for code review
- `.vimrc` - Works on any server (plain vim)
- `.config/nvim/` - Full neovim with LSP, plugins, fuzzy finding

**Agent System**: Looped agent workflow for software development (Claude, Gemini, Cursor)
- `agents/` - Shared agent prompts and workflow documentation
- `claude/` - Claude Code-specific settings

## Installation

### Neovim Setup

```bash
# Clone and run installer
git clone https://github.com/ahoydave/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Installs: symlinks to `.vimrc` and `.config/nvim/`, vim-plug plugin manager

### Agent System

For Claude Code, symlink to `~/.claude/`:
```bash
ln -sf ~/dotfiles/agents/commands ~/.claude/commands
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
```

Available agents: `/research`, `/plan`, `/implement`, `/implementation-manager`, `/meta-agent`

For Gemini CLI or Cursor, link `agents/commands/` to their respective config locations.

## Neovim Configuration

**Two-tier design:**
- **Portable** (`.vimrc`): Plain vim, works anywhere, basic editing + git
- **Full** (`init.vim`): Neovim + LSP, fuzzy finding, lazygit (sources `.vimrc`)

**Prerequisites:**
- Minimal: vim (usually pre-installed)
- Full: `brew install neovim fzf fd ripgrep lazygit pyright typescript-language-server`

**Details:** See `.config/nvim/README.md` and `.config/nvim/QUICKREF.md`

## Agent System

Five specialized agents for iterative software development. Works with Claude Code, Gemini CLI, Cursor, or any AI coding tool.

**Agents:**
- `/research` - Investigate system, verify implementations, document current state
- `/plan` - Design specs collaboratively with humans via questions.md
- `/implement` - Build one atomic task per session with mandatory testing
- `/implementation-manager` - Autonomous multi-task orchestration
- `/meta-agent` - Refine the agent system itself

**Documentation:** See `agents/workflow.md`

## Usage

**Neovim:** Press `<leader>` (space) for commands, see `.config/nvim/QUICKREF.md`

**Claude Code:** Invoke with `/research`, `/plan`, `/implement` slash commands

**Updating:** `cd ~/dotfiles && git pull` (symlinks update immediately)

