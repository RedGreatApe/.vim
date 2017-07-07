set nocompatible

set display+=lastline               " show the last line that fits in window
set showmatch                       " show matching bracket (briefly jump)
set matchtime=2                     " show matching bracket for 0.2 seconds
set ruler                           " show cursor position in status bar
set scrolloff=1                     " 2 lines above/below cursor when scrolling
set sidescroll=1                    " Minimum number of columns to scroll horizontally
set sidescrolloff=5                 " 5 characters before cursor when scrolling
set title                           " show file in titlebar
set visualbell                      " Visual alarm, instead of cpu beep
set wildignore+=*.o,*.obj,*.bak     " Files matching these patterns
set wildignore+=*.exe,*.py[co]      " will be ignored when expanding wildcards
set wildignore+=*.swp,*~,*.pyc,.svn
set wildmenu                        " completion with menu
set wildmode=longest,full
set nofoldenable                    " Do not fold by default

set esckeys                         " map missed escape sequences (enables keypad keys)
set formatoptions=qn1               " format options (I use them on <leader>fo ) (removed r, annyoing on comments)
set hlsearch                        " Highlight all matches in file when performing search
set wrap

set autoindent                      " Automatically indent every new line
set backspace=start,eol,indent      " Can backspace over everything (hard mode changes this)
set magic                           " change the way backslashes are used in search patterns
set smartindent                     " smart auto indenting
set smarttab                        " smart tab handling for indenting
set encoding=utf-8                  " Self explanatory
syntax on                           " Switch syntax highlighting on
" }}}

" System Settings  ---------------------- {{{
set undodir=$TMPDIR         " Swap file location
set directory=$TMPDIR       " Swap file location
set ttyfast                 " Fast terminal, redrawing
