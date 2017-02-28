"              ____       _   _   _
"             / ___|  ___| |_| |_(_)_ __   __ _ ___
"             \___ \ / _ \ __| __| | '_ \ / _` / __|
"              ___) |  __/ |_| |_| | | | | (_| \__ \
"             |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                        |___/

" Display Settings ---------------------- {{{
set t_ut=                           " fixes the drawing issue while using tmux (Most of the time)
set cmdheight=2                     " Command line height
set cursorline                      " Highlight current line
set display+=lastline               " show the last line that fits in window
set laststatus=2                    " Always show the status bar
set list                            " Display invisible characters as:
set listchars=tab:▸\                " Tabs as ▸\\\\
set showmatch                       " show matching bracket (briefly jump)
set matchpairs+=<:>                 " specially for html
set matchtime=2                     " show matching bracket for 0.2 seconds
set number                          " show line numbers
set relativenumber                  " show line number relative to current line
set ruler                           " show cursor position in status bar
set scrolloff=1                     " 2 lines above/below cursor when scrolling
set showcmd                         " show typed command in status bar
set showtabline=2                   " Always show tab bar       (top)
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
set noshowmode                      " Vim displays mode (if in Insert, or Visual, etc), disable this

" gvim minimal interface
set guioptions-=m                   " remove the menubar in gVim
set guioptions-=r                   " remove the right scrollbar in gVim
set guioptions-=L                   " remove the left scrollbar in gVim
set guioptions-=T                   " remove the toolbar in gVim
                                    " Every character after  column 80 is highlighted
let w:eighty_column_match = matchadd('ColorColumn', '\%81v.\+', 100)
" }}}

" Editor Settings ----------------------- {{{
set esckeys                         " map missed escape sequences (enables keypad keys)
set formatoptions=qn1               " format options (I use them on <leader>fo ) (removed r, annyoing on comments)
set hlsearch                        " Highlight all matches in file when performing search
set ignorecase                      " case insensitive searching
set incsearch                       " Highlight the next match while still typing the pattern
set smartcase                       " but become case sensitive if you type uppercase characters
set wrap

set pastetoggle=<F3>                " Toggle set paste
set autoindent                      " Automatically indent every new line
set backspace=start,eol,indent      " Can backspace over everything (hard mode changes this)
set magic                           " change the way backslashes are used in search patterns
set smartindent                     " smart auto indenting
set smarttab                        " smart tab handling for indenting

set expandtab                       " turn a tabs into spaces
set shiftwidth=4                    " spaces for autoindents
set softtabstop=4
set tabstop=4                       " number of spaces a tab counts for

set splitbelow                      " New split below the current one
set splitright                      " New split to the right

set suffixesadd+=.pl,.pm,pl6,pm6    " For openning perl files with gf
set encoding=utf-8                  " Self explanatory
syntax on                           " Switch syntax highlighting on
" }}}

" System Settings  ---------------------- {{{
set confirm                 " get a dialog when :q, :w, or :wq fails
set undodir=$TMPDIR         " Swap file location
set directory=$TMPDIR       " Swap file location
set hidden                  " able to hide modified buffers without saving
set history=1000            " keep 100 lines of command history
set nobackup                " no backup~ files.
set noswapfile              " Write swap and backup files
set ttyfast                 " Fast terminal, redrawing
set undofile                " keep an undo file (undo changes after closing)
set viminfo='20,\"500       " copy registers after quitting -- 20 jump links, regs up to 500 lines'

set mouse=a                 " disabling mouse
set mousehide               " hide when characters are typed
" if has("mouse_sgr")
"     set ttymouse=sgr
" else
"     set ttymouse=xterm2
" end
