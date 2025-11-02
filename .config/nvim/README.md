# Vim/Neovim Configuration

Two-tier setup for local development and remote VPS work.

## Structure

```
~/.vimrc                    # Tier 1: Portable vim config (works on any VPS)
~/.config/nvim/init.vim     # Tier 2: Full neovim config (local development)
```

## Tier 1: VPS/Minimal Setup (Plain Vim)

**What works:** Basic editing, git (fugitive), window/buffer management, scrolloff

**Setup on a new VPS:**
```bash
# 1. Copy .vimrc
scp ~/.vimrc user@vps:~/

# 2. SSH into VPS
ssh user@vps

# 3. Install vim-plug (optional, for fugitive)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 4. Open vim and install plugins
vim
:PlugInstall
```

**Available on VPS:**
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>b` prefix - Buffer management (bj/bk/bd)
- `<leader>w` prefix - Window management (ws/wv/wc)
- `<leader>gs` - Git status (fugitive)
- `<leader>gd` - Git diff split
- `<leader>gb` - Git blame
- `Ctrl-h/j/k/l` - Window navigation

## Tier 2: Full Neovim Setup (Local)

**What works:** Everything + LSP, treesitter, fuzzy finding, lazygit, modern plugins

**Note:** In Neovim, `Ctrl-j/k` are mapped to scrolling (overriding window navigation from .vimrc). Use `<leader>wj/k/h/l` for window navigation instead.

**Prerequisites:**
```bash
# macOS
brew install neovim fzf fd ripgrep lazygit
brew install pyright typescript-language-server

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

**Setup:**
```bash
# Open neovim and install plugins
nvim
:PlugInstall
```

**Available locally (in addition to VPS features):**
- `<leader>p` - Find files (FZF)
- `<leader>s` - Search text in project (Ripgrep)
- `<leader>gg` - LazyGit (main git interface)
- `<leader>l` prefix - LSP (lr=rename, ld=definition, lR=references)
- `]c` / `[c]` - Jump between git hunks
- `<leader>gh` - Preview git hunk
- `<leader>S` - Spectre find/replace
- `Ctrl-j/k` - Scroll one line (note: conflicts with window nav, only in neovim)
- Inline git change indicators (gitsigns)
- Syntax highlighting (treesitter)
- Autocompletion (nvim-cmp)

## GitHub Setup

```bash
# 1. Create dotfiles repo
mkdir ~/dotfiles
cd ~/dotfiles
git init

# 2. Copy files
cp ~/.vimrc .
cp -r ~/.config/nvim .config/

# 3. Create .gitignore
cat > .gitignore << 'EOF'
# Ignore plugin directories
.vim/plugged/
.config/nvim/plugged/
.local/

# Ignore swap/backup files
*.swp
*.swo
*~
EOF

# 4. Commit and push
git add .
git commit -m "Initial vim/neovim config"
git remote add origin git@github.com:yourusername/dotfiles.git
git push -u origin main
```

## Installing on New Machine

```bash
# Clone dotfiles
cd ~
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Create symlinks
ln -sf ~/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# Install vim-plug and plugins (see tier 1 or 2 setup above)
```

## Workflow Guide

### Code Review Workflow
1. `<leader>gg` - Open LazyGit to see all changes
2. Navigate files, press `Space` to stage/unstage
3. Press `e` on a file to edit in vim
4. Use `]c` / `[c` to jump between changes
5. Press `<leader>gh` to preview hunks
6. Return to LazyGit, press `c` to commit
7. Press `P` to push

### VPS Review Workflow (fallback)
1. `<leader>gs` - Open git status (fugitive)
2. Press `=` on files to see diffs inline
3. Press `s` to stage files
4. Press `cc` to commit
5. `:Git push` to push

### Navigation
- `<leader>p` - Fuzzy find files
- `<leader>s` - Search for text
- `<leader>ld` - Jump to definition
- `<leader>lR` - Find references
- `Ctrl-o` / `Ctrl-i` - Navigate back/forward in jump list

### Window/Buffer Management
- `<leader>ws` - Split horizontal
- `<leader>wv` - Split vertical
- `<leader>bj` / `<leader>bk` - Next/previous buffer
- `Ctrl-h/j/k/l` - Move between windows

