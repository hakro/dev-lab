set encoding=utf-8
set fileencoding=utf-8
set shell=/bin/bash

syntax on
set cursorline
set number
set hlsearch "Highlight search
set incsearch "Incremental search

" Uncomment for Purify Theme : https://github.com/kyoz/purify
packadd! purify
colorscheme purify
let g:lightline = {
      \ 'colorscheme': 'purify',
      \ }
" Customize line highlight with blue background instead of underline
highlight CursorLine term=bold cterm=bold ctermfg=NONE ctermbg=19

" Uncomment for Dracula Theme : https://draculatheme.com/vim
" packadd! dracula
" colorscheme dracula
" let g:lightline = {
"       \ 'colorscheme': 'dracula',
"       \ }


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
" Enables mouse (including for resizing of splits), but use shift for copying text with cursor
set mouse=a
" Disables mouse resize, but just select text without shift to copy
" set mouse=r
set noswapfile
set splitbelow " Open splits below the current window. Useful for :term
set termwinsize=8x0
set signcolumn=yes " Keep Gutter width fixed

" Change backup and swp file locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

set completeopt=popup,menuone " Show auto doc in a popup instead of a preview split
" Default
" set completeopt=preview,menuone

" YOU COMPLETE ME config
" gd shortcut for go to declaration
nnoremap gd :YcmCompleter GoToDefinition<CR>
" Automatically hide documentation preview. Only useful if completeopt=preview
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

" Run Go Format when saving a file
autocmd BufWritePre *.go :YcmCompleter Format <afile>


" NERDTree config
" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Autoclose brackets, parenthesis ...
" Not needed when using the plugin auto-pairs
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" Autocomplete when pressing dot (vim-go)
"au filetype go inoremap <buffer> . .<C-x><C-o>
