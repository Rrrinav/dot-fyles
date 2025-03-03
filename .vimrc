" General settings
set number
set relativenumber
set ruler
set cursorline
set wrap
set termguicolors
set background=dark
set ignorecase
set smartcase
set hlsearch
set incsearch
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set timeoutlen=500 

set guioptions-=T           " Remove toolbar
set guioptions-=m           " Remove menu bar
set guioptions-=r           " Remove right-hand scroll bar
set guioptions-=L           " Remove left-hand scroll bar
set clipboard=unnamed,unnamedplus

" Plugin manager (vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
call plug#end()

" Theme and indent settings
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
let g:indentLine_faster = 1
let g:indentLine_setColors = 1
colorscheme gruvbox

" Keymaps
let mapleader=" "

" NERDTree keymap
nnoremap <leader>n :NERDTreeToggle<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize splits with arrow keys
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

nnoremap <leader>ff :FZF<CR>

" Terminal mode keymaps
tnoremap <Esc> <C-\><C-n>
