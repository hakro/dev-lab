" Useful Plugins
" git clone --depth 1 https://github.com/jiangmiao/auto-pairs.git ~/.vim/pack/plugins/start
" git clone --depth 1 https://github.com/tpope/vim-commentary.git ~/.vim/pack/plugins/start
" git clone --depth 1 https://github.com/tpope/vim-sleuth.git ~/.vim/pack/plugins/start
" git clone --depth 1 https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/plugins/start
"
" Comment C(PP) files with // instead of /**/
" echo "setlocal commentstring=//\ %s" > ~/.vim/after/ftplugin/c.vim
"
" Terraform Syntax Highlight
" mkdir -p ~/.vim/syntax
" wget https://raw.githubusercontent.com/hashivim/vim-terraform/refs/heads/master/syntax/terraform.vim -O ~/.vim/syntax/terraform.vim
" wget https://raw.githubusercontent.com/hashivim/vim-terraform/refs/heads/master/syntax/hcl.vim -O ~/.vim/syntax/hcl.vim

let mapleader=" "
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set shell=/bin/bash

" colorscheme habamax
colorscheme wildcharm
set background=dark " or light

syntax on
set cursorline
set number
set relativenumber
set signcolumn=yes " Keep Gutter width fixed
set hlsearch " Highlight search
set incsearch " Incremental search
set ignorecase
set shortmess-=S " Show search count : https://stackoverflow.com/questions/49297579/how-to-count-search-results-in-vim
set updatetime=300

" Show auto doc in a popup instead of a preview split
" set completeopt=popup

set wildmenu " Show TAB completion in a vertical menu
set wildoptions=pum " Show as a PopUpMenu
" set wildignore=*.o,*.a,*.d,**/thirdparty/*,node_modules/*,bin/*,.git/* "Helpful for things like :find **/*.cpp
"Helpful for things like :find **/*.cpp
set wildignore=**/bin/*,*.so,*.o,*.a,*.obj,*.d,*.data,*.pyc,__pycache__/*,.git/*,node_modules/*,**/thirdparty/*,**/unvendored/*,**/*.moc.cpp,*.dat

let &grepprg='grep -HIn --exclude-dir=.git $* /dev/null'

let g:netrw_banner=0
let g:netrw_list_hide= '.DS_Store,*/tmp/*,.*\.so,.*\.a,.*\.o,*.swp,*.zip,*.git'
let g:netrw_sort_by = 'name'
let g:netrw_sort_sequence = '[\/]$' " Show dirs first, and group .h and .c/cpp files

filetype plugin on
filetype plugin indent on
" Enable HTML tag matching using the % key
" runtime macros/matchit.vim

" On long lines, show the full line instead of @ symbols
" https://vim.fandom.com/wiki/Working_with_long_lines#Navigating_long_lines_with_Vim's_built-in_capabilities
set display+=lastline
nnoremap j gj
nnoremap k gk
inoremap jk <Esc>
inoremap kj <Esc>
" Jump to exact column of a mark, instead of begining of line
nnoremap ' `
" Jump to alternate file (^ does not work with AZERTY)
nnoremap <C-p> <C-^>
nnoremap <leader>e :e **/*
" nnoremap <leader>f :grep -r "" .<left><left><left>
" nnoremap <leader>f :grep -r --exclude-dir=.git --exclude=*.moc.cpp --include=*{.cpp,.h} "" .<left><left><left>
nnoremap <leader>f :grep -r "" .<left><left><left>
nnoremap <Esc> <CMD>noh<CR>
nnoremap <leader>w :set wrap!<CR>

nnoremap <leader>gp :GitGutterPrevHunk<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>

set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set cinoptions=l1,j1 "Better indentation for C switch case & lambdas
" On pressing tab, insert 4 spaces
" set expandtab
set autoindent
set smartindent
" set paste
set laststatus=2 "Always show Line with file name
set scrolloff=3 " Keep lines below and above the cursor
" Enables mouse (including for resizing of splits), but use shift for copying text with cursor
set mouse=a
" Disables mouse resize, but just select text without shift to copy
" set mouse=r
set splitbelow " Open splits below the current window. Useful for :term
set splitright " Open vertical split to the right

set noswapfile
set nobackup
set undodir=~/.vim/undo/

" Hide line numbers in Terminal Window
autocmd TerminalOpen * setlocal nonumber norelativenumber signcolumn=no
" set termwinsize=8x0

" Remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Use <space>l toggle line number on and off
nnoremap <SPACE>l <CMD>call ToggleLineNumber()<CR>
def! ToggleLineNumber()
	if &number || &relativenumber
		setlocal nonumber
		setlocal norelativenumber
		setlocal signcolumn=no
	else
		setlocal number
		setlocal relativenumber
		setlocal signcolumn=yes
	endif
enddef
