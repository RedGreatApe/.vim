"              ____       _   _   _
"             / ___|  ___| |_| |_(_)_ __   __ _ ___
"             \___ \ / _ \ __| __| | '_ \ / _` / __|
"              ___) |  __/ |_| |_| | | | | (_| \__ \
"             |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                        |___/


" Cursor shape (bar when in insert mode)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
" set cursorcolumn       " Highlight current line
set list               " Display invisible characters as:
set listchars=tab:▸-   " Tabs as ▸---
set listchars+=trail:· " Trailing space as ·
set noshowmode         " Vim displays mode (if in Insert, or Visual, etc), disable this

set cmdheight=2        " Command line height
set showcmd            " show typed command in status bar
set laststatus=2
set showtabline=2      " Always show tab bar       (top)

set expandtab          " turn a tabs into spaces
set shiftwidth=4       " spaces for autoindents
set softtabstop=4      " number of spaces in tab when editing
set tabstop=4          " number of visual spaces per tab

set ignorecase         " case insensitive searching
set smartcase          " unless I use caps
set incsearch          " Highlight the next match while still typing the pattern
set pastetoggle=<F3>   " Toggle set paste

set splitbelow         " New split below the current one
set splitright         " New split to the right

syntax on              " Switch syntax highlighting on
set updatetime=250

set noautoread         " together with :checktime (and set confirm), prompt to reload file
set confirm            " get a dialog when :q, :w, or :wq fails
set hidden             " able to hide modified buffers without saving
set nobackup           " no backup~ files.
set noswapfile         " Write swap and backup files
set undofile           " keep an undo file (undo changes after closing)

set mouse=a

set keywordprg=ack
