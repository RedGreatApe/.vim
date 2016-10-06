"              ____       _   _   _
"             / ___|  ___| |_| |_(_)_ __   __ _ ___
"             \___ \ / _ \ __| __| | '_ \ / _` / __|
"              ___) |  __/ |_| |_| | | | | (_| \__ \
"             |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                        |___/

" Display Settings ---------------------- {{{
set scrolloff=3                     " 2 lines above/below cursor when scrolling
set sidescroll=1                    " Minimum number of columns to scroll horizontally
set sidescrolloff=5                 " 5 characters before cursor when scrolling
set display+=lastline               " show the last line that fits in window
set number                          " show line numbers
" set relativenumber                 " show line number relative to current line
set cursorline                      " Highlight current line
set visualbell                      " Visual alarm, instead of cpu beep
set showmatch                       " show matching bracket (briefly jump)
set showmode                        " show mode in status bar (insert/replace/...)
set showcmd                         " show typed command in status bar
set ruler                           " show cursor position in status bar
set title                           " show file in titlebar
set wildmenu                        " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2                    " use 2 lines for the status bar
set showtabline=2                   " Always show tab bar       (top)
set cmdheight=2                     " Command line height
set matchtime=2                     " show matching bracket for 0.2 seconds
set matchpairs+=<:>                 " specially for html
set list                            " Display invisible characters as:
set listchars=tab:▸\                " Tabs as ▸\\\\
                                    " Every character after  column 80 is highlighted
let w:eighty_column_match = matchadd('ColorColumn', '\%81v.\+', 100)
" }}}

" Editor Settings ----------------------- {{{
set wrap
" set textwidth=80
set formatoptions=qrn1
set esckeys                         " map missed escape sequences (enables keypad keys)
set gdefault                        " Always global substitutions
set ignorecase                      " case insensitive searching
set smartcase                       " but become case sensitive if you type uppercase characters
set incsearch                       " Jump to search word as I type
set hlsearch                        " Also switch on highlighting the last used search pattern.

set backspace=start,eol,indent      " Can backspace over everything (hard mode changes this)
set smartindent                     " smart auto indenting
set autoindent
set smarttab                        " smart tab handling for indenting
set magic                           " change the way backslashes are used in search patterns

set tabstop=4                       " number of spaces a tab counts for
set shiftwidth=4                    " spaces for autoindents
set softtabstop=4
set expandtab                       " turn a tabs into spaces

set splitbelow                      " New split below the current one
set splitright                      " New split to the right

set encoding=utf-8                  " Self explanatory

syntax on                           " Switch syntax highlighting on
" }}}

" System Settings  ---------------------- {{{
set ttyfast                 " Fast terminal, redrawing
set confirm                 " get a dialog when :q, :w, or :wq fails
set nobackup                " no backup~ files.
set viminfo='20,\"500       " copy registers after quitting -- 20 jump links, regs up to 500 lines'
set hidden                  " able to close modified buffers without saving
set history=1000            " keep 100 lines of command history
set undofile                " keep an undo file (undo changes after closing)
set swapfile                " Write swap and backup files
set directory=$TMPDIR,~/Stuff/vimtmp       " Swap file location
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
" }}}
