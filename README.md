# Dotfiles

Personal development environment configuration.

## Contents

**Neovim Configuration**: Portable vim/neovim setup optimized for code review
- `.vimrc` - Works on any server (plain vim)
- `.config/nvim/` - Full neovim with LSP, plugins, fuzzy finding

**Claude Code Agent System**: Looped agent workflow for software development
- `claude/` - Five specialized agents (research, plan, implement, manager, meta) with shared documentation

## Installation

### Neovim Setup

```bash
# Clone and run installer
git clone https://github.com/ahoydave/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Installs: symlinks to `.vimrc` and `.config/nvim/`, vim-plug plugin manager

### Claude Code Agent System

Symlink to `~/.claude/`:
```bash
ln -sf ~/dotfiles/claude/commands ~/.claude/commands
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
```

Available agents: `/research`, `/plan`, `/implement`, `/implementation-manager`, `/meta-agent`

## Neovim Configuration

**Two-tier design:**
- **Portable** (`.vimrc`): Plain vim, works anywhere, basic editing + git
- **Full** (`init.vim`): Neovim + LSP, fuzzy finding, lazygit (sources `.vimrc`)

**Prerequisites:**
- Minimal: vim (usually pre-installed)
- Full: `brew install neovim fzf fd ripgrep lazygit pyright typescript-language-server`

**Details:** See `.config/nvim/README.md` and `.config/nvim/QUICKREF.md`

## Agent System

Five specialized agents for iterative software development using Claude Code or other coding agents.

**Agents:**
- `/research` - Investigate system, verify implementations, document current state
- `/plan` - Design specs collaboratively with humans via QUESTIONS.md
- `/implement` - Build one atomic task per session with mandatory testing
- `/implementation-manager` - Autonomous multi-task orchestration
- `/meta-agent` - Refine the agent system itself

**Documentation:** See `claude/README.md` and `claude/agent_workflow.md`

## Usage

**Neovim:** Press `<leader>` (space) for commands, see `.config/nvim/QUICKREF.md`

**Claude Code:** Invoke with `/research`, `/plan`, `/implement` slash commands

**Updating:** `cd ~/dotfiles && git pull` (symlinks update immediately)

