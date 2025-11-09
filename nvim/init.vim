" -------------------------------------------------
" Load portable base settings from ~/.vimrc
" -------------------------------------------------
source ~/.vimrc

" Enable full colour support
set termguicolors

" -------------------------------------------------
" Disable folding in Markdown
" -------------------------------------------------
autocmd FileType markdown setlocal nofoldenable

" -------------------------------------------------
" Plugins via vim-plug
" -------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" FZF fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto project root detection
Plug 'airblade/vim-rooter'

" Treesitter for better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Extra Markdown editing
Plug 'preservim/vim-markdown'

" Modern colourscheme
Plug 'folke/tokyonight.nvim'

" Leader key hints
Plug 'folke/which-key.nvim'

" Autocomplete core
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" OmniSharp-vim for C#
Plug 'OmniSharp/omnisharp-vim'

" Optional linting for OmniSharp
Plug 'dense-analysis/ale'

" Dependencies for spectre and other plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'

" Interactive find/replace
Plug 'nvim-pack/nvim-spectre'

" Git signs and hunks
Plug 'lewis6991/gitsigns.nvim'

" Git integration (like magit)
Plug 'tpope/vim-fugitive'

" Lazygit integration (better TUI)
Plug 'kdheepak/lazygit.nvim'

call plug#end()

" -------------------------------------------------
" Leader key mappings for FZF
" -------------------------------------------------
nnoremap <leader>p :Files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>r :History<CR>
nnoremap <leader>s :Rg<CR>

" -------------------------------------------------
" FZF buffer management (override .vimrc for fuzzy find)
" -------------------------------------------------
nnoremap <leader>bb :Buffers<CR>

" -------------------------------------------------
" FZF configuration: ignore junk directories
" -------------------------------------------------
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git --exclude node_modules --exclude .venv'

" Ripgrep command - only search file contents, not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=4..']}), <bang>0)

" -------------------------------------------------
" Treesitter configuration
" -------------------------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "c_sharp", "python", "javascript",
    "markdown", "markdown_inline"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
EOF

" -------------------------------------------------
" Colourscheme
" -------------------------------------------------
lua << EOF
vim.cmd[[colorscheme tokyonight]]
EOF

" -------------------------------------------------
" Which-key setup
" -------------------------------------------------
lua << EOF
require("which-key").setup {}
EOF

" -------------------------------------------------
" Fugitive buffer keybindings
" -------------------------------------------------
lua << EOF
-- Setup proper keybindings for fugitive buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    -- Make q close the fugitive buffer
    vim.keymap.set("n", "q", ":close<CR>", opts)
    -- Make sure gq also works
    vim.keymap.set("n", "gq", ":close<CR>", opts)
  end,
})
EOF

" -------------------------------------------------
" Spectre (interactive find/replace)
" -------------------------------------------------
lua << EOF
require('spectre').setup({
  is_block_ui_break = true,
})
EOF

" Spectre keybindings
nnoremap <leader>S :lua require('spectre').toggle()<CR>
nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>sw :lua require('spectre').open_visual()<CR>

" -------------------------------------------------
" Gitsigns (git diff/hunk management)
" -------------------------------------------------
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    
    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
  end
}
EOF

" Gitsigns keybindings (hunk operations)
nnoremap <leader>gh :Gitsigns preview_hunk<CR>
nnoremap <leader>gS :Gitsigns stage_hunk<CR>
nnoremap <leader>gR :Gitsigns reset_hunk<CR>
nnoremap <leader>gu :Gitsigns undo_stage_hunk<CR>
vnoremap <leader>gS :Gitsigns stage_hunk<CR>
vnoremap <leader>gR :Gitsigns reset_hunk<CR>

" Fugitive configuration
" Show flat file list instead of tree view in git status
let g:fugitive_summary_format = "%s"

" Lazygit keybinding (primary git interface)
nnoremap <leader>gg :LazyGit<CR>

" Fugitive keybindings (backup/alternative)
nnoremap <leader>gf :Git<CR>
nnoremap <leader>gq :close<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gL :Git log<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>

" -------------------------------------------------
" LSP + Autocomplete setup for Python & JS/TS
" -------------------------------------------------
lua << EOF
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure servers
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  filetypes = { 'python' },
  capabilities = capabilities,
}

vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  capabilities = capabilities,
}

-- Enable the servers
vim.lsp.enable({ 'pyright', 'ts_ls' })
EOF

" -------------------------------------------------
" OmniSharp-vim config for C#
" -------------------------------------------------
let g:OmniSharp_server_stdio = 1
let g:ale_linters = { 'cs': ['OmniSharp'] }

" -------------------------------------------------
" Global LSP/Code Actions menu
" -------------------------------------------------
lua << EOF
local wk = require("which-key")

