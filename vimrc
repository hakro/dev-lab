syntax on
set encoding=utf-8
set fileencoding=utf-8

set number
set hlsearch "Highlight search
set incsearch "Incremental search

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoindent
set smartindent
set paste

" Change backup and swp file locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" gd shortcut for go to declaration
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" Enable NERDTree on strtup
autocmd vimenter * NERDTree

" Autocomplete when pressing dot (vim-go)
"au filetype go inoremap <buffer> . .<C-x><C-o>
