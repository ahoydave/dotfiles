# Dotfiles

Personal vim/neovim configuration optimized for code review workflow.

## Structure

```
dotfiles/
├── .vimrc                      # Portable vim config (works on any server)
├── .config/nvim/
│   ├── init.vim                # Full neovim config with LSP, plugins
│   ├── README.md               # Detailed setup and usage guide
│   └── QUICKREF.md             # Quick command reference
└── install.sh                  # Automated installation script
```

## Quick Install

```bash
# Clone this repo
git clone https://github.com/ahoydave/dotfiles.git ~/dotfiles

# Run install script
cd ~/dotfiles
./install.sh
```

The install script will:
1. Back up any existing configs
2. Create symlinks from `~/.vimrc` and `~/.config/nvim/` to this repo
3. Install vim-plug (plugin manager)
4. Prompt you to install plugins

## Manual Install

```bash
# Create symlinks
ln -sf ~/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# Install vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Open vim/nvim and install plugins
vim +PlugInstall +qall
nvim +PlugInstall +qall
```

## Prerequisites

### Minimal (VPS/Server - plain vim)
```bash
# Usually already installed, but if needed:
apt-get install vim  # Debian/Ubuntu
yum install vim      # CentOS/RHEL
```

### Full (Local - neovim)
```bash
# macOS
brew install neovim fzf fd ripgrep lazygit
brew install pyright typescript-language-server

# Ubuntu/Debian
sudo apt install neovim fzf fd-find ripgrep
# Install lazygit from GitHub releases

# Install language servers via npm/pip
npm install -g typescript-language-server
pip install pyright
```

## Two-Tier Setup

This config has two tiers:

**Tier 1 - VPS/Portable** (`.vimrc`)
- Works with plain vim on any server
- Basic editing, git (fugitive), buffer/window management
- No external dependencies beyond vim

**Tier 2 - Full Power** (`init.vim`)
- Requires neovim + external tools
- LSP, fuzzy finding, lazygit, modern plugins
- Automatically sources `.vimrc`, so you get everything

## Documentation

- **`.config/nvim/README.md`** - Complete setup guide and workflow examples
- **`.config/nvim/QUICKREF.md`** - Quick command reference card

## Usage

After install, check out:
- **Neovim documentation:** `~/.config/nvim/README.md`
- **Quick reference:** `~/.config/nvim/QUICKREF.md`
- **In-app help:** Press `<leader>` (space) in neovim to see all commands

## Updating

```bash
cd ~/dotfiles
git pull
# Restart vim/nvim - changes take effect immediately (symlinks!)
```

## Making Changes

Since these are symlinked, you can edit the files directly:
```bash
nvim ~/.config/nvim/init.vim
# This edits ~/dotfiles/.config/nvim/init.vim

cd ~/dotfiles
git add -A
git commit -m "Update config"
git push
```

