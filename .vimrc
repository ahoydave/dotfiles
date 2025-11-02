" ---------------------------
" Portable Vim settings for VPS and local use
" Works with plain vim (no neovim required)
" ---------------------------

set nocompatible
syntax on
filetype plugin indent on

" Display settings
set number
set showcmd
set wildmenu
set lazyredraw
set ttyfast

" Keep cursor away from edges when scrolling
set scrolloff=8

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4

" Search
set ignorecase
set smartcase

" Behavior
set hidden
set mouse=a

" Leader key
let mapleader=" "

" ---------------------------
" Plugins (vim-plug)
" Install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then run :PlugInstall
" ---------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  " vim-plug not installed - skip plugins
else
  call plug#begin('~/.vim/plugged')
  
  " Git integration (works in vim and neovim)
  Plug 'tpope/vim-fugitive'
  
  call plug#end()
endif

" ---------------------------
" Quick save & quit
" ---------------------------
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" ---------------------------
" Window navigation (Ctrl+h/j/k/l)
" ---------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ---------------------------
" Window management (Spacemacs-style: <leader>w)
" ---------------------------
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wc :close<CR>
nnoremap <leader>wo :only<CR>
nnoremap <leader>w= <C-w>=
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

" ---------------------------
" Buffer management (Spacemacs-style: <leader>b)
" ---------------------------
nnoremap <leader>bb :buffers<CR>:buffer<Space>
nnoremap <leader>bj :bnext<CR>
nnoremap <leader>bk :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bx :bdelete<CR>

" ---------------------------
" Git operations (Fugitive)
" Only works if vim-plug and fugitive are installed
" ---------------------------
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gL :Git log<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>

" Close git/fugitive buffers easily
augroup FugitiveBindings
  autocmd!
  autocmd FileType fugitive nnoremap <buffer> q :close<CR>
  autocmd FileType fugitive nnoremap <buffer> gq :close<CR>
augroup END

" ---------------------------
" Auto-create directories on save
" ---------------------------
augroup MkdirOnSave
  autocmd!
  autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')
augroup END

