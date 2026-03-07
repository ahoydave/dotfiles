#!/bin/bash

set -e

echo "=========================================="
echo "Installing dotfiles..."
echo "=========================================="
echo ""

# Detect the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

# Check if we're in the right directory
if [ ! -f "$DOTFILES_DIR/vim/vimrc" ]; then
    echo "Error: Could not find $DOTFILES_DIR/vim/vimrc"
    echo "Make sure you're running this script from the dotfiles repository root"
    exit 1
fi

echo "Using dotfiles from: $DOTFILES_DIR"
echo ""

# ------------------------------------------
# Helper: create a symlink, backing up any
# existing real file/dir first. Idempotent.
# Usage: symlink <target> <link>
# ------------------------------------------
symlink() {
    local target="$1"
    local link="$2"

    # If it exists and is NOT already a symlink, back it up
    if [ -e "$link" ] && [ ! -L "$link" ]; then
        mv "$link" "${link}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  Backed up $link"
    fi

    # Remove existing symlink (or nothing) and create fresh
    rm -rf "$link"
    ln -sf "$target" "$link"
    echo "  $link -> $target"
}

# ------------------------------------------
# Shell
# ------------------------------------------
echo "Setting up shell..."
symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# ------------------------------------------
# Vim / Neovim
# ------------------------------------------
echo ""
echo "Setting up vim/neovim..."
mkdir -p "$HOME/.config"
symlink "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"
symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# vim-plug for vim
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "  vim-plug installed for vim"
else
    echo "  vim-plug already installed for vim"
fi

# ------------------------------------------
# Ghostty
# ------------------------------------------
echo ""
echo "Setting up Ghostty..."
mkdir -p "$HOME/.config/ghostty"
symlink "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# ------------------------------------------
# Claude Code
# ------------------------------------------
echo ""
echo "Setting up Claude Code..."
mkdir -p "$HOME/.claude"
mkdir -p "$DOTFILES_DIR/agents/commands"
symlink "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
symlink "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
symlink "$DOTFILES_DIR/agents/commands" "$HOME/.claude/commands"
symlink "$DOTFILES_DIR/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

# ------------------------------------------
# Gemini CLI
# ------------------------------------------
echo ""
echo "Setting up Gemini CLI..."
if [ -f "$DOTFILES_DIR/sync_gemini_commands.sh" ]; then
    echo "  Syncing agent prompts to Gemini format..."
    cd "$DOTFILES_DIR"
    bash "$DOTFILES_DIR/sync_gemini_commands.sh"
    cd - > /dev/null
fi
mkdir -p "$HOME/.gemini"
symlink "$DOTFILES_DIR/gemini/commands" "$HOME/.gemini/commands"

# ------------------------------------------
# Helper scripts
# ------------------------------------------
echo ""
echo "Setting up helper scripts..."
SCRIPTS_BIN="$HOME/.local/bin"
mkdir -p "$SCRIPTS_BIN"
for script in "$DOTFILES_DIR"/scripts/*; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        name="$(basename "$script")"
        symlink "$script" "$SCRIPTS_BIN/$name"
    fi
done

# ------------------------------------------
# Codex CLI prompts
# ------------------------------------------
echo ""
echo "Setting up Codex CLI prompts..."
CODEX_PROMPTS_DIR="$HOME/.codex/prompts"
mkdir -p "$CODEX_PROMPTS_DIR"
for cmd in "$DOTFILES_DIR"/agents/commands/*.md; do
    name="$(basename "$cmd")"
    symlink "$cmd" "$CODEX_PROMPTS_DIR/$name"
done

# ------------------------------------------
# Launchd agents
# ------------------------------------------
echo ""
echo "Setting up launchd agents..."
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
mkdir -p "$LAUNCH_AGENTS_DIR"

for plist in "$DOTFILES_DIR"/launchd/*.plist; do
    name="$(basename "$plist")"
    label="${name%.plist}"
    dest="$LAUNCH_AGENTS_DIR/$name"

    symlink "$plist" "$dest"

    # Unload first (ignore error if not loaded), then load
    launchctl unload "$dest" 2>/dev/null || true
    launchctl load "$dest"
    echo "  Loaded launchd agent: $label"
done

# ------------------------------------------
# Done
# ------------------------------------------
echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Open nvim — LazyVim will install plugins on first launch"
echo "  2. Run :checkhealth in nvim to verify setup"
echo "  3. Authenticate CLI tools if not done:"
echo "     gh auth login"
echo "     gcloud init"
echo "     aws configure"
echo "     az login"
echo "     firebase login"
echo ""