wk.add({
  -- FZF/Search
  { "<leader>p", desc = "Find Files" },
  { "<leader>pg", desc = "Find Git Files" },
  { "<leader>r", desc = "Recent Files" },
  { "<leader>s", desc = "Search Text (Ripgrep)" },
  
  -- Find/Replace
  { "<leader>S", desc = "Toggle Spectre (Find/Replace)" },
  { "<leader>sw", desc = "Search Word (Spectre)", mode = { "n", "v" } },
  
  -- Buffer management
  { "<leader>b", group = "Buffers" },
  { "<leader>bb", desc = "List/Switch Buffers" },
  { "<leader>bj", desc = "Next Buffer" },
  { "<leader>bk", desc = "Previous Buffer" },
  { "<leader>bd", desc = "Delete Buffer" },
  { "<leader>bx", desc = "Kill Buffer" },
  
  -- Git operations
  { "<leader>g", group = "Git" },
  { "<leader>gg", desc = "LazyGit (Main Interface)" },
  { "<leader>gf", desc = "Git Status (Fugitive)" },
  { "<leader>gq", desc = "Close Git Window" },
  { "<leader>gc", desc = "Git Commit" },
  { "<leader>gp", desc = "Git Push" },
  { "<leader>gl", desc = "Git Pull" },
  { "<leader>gL", desc = "Git Log" },
  { "<leader>gd", desc = "Git Diff Split" },
  { "<leader>gb", desc = "Git Blame" },
  { "<leader>gh", desc = "Preview Hunk" },
  { "<leader>gS", desc = "Stage Hunk", mode = { "n", "v" } },
  { "<leader>gR", desc = "Reset Hunk", mode = { "n", "v" } },
  { "<leader>gu", desc = "Undo Stage Hunk" },
  { "]c", desc = "Next Hunk (Git)" },
  { "[c", desc = "Previous Hunk (Git)" },
  
  -- Window management
  { "<leader>w", group = "Windows" },
  { "<leader>ws", desc = "Split Horizontal" },
  { "<leader>wv", desc = "Split Vertical" },
  { "<leader>wc", desc = "Close Window" },
  { "<leader>wo", desc = "Close Other Windows" },
  { "<leader>w=", desc = "Balance Windows" },
  { "<leader>wh", desc = "Move to Left Window" },
  { "<leader>wj", desc = "Move to Below Window" },
  { "<leader>wk", desc = "Move to Above Window" },
  { "<leader>wl", desc = "Move to Right Window" },
  
  -- Language/LSP
  { "<leader>l", group = "Code / LSP" },
  
  -- General LSP actions (work for all languages: Python, JS/TS, C#)
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Symbol" },
  { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
  { "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find References" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format Buffer" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Actions" },
  { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },

  -- C# specific (OmniSharp) - extra features beyond standard LSP
  { "<leader>ls", group = "C# (OmniSharp)" },
  { "<leader>lsfu", "<Plug>(omnisharp_find_usages)", desc = "Find Usages" },
  { "<leader>lsfi", "<Plug>(omnisharp_find_implementations)", desc = "Find Implementations" },
  { "<leader>lspd", "<Plug>(omnisharp_preview_definition)", desc = "Preview Definition" },
  { "<leader>lspi", "<Plug>(omnisharp_preview_implementations)", desc = "Preview Implementations" },
  { "<leader>lsst", "<Plug>(omnisharp_type_lookup)", desc = "Type Lookup" },
  { "<leader>lsd", "<Plug>(omnisharp_documentation)", desc = "Show Documentation" },
  { "<leader>lsfs", "<Plug>(omnisharp_find_symbol)", desc = "Find Symbol" },
  { "<leader>lsfx", "<Plug>(omnisharp_fix_usings)", desc = "Fix Usings" },
  { "<leader>lsgcc", "<Plug>(omnisharp_global_code_check)", desc = "Global Code Check" },
  { "<leader>lsca", "<Plug>(omnisharp_code_actions)", desc = "Code Actions" },
  { "<leader>ls.", "<Plug>(omnisharp_code_action_repeat)", desc = "Repeat Code Action" },
  { "<leader>ls=", "<Plug>(omnisharp_code_format)", desc = "Format Code" },
  { "<leader>lsnm", "<Plug>(omnisharp_rename)", desc = "Rename Symbol" },
  { "<leader>lsre", "<Plug>(omnisharp_restart_server)", desc = "Restart Server" },
  { "<leader>lsstt", "<Plug>(omnisharp_start_server)", desc = "Start Server" },
  { "<leader>lsssp", "<Plug>(omnisharp_stop_server)", desc = "Stop Server" },
})
EOF
