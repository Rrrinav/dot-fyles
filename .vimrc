" Enable line numbers
set number
set relativenumber

" Show line and column number in status line
set ruler

" Highlight current line
set cursorline

" Enable line wrapping
set wrap

" Show line and column position
set ruler

" Enable syntax highlighting
syntax enable

" Enable filetype detection (for plugins)
filetype plugin indent on

" Set the default search to ignore case
set ignorecase

" Highlight search results
set hlsearch

" Enable auto-indentation
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Enable clipboard support (if available)
set clipboard='unnamedplus'

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'preservim/nerdtree'
call plug#end()

set background=dark
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
set t_Co=256
colorscheme gruvbox
nnoremap <C-n> :NERDTreeToggle<CR>
