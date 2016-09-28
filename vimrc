"
"                       __   _(_)_ __ ___  _ __ ___
"                       \ \ / / | '_ ` _ \| '__/ __|
"                        \ V /| | | | | | | | | (__
"                       (_)_/ |_|_| |_| |_|_|  \___|
"

" reset to vim-defaults
if &compatible                      " only if not set before:
  set nocompatible                  " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" display settings
set background=dark                 " enable for dark terminals
" set nowrap                          " dont wrap lines
set fo-=t                           " don't automatically wrap text when typing (fold)
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
set list                            " Show invisible characters
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

set splitbelow                      " New buffer below the current one
set splitright

syntax on                                       " Switch syntax highlighting on
au BufRead,BufNewFile *.zpt set filetype=html   " Template files (*.zpt) with html syntax

" system settings
set confirm                 " get a dialog when :q, :w, or :wq fails
set nobackup                " no backup~ files.
set viminfo='20,\"500       " copy registers after quitting -- 20 jump links, regs up to 500 lines'
set hidden                  " remember undo after quitting
set history=100             " keep 100 lines of command history
set undofile                                    " keep an undo file (undo changes after closing)
set swapfile                                    " Write swap and backup files
set directory=$TMPDIR,~/Stuff/vimtmp            " Swap file location
set mouse=a                 " use mouse
let mapleader = "-"
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

""""""""""""""""""""
"  END Essentials
""""""""""""""""""""


""""""""""""""""""""
" Mappings
""""""""""""""""""""
" paste toggle
set pastetoggle=<F10>
" go to next buffer
nnoremap gb :bn<CR>
" use Enter in insert mode to enter an undo friendly new line still doesnt seem to work
imap <CR> <Esc>o
" save in insert mode
imap <C-s> <Esc><C-s>
" make Y behave similarly to D and C
nnoremap Y y$
" %% Gives directory of current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Key repeat hack for resizing splits
" <C-w>+++- vs <C-w>+<C-w>+<C-w>-
" see: http://www.vim.org/scripts/script.php?script_id=2223
nnoremap <C-w>+ <C-w>+<SID>ws
nnoremap <C-w>- <C-w>-<SID>ws
nnoremap <C-w>> <C-w>><SID>ws
nnoremap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nnoremap <SID>ws <Nop>

" Allow for common typoes
" on quit/write
" Bind :Q to :qi
command! Q q
" Move current line one line down
command! W w
command! Qall qall

" write file
nnoremap <C-s> :w<CR>
" close current buffer
nnoremap <C-q> :q<CR>

" Clear search highlighting
nnoremap <F3> :noh<CR>

function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
nnoremap <silent><F6> :call g:ToggleColorColumn()<CR>

" CTRL-U in insert mode deletes a lot!
" Use CTRL-G u  to first break undo,
" so that you can undo CTRL-U
" after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Tab remaps
nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>w :tabclose<CR>

" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk

""""""""""""""""""""
" END Mappings
""""""""""""""""""""


""""""""""""""""""""
"  Plugin Manager
""""""""""""""""""""
call plug#begin('~/.vim/plugged')

    Plug 'vim-perl/vim-perl'                " Perl syntax
    Plug 'vim-perl/vim-perl6'               " Perl6 syntax
    Plug 'ctrlpvim/ctrlp.vim'               " CtrlP filesearch?
    Plug 'ntpeters/vim-better-whitespace'   " Whitespace Highlighting.
    Plug 'scrooloose/nerdtree'              " Filesystem tree
    Plug 'Xuyuanp/nerdtree-git-plugin'      " NERDTree git plugin
    Plug 'jistr/vim-nerdtree-tabs'          " NERDTree with tabs!
    Plug 'vim-airline/vim-airline'          " Status bar
    Plug 'vim-airline/vim-airline-themes'   " themes for Status bar
    Plug 'powerline/fonts'                  " Powerline symbols appear
    Plug 'tpope/vim-fugitive'               " git stuff
    Plug 'jeetsukumaran/vim-buffergator'    " A buffer of buffers!
    Plug 'mhinz/vim-startify'               " Fancy start screen
    Plug 'tpope/vim-surround'               " Surroundings!
    Plug 'tpope/vim-repeat'                 " Repeat plugin actions
    Plug 'ervandew/supertab'                " tab completion with TAB key
    "Plug 'mattn/gist-vim'                   " create gists easy needs:
    "Plug 'mattn/webapi-vim'                 " Omterface tp WEB APIs

call plug#end()

""""""""""""""""""""
"  END Plugin Manager
""""""""""""""""""""


"""""""""""""""""""""
"  Airline
""""""""""""""""""""
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1        " Smart tabline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'                      " Separator
let g:airline_right_sep = '◀'                     " Separator
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'

" here is an example of how you could replace the branch indicator with
" the current working directory, followed by the filename.
"  let g:airline_section_b = '%{getcwd()}'
"  let g:airline_section_c = '%t'

""""""""""""""""""""
"  END Airline
""""""""""""""""""""

"""""""""""""""""""
" vim-better-whitespace
""""""""""""""""""""

autocmd BufWritePre * StripWhitespace
""""""""""""""""""""
"  END vim-better-whitespace
""""""""""""""""""""

""""""""""""""""""""
"  Ctrl-p
""""""""""""""""""""

" let g:ctrlp_working_path_mode = '~/'
""""""""""""""""""""
"  END Ctrl-p
""""""""""""""""""""


""""""""""""""""""""
"  NERDTree
""""""""""""""""""""

" Start NERDTree automatically
autocmd vimenter * NERDTreeToggle
" (even when no file is specified)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Go to previous window (main buffer)
" autocmd VimEnter * wincmd p
" Close vim when last window is NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
noremap <Leader>n :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1
let g:NERDTreeWinSize = 25

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Making it pretty?
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
""""""""""""""""""""
"  END NERDTree
""""""""""""""""""""


""""""""""""""""""""
"  Buffergator
""""""""""""""""""""

autocmd vimenter * BuffergatorToggle
" Go to the window on the right
autocmd VimEnter * wincmd l
let g:buffergator_viewport_split_policy="b"
let g:buffergator_split_hsize=5
let g:buffergator_split_vsize=5
let g:buffergator_autoupdate=1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b <C-w>t:BuffergatorToggle<CR><C-w>l
""""""""""""""""""""
"  END Buffergator
""""""""""""""""""""

""""""""""""""""""""
"  Startify
""""""""""""""""""""

autocmd StdinReadPre * let s:std_in=1       " Start when no file is specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif
" Ctrl+n to start Startify
noremap <C-n> <C-w>n:Startify<CR>

" autocmd winNew Startify
""""""""""""""""""""
"  END Startify
""""""""""""""""""""
