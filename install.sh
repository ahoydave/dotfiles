#!/bin/bash

set -e

echo "=========================================="
echo "Installing dotfiles..."
echo "=========================================="
echo ""

DOTFILES_DIR="$HOME/dotfiles"

# Check if we're in the right directory
if [ ! -f "$DOTFILES_DIR/.vimrc" ]; then
    echo "Error: Could not find $DOTFILES_DIR/.vimrc"
    echo "Make sure this repo is cloned to ~/dotfiles"
    exit 1
fi

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
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
echo "  ~/.vimrc -> $DOTFILES_DIR/.vimrc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
echo "  ~/.config/nvim -> $DOTFILES_DIR/.config/nvim"

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
echo "  3. Check the documentation:"
echo "     cat ~/.config/nvim/README.md"
echo "     cat ~/.config/nvim/QUICKREF.md"
echo ""

