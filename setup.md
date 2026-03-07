# New Mac Setup

Step-by-step for a fresh MacBook. Run in order. See [README.md](README.md) for what gets installed by `./install.sh`.

---

## 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the post-install instructions to add brew to PATH (it will print the commands).

---

## 2. Dotfiles

```bash
git clone https://github.com/ahoydave/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

Installs symlinks for: `~/.zshrc`, `~/.vimrc`, `~/.config/nvim`, `~/.claude/`, `~/.gemini/commands/`, `~/.config/ghostty/`, helper scripts to `~/.local/bin/`, and launchd agents.

Note: `~/.zshrc` is a symlink to `dotfiles/zsh/zshrc`. Installers that append to `~/.zshrc` will write into the dotfiles file — review and commit selectively.

---

## 3. Terminal

**Ghostty** — GPU-accelerated, minimal, actively maintained. Download from ghostty.org.

Config is managed by dotfiles (`ghostty/config`). Tune `mouse-scroll-multiplier` if scroll speed feels off.

**tmux** — session management. Useful for leaving agent runs detached and coming back to them.

```bash
brew install tmux
```

---

## 4. Core CLI tools

```bash
brew install neovim fzf fd ripgrep bat eza jq zoxide delta lazygit gh trash
brew install starship
brew install pyright typescript-language-server
```

`trash` is keg-only — add to PATH:

```bash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
```

The full `~/.zshrc` (managed by dotfiles) includes:

```zsh
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/trash/bin:$PATH"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"
alias ls='eza'
alias ll='eza -la'
alias cat='bat'
alias cd='z'
alias rm='echo "use trash or /bin/rm"; false'
alias yoco='claude --dangerously-skip-permissions'
```

Configure delta for git diffs — add to `~/.gitconfig`:

```ini
[core]
    pager = delta
[delta]
    navigate = true
    side-by-side = true
[interactive]
    diffFilter = delta --color-only
```

---

## 5. Version management

**mise** replaces nvm, pyenv, sdkman, etc. One tool for all runtimes.

```bash
brew install mise
```

Install runtimes as needed per project:

```bash
mise install node@lts
mise use -g node@lts
mise install python@latest
mise use -g python@latest
mise install dotnet@8     # for Unity / C#
```

---

## 6. Editor

### Vim (portable)

Already configured by dotfiles — works on any machine with plain vim. Nothing extra to do.

### Neovim — LazyVim

LazyVim is a well-maintained distribution built on lazy.nvim. Provides project-aware search (Telescope) and directory navigation (neo-tree) — closer to the Emacs projectile + helm/ivy experience than a custom config.

The dotfiles `nvim/` directory contains the LazyVim config and is symlinked to `~/.config/nvim` by `install.sh`. Open nvim and it will bootstrap on first launch.

Key bindings:
- `<leader>ff` — find files (Telescope)
- `<leader>fg` — live grep across project
- `<leader>fp` — switch projects
- `<leader>e` — neo-tree file explorer
- `<leader>gg` — LazyGit
- `<C-d>` / `<C-u>` — scroll half page and re-center

Run `:checkhealth` after first launch to verify setup. Install missing language servers via `:Mason`.

### Cursor

Download from cursor.com. Use alongside Claude Code:
- Cursor: agent edits in open files, inline suggestions
- Claude Code: autonomous multi-file tasks from terminal

---

## 7. Agent tooling

**Claude Code** — use the brew cask, not npm, so it's independent of node version:

```bash
brew install --cask claude
```

Dotfiles configure `~/.claude/` (settings, hooks, agent commands, statusline) via `./install.sh`.

Launch in YOLO mode: `yoco` (alias for `claude --dangerously-skip-permissions`). Enable the filesystem sandbox inside the session with `/sandbox`.

**Gemini CLI** — npm only, set global node version first:

```bash
mise install node@lts && mise use -g node@lts
npm install -g @google/gemini-cli
```

Dotfiles set up `~/.gemini/commands/` symlink via `./install.sh`.

**Cloud CLIs:**

```bash
brew install awscli azure-cli firebase-cli
brew install --cask google-cloud-sdk
```

Authenticate after installing:

```bash
gh auth login
gcloud init
aws configure
az login
firebase login
```

Note: if gcloud complains about Python version, set a global Python via mise first: `mise install python@latest && mise use -g python@latest`.

---

## 8. Agent sandboxing

The "don't delete my home directory" stack. Use all of these together.

**Hourly local snapshots** — `install.sh` installs a launchd agent that runs `tmutil snapshot` every hour. Snapshots are stored on-disk and kept for 24h. Verify it's running:

```bash
launchctl list | grep timemachine-snapshot
tmutil listlocalsnapshotdates
```

Check logs if something seems wrong: `cat /tmp/timemachine-snapshot.err`

**Time Machine** — for full backup and longer retention, connect an external drive and configure via System Settings → General → Time Machine. A 32GB flash drive is too small — use a USB-C SSD (500GB+). Until you have one, the hourly launchd snapshots cover same-day recovery only.

**`trash` alias** — bare `rm` fails loudly. Use `trash` for recoverable deletes, `/bin/rm` when you mean it. Aliases only apply in interactive shells so system scripts and installers are unaffected.

**Claude Code settings** — `claude/settings.json` has:
- `deny` rules: hard-blocks `rm -rf ~`, `rm -rf /`, `rm -r ~`, `rm -r /`, `git push -f`, `git push --force`
- `ask` rule: prompts before any `sudo`
- `PreToolUse` hooks: warns on any `rm` (advisory), blocks force push with explanation
- Hooks operate even when `dangerouslyDisableSandbox` is used — deny rules do not

**Git worktrees** — the primary code sandbox. Before handing a task to an agent:

```bash
git worktree add ../myproject-agent feature/thing
cd ../myproject-agent
# run agent here
```

If the agent makes a mess: `git worktree remove --force ../myproject-agent`. Main checkout untouched.

**OrbStack + Docker** — container runtime, lighter than Docker Desktop. Install from orbstack.dev, open once to initialize, then: OrbStack Settings → System → Install CLI tools.

```bash
brew install --cask orbstack
```

**Kubernetes** — for k8s-based backend work:

```bash
brew install kind kubectl
```

**Dev Containers CLI** — only needed if a project has a `.devcontainer/` folder:

```bash
npm install -g @devcontainers/cli
```

---

## 9. macOS System Settings

These are manual — set once, not scriptable.

**Keyboard (System Settings → Keyboard):**
- Caps Lock → Escape: Keyboard Shortcuts → Modifier Keys
- F-keys as standard function keys: enable "Use F1, F2, etc. keys as standard function keys"
- Key repeat (below GUI minimum, set via terminal):

```bash
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 12
```

Log out and back in for these to take effect.

**Menu bar utilities:**

```bash
brew install --cask rectangle        # window management — use Standard shortcuts
brew install --cask scroll-reverser  # independent scroll direction for trackpad vs mouse
brew install --cask monitorcontrol   # external monitor brightness, follows cursor
brew install --cask maccy            # clipboard manager — Cmd+Shift+V
```

Maccy preferences: set history to ~50 entries, enable "Paste automatically".

---

## 10. Verify

```bash
nvim --version
claude --version
gh auth status
mise list
launchctl list | grep timemachine-snapshot
tmutil listlocalsnapshotdates
git worktree list    # run inside any repo
```
