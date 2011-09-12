set nocompatible
" Auto indention and tab spacing to make life easier
set autoindent
set smartindent
set softtabstop=2	
set expandtab
set shiftwidth=2
" Begin searching as typing
set incsearch
" Allow the cursor to roam in command mode
set virtualedit=all
" Get rid of beeping instead just flash the screen
set vb t_tb=
" Syntax highlighting
syntax on

if has ("autocmd")
    " File type detection. Indent based on filetype. Recommended.
    filetype plugin indent on
endif
