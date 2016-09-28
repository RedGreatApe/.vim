"             ____       _   _   _
"            / ___|  ___| |_| |_(_)_ __   __ _ ___
"            \___ \ / _ \ __| __| | '_ \ / _` / __|
"             ___) |  __/ |_| |_| | | | | (_| \__ \
"            |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                        |___/

" reset to vim-defaults
set nocompatible                    " use vim-defaults instead of vi-defaults (easier, more user friendly)

" display settings
set scrolloff=2                     " 2 lines above/below cursor when scrolling
set sidescroll=1                    " Minimum number of columns to scroll horizontally
set sidescrolloff=5                 " 5 characters before cursor when scrolling
set display+=lastline               " show the last line that fits in window
set number                          " show line numbers
set showmatch                       " show matching bracket (briefly jump)
set showmode                        " show mode in status bar (insert/replace/...)
set showcmd                         " show typed command in status bar
set ruler                           " show cursor position in status bar
set title                           " show file in titlebar
set wildmenu                        " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2                    " use 2 lines for the status bar
set showtabline=2                   " Always show tab bar       (top)
set cmdheight=1                     " Command line height
set matchtime=2                     " show matching bracket for 0.2 seconds
set matchpairs+=<:>                 " specially for html
set list                            " Display invisible characters as:
let &listchars  = "tab:>-,extends:>,"
let &listchars .= "precedes:<,nbsp:\u00b7"      " as these characters

" editor settings
set esckeys                         " map missed escape sequences (enables keypad keys)
set ignorecase                      " case insensitive searching
set smartcase                       " but become case sensitive if you type uppercase characters
set incsearch                       " Jump to search word as I type
set hlsearch                        " Also switch on highlighting the last used search pattern.

set smartindent                     " smart auto indenting
set smarttab                        " smart tab handling for indenting
set magic                           " change the way backslashes are used in search patterns
set backspace=indent,eol,start      " Allow backspacing over everything in insert mode

set tabstop=4                       " number of spaces a tab counts for
set shiftwidth=4                    " spaces for autoindents
set expandtab                       " turn a tabs into spaces

set splitbelow                      " New split below the current one
set splitright                      " New split to the right

syntax on                                       " Switch syntax highlighting on
au BufRead,BufNewFile *.zpt set filetype=html   " Template files (*.zpt) with html syntax

" system settings
set confirm                 " get a dialog when :q, :w, or :wq fails
set nobackup                " no backup~ files.
set viminfo='20,\"500       " copy registers after quitting -- 20 jump links, regs up to 500 lines'
set hidden                  " remember undo after quitting
set history=100             " keep 100 lines of command history
set undofile                " keep an undo file (undo changes after closing)
set swapfile                " Write swap and backup files
set directory=$TMPDIR       " Swap file location
let mapleader = "-"         " New leader key
set mouse=a                 " use mouse
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" change the cursor shape depending on mode
" see: vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
if exists('$TMUX')
  let &t_SI  = "\<Esc>Ptmux;\<Esc>\<Esc>]50;"
  let &t_SI .= "CursorShape=1\x7\<Esc>\\"
  let &t_EI  = "\<Esc>Ptmux;\<Esc>\<Esc>]50;"
  let &t_EI .= "CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
