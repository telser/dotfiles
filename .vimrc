set nocompatible  " Force incompatible m

set title

" Formatting
set autoindent " Auto indention
set copyindent " Copy indention
set smartindent
set softtabstop=2	
set expandtab
set shiftwidth=2
            

set wildmenu " show list instead of just completing
set wildmode=list:longest,full " command <Tab> completion, list matches, then longest common part, then all.
set mouse=a "turn mouse on 
set linespace=0 " No extra spaces between rows
set nu " Line numbers on
set showmatch " show matching brackets/parenthesis
set incsearch " find as you type search
set hlsearch " highlight search terms

" Begin searching as typing
set incsearch
" Allow the cursor to roam in command mode
set virtualedit=all


" Get rid of beeping instead just flash the screen
set noerrorbells

" Syntax highlighting
syntax on

if has ("autocmd")
    " File type detection. Indent based on filetype. Recommended.
    filetype plugin indent on
endif

set foldenable

set spell spelllang=en_us
set spell!
:map <F8> :set spell!
