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

# Backup existing configs
echo "Backing up existing configs..."
if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.vimrc"
fi

if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.config/nvim"
fi

# Create symlinks
echo ""
echo "Creating symlinks..."

# Remove old symlinks if they exist
rm -f "$HOME/.vimrc"
rm -rf "$HOME/.config/nvim"

# Create new symlinks
ln -sf "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"
echo "  ~/.vimrc -> $DOTFILES_DIR/vim/vimrc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "  ~/.config/nvim -> $DOTFILES_DIR/nvim"

# Claude Code configuration
echo ""
echo "Setting up Claude Code configuration..."

# Create directory structure in dotfiles if it doesn't exist
mkdir -p "$DOTFILES_DIR/agents/commands"

# Ensure ~/.claude directory exists
mkdir -p "$HOME/.claude"

# Backup existing settings.json if it's not a symlink
if [ -f "$HOME/.claude/settings.json" ] && [ ! -L "$HOME/.claude/settings.json" ]; then
    mv "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.claude/settings.json"
fi

# Backup existing commands directory if it's not a symlink
if [ -d "$HOME/.claude/commands" ] && [ ! -L "$HOME/.claude/commands" ]; then
    mv "$HOME/.claude/commands" "$HOME/.claude/commands.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.claude/commands"
fi

# Backup existing statusline script if it's not a symlink
if [ -f "$HOME/.claude/statusline-command.sh" ] && [ ! -L "$HOME/.claude/statusline-command.sh" ]; then
    mv "$HOME/.claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.claude/statusline-command.sh"
fi

# Remove old symlinks if they exist
rm -f "$HOME/.claude/settings.json"
rm -f "$HOME/.claude/commands"
rm -f "$HOME/.claude/statusline-command.sh"

# Create symlinks
ln -sf "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
echo "  ~/.claude/settings.json -> $DOTFILES_DIR/claude/settings.json"

ln -sf "$DOTFILES_DIR/agents/commands" "$HOME/.claude/commands"
echo "  ~/.claude/commands -> $DOTFILES_DIR/agents/commands"

ln -sf "$DOTFILES_DIR/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
echo "  ~/.claude/statusline-command.sh -> $DOTFILES_DIR/claude/statusline-command.sh"

# Gemini CLI configuration
echo ""
echo "Setting up Gemini CLI configuration..."

# Sync agent prompts to Gemini .toml format
if [ -f "$DOTFILES_DIR/sync_gemini_commands.sh" ]; then
    echo "  Syncing agent prompts to Gemini format..."
    cd "$DOTFILES_DIR"
    bash "$DOTFILES_DIR/sync_gemini_commands.sh"
    cd - > /dev/null
else
    echo "  Warning: sync_gemini_commands.sh not found, skipping Gemini sync"
fi

# Ensure ~/.gemini directory exists
mkdir -p "$HOME/.gemini"

# Backup existing commands directory if it's not a symlink
if [ -d "$HOME/.gemini/commands" ] && [ ! -L "$HOME/.gemini/commands" ]; then
    mv "$HOME/.gemini/commands" "$HOME/.gemini/commands.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  Backed up ~/.gemini/commands"
fi

# Remove old symlinks if they exist
rm -f "$HOME/.gemini/commands"

# Create symlinks
ln -sf "$DOTFILES_DIR/gemini/commands" "$HOME/.gemini/commands"
echo "  ~/.gemini/commands -> $DOTFILES_DIR/gemini/commands"

# Install vim-plug for vim
echo ""
echo "Installing vim-plug for vim..."
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "  vim-plug installed for vim"
else
    echo "  vim-plug already installed for vim"
fi

# Install vim-plug for neovim
echo ""
echo "Installing vim-plug for neovim..."
NVIM_PLUG="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [ ! -f "$NVIM_PLUG" ]; then
    curl -fLo "$NVIM_PLUG" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "  vim-plug installed for neovim"
else
    echo "  vim-plug already installed for neovim"
fi

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Install plugins:"
echo "     vim +PlugInstall +qall"
echo "     nvim +PlugInstall +qall"
echo ""
echo "  2. For full neovim experience, install dependencies:"
echo "     brew install neovim fzf fd ripgrep lazygit"
echo "     brew install pyright typescript-language-server"
echo ""
echo "  3. Create custom agent commands:"
echo "     cd $DOTFILES_DIR/agents/commands"
echo "     cat > example.md << 'EOF'"
echo "---"
echo "description: Example custom command"
echo "---"
echo "This is an example command. Use \$1 for arguments."
echo "EOF"
echo ""
echo "  4. Check the documentation:"
echo "     cat $DOTFILES_DIR/nvim/README.md"
echo "     cat $DOTFILES_DIR/nvim/QUICKREF.md"
echo ""

