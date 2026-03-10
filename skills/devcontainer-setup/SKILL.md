---
name: devcontainer-setup
description: Use when setting up a dev container for a project, or when asked to create or update .devcontainer/ configuration
---

# Dev Container Setup

Scaffold or update `.devcontainer/` for a project with a standard tooling base and project-specific customization.

## When to Use

- Setting up a new dev container for a project
- Updating an existing dev container (new tools, version bumps)
- Porting a project to work in containers

## Process

1. Check if `.devcontainer/` already exists — update rather than overwrite
2. Ask what the project needs:
   - **Base image** (dotnet/sdk, node, python, ubuntu, etc.)
   - **VS Code extensions** relevant to the language/framework
   - **Project-specific env vars**
   - **Extra tools** from the utilities catalog below
3. Generate `Dockerfile` and `devcontainer.json` using the templates below
4. Test the build: `docker build -f .devcontainer/Dockerfile .devcontainer/`

## Standard Base Layer

Every dev container includes this tooling layer. Do not skip or modify unless asked.

### System packages (apt)

```dockerfile
curl less git procps sudo fzf zsh bat man-db unzip gnupg2 openssh-client gh jq nano vim wget python3 python3-pip python3-venv make
```

### CLI tools installed separately

| Tool | Install method |
|------|---------------|
| git-delta | `.deb` from GitHub releases |
| eza | Binary from GitHub releases |
| starship | `starship.rs/install.sh` |
| zoxide | `ajeetdsouza/zoxide/install.sh` |

### Node.js + Claude Code

```dockerfile
# Node.js 24.x via nodesource
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
  apt-get install -y nodejs

# Claude Code (pinned version)
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}
```

### User setup

- User `vscode` with passwordless sudo
- Shell: zsh with starship, fzf, zoxide
- Persistent bash history via volume mount
- `~/bin` in PATH for tool symlinks

### Standard mounts (devcontainer.json)

```json
"mounts": [
  "source=claude-code-bashhistory-${devcontainerId},target=/commandhistory,type=volume",
  "source=${localEnv:HOME}/.claude,target=/home/vscode/.claude,type=bind",
  "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,readonly",
  "source=${localEnv:HOME}/.gitconfig,target=/home/vscode/.gitconfig,type=bind,readonly",
  "source=${localEnv:HOME}/.gitconfig-work,target=/home/vscode/.gitconfig-work,type=bind,readonly"
]
```

### Standard env vars (devcontainer.json)

```json
"containerEnv": {
  "NODE_OPTIONS": "--max-old-space-size=4096",
  "CLAUDE_CONFIG_DIR": "/home/vscode/.claude",
  "POWERLEVEL9K_DISABLE_GITSTATUS": "true",
  "ANTHROPIC_BASE_URL": "${localEnv:ANTHROPIC_BASE_URL}",
  "ANTHROPIC_AUTH_TOKEN": "${localEnv:ANTHROPIC_AUTH_TOKEN}",
  "ANTHROPIC_MODEL": "${localEnv:ANTHROPIC_MODEL}",
  "ANTHROPIC_DEFAULT_OPUS_MODEL": "${localEnv:ANTHROPIC_DEFAULT_OPUS_MODEL}",
  "ANTHROPIC_DEFAULT_SONNET_MODEL": "${localEnv:ANTHROPIC_DEFAULT_SONNET_MODEL}",
  "ANTHROPIC_DEFAULT_HAIKU_MODEL": "${localEnv:ANTHROPIC_DEFAULT_HAIKU_MODEL}",
  "ANTHROPIC_SMALL_FAST_MODEL": "${localEnv:ANTHROPIC_SMALL_FAST_MODEL}",
  "MCP_TOOL_TIMEOUT": "${localEnv:MCP_TOOL_TIMEOUT}",
  "DISABLE_AUTOUPDATER": "${localEnv:DISABLE_AUTOUPDATER}"
}
```

### Standard zshrc

```bash
# Path
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/share/npm-global/bin:$PATH"

# Aliases
alias ls='eza'
alias ll='eza -la'
alias cat='bat'
alias rm='echo "use /bin/rm explicitly"; false'
alias yoco='claude --dangerously-skip-permissions'

# Persist history
export HISTFILE=/commandhistory/.bash_history
export PROMPT_COMMAND='history -a'

# History prefix search (up/down arrow)
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Tools
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# IMPORTANT: zoxide init must be last
eval "$(zoxide init zsh)"
```

## Utilities Catalog

Additional tools that can be added per-project. Ask which are needed.

### jira-tools

Clones the jira-tools repo and runs its installer. Requires Python 3 (included in base layer).

```dockerfile
# Install jira-tools CLI
USER vscode
RUN git clone https://github.com/ahoydave/jira-tools.git /home/vscode/repos/jira-tools && \
  cd /home/vscode/repos/jira-tools && \
  bash install.sh
```

Credentials mount (add to devcontainer.json mounts):
```json
"source=${localEnv:HOME}/.jira-cli,target=/home/vscode/.jira-cli,type=bind"
```

### dotfiles

Clones the dotfiles repo and runs install to get skills, commands, and shell config:

```dockerfile
USER vscode
RUN git clone https://github.com/ahoydave/dotfiles.git /home/vscode/dotfiles && \
  cd /home/vscode/dotfiles && \
  bash install.sh
```

Note: When using this, the standard zshrc written in the Dockerfile can be omitted since dotfiles install.sh deploys it.

## Build Args

Always expose these as build args for version pinning:

```dockerfile
ARG CLAUDE_CODE_VERSION=latest
ARG GIT_DELTA_VERSION=0.18.2
ARG EZA_VERSION=0.23.4
```

Surface them in devcontainer.json:

```json
"build": {
  "dockerfile": "Dockerfile",
  "args": {
    "TZ": "${localEnv:TZ:America/Los_Angeles}",
    "CLAUDE_CODE_VERSION": "2.1.71",
    "GIT_DELTA_VERSION": "0.18.2",
    "EZA_VERSION": "0.23.4"
  }
}
```

## Project-Specific Sections

After the standard base, add project-specific setup:

- **Base image**: First line of Dockerfile (`FROM`)
- **Extra apt packages**: Append to the main `apt-get install` block
- **SDK setup**: After user creation (e.g., `dotnet --version`, `rustup`, etc.)
- **VS Code extensions**: In `customizations.vscode.extensions`
- **Extra env vars**: Append to `containerEnv`
- **Extra mounts**: Append to `mounts` (caches, credentials, etc.)
- **Workspace path**: Set `workspaceMount` and `workspaceFolder`

## Common Mistakes

- **Forgetting `USER vscode`** before tool installs that write to home dir
- **Not pinning versions** for reproducible builds
- **Missing `~/bin` in PATH** — tools installed via symlink won't be found
- **Running zoxide init before other shell inits** — it must be last in zshrc
