# Quick Reference - Code Review Workflow

## Essential Commands (Both Vim & Neovim)

### Git Operations
| Key | Action |
|-----|--------|
| `<leader>gs` | Open git status |
| `<leader>gd` | Side-by-side diff of current file |
| `<leader>gb` | Git blame |
| `q` | Close git window |

### Navigation
| Key | Action |
|-----|--------|
| `Ctrl-o` | Jump back (previous location) |
| `Ctrl-i` | Jump forward (next location) |
| `<leader>w` | Save file |
| `<leader>q` | Quit |

### Buffers
| Key | Action |
|-----|--------|
| `<leader>bb` | List buffers |
| `<leader>bj` | Next buffer |
| `<leader>bk` | Previous buffer |
| `<leader>bd` | Delete/close buffer |

### Windows
| Key | Action |
|-----|--------|
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical |
| `<leader>wc` | Close window |
| `<leader>wh/j/k/l` | Move to window |
| `Ctrl-h/l` | Move left/right window |

## Neovim-Only (Local Development)

### Primary Git Interface
| Key | Action |
|-----|--------|
| `<leader>gg` | **LazyGit** (main interface) |

### LazyGit Commands
| Key | Action |
|-----|--------|
| `Space` | Stage/unstage file |
| `c` | Commit |
| `P` | Push |
| `p` | Pull |
| `e` | Edit file in vim |
| `Enter` | View diff |
| `q` | Quit |

### Inline Git Changes
| Key | Action |
|-----|--------|
| `]c` | Next change hunk |
| `[c` | Previous change hunk |
| `<leader>gh` | Preview hunk popup |
| `<leader>gS` | Stage hunk |

### File/Text Search
| Key | Action |
|-----|--------|
| `<leader>p` | Find files (fuzzy) |
| `<leader>s` | Search text in project |
| `<leader>r` | Recent files |

### Code Navigation (LSP)
| Key | Action |
|-----|--------|
| `<leader>ld` | Go to definition |
| `<leader>lR` | Find references |
| `<leader>lr` | Rename symbol |
| `<leader>lh` | Hover docs |

### Scrolling
| Key | Action |
|-----|--------|
| `Ctrl-j` | Scroll down one line |
| `Ctrl-k` | Scroll up one line |
| `Ctrl-d` | Scroll down half page |
| `Ctrl-u` | Scroll up half page |

## Typical Review Session

### Local (Neovim + LazyGit)
1. `<leader>gg` - Open LazyGit
2. Review files, press `Enter` to see diffs
3. Press `e` on a file to edit
4. Use `]c`/`[c]` to jump through changes
5. Press `<leader>ld` to jump to definitions if needed
6. Return to LazyGit, `Space` to stage
7. Press `c` to commit, `P` to push

### VPS (Plain Vim + Fugitive)
1. `<leader>gs` - Open git status
2. Press `=` on files to expand/see diff
3. Press `Enter` to edit a file
4. Press `<leader>gd` for side-by-side diff
5. Press `s` in git status to stage files
6. Press `cc` to commit
7. `:Git push` to push

## Remember
- Leader key is **Space**
- Press `<leader>` to see all available commands (which-key menu, neovim only)
- Use `Ctrl-o` to go back after any jump
- Gitsigns shows inline change indicators (│ ~ _) in neovim

