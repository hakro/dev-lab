set encoding=utf-8
set fileencoding=utf-8

" Setup Theme : https://draculatheme.com/vim
syntax on
packadd! dracula
colorscheme dracula

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

set cursorline
set number
set hlsearch "Highlight search
set incsearch "Incremental search

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
" set expandtab
set autoindent
set smartindent
" set paste
set noshowmode "The mode will be shown in the LightLine plugin
set scrolloff=10 " Keep lines below and above the cursor
set mouse=a

" Change backup and swp file locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" gd shortcut for go to declaration
nnoremap gd :YcmCompleter GoToDefinition<CR>

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Autocomplete when pressing dot (vim-go)
"au filetype go inoremap <buffer> . .<C-x><C-o>
