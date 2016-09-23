set nocompatible                                     " Be VIMproved

set mouse=a                                          " Enable mouse
set mousefocus

set number                                           " Display line numbers

set ignorecase                                       " Use case insensitive search
set smartcase                                        " except when using capital letters

set autoindent                                       " Keep indentation on new line
set paste                                            " Always insert with paste enabled... always!
set tabstop=4                                        " An indentation level every four columns
set expandtab                                        " Converts all tabs typed into spacess
set shiftwidth=4                                     " Indent/outdent by four columns
set backspace=indent,eol,start                       " allow backspacing over everything in insert mode

set history=50                                       " keep 50 lines of command line history
set showcmd                                          " display incomplete commands

set incsearch                                        " Jump to search word as I type
set hlsearch                                         " Also switch on highlighting the last used search pattern.

set showmatch                                        " show matching bracets
set showfulltag

set showtabline=2                                    " Always show tab bar       (top)
set laststatus=2                                     " Always show status bar    (bottom)
set cmdheight=1
set ruler                                            " show the cursor position in status bar


set wildmenu                                         " Turn on wild menu, try typing :h and press <Tab>
set showcmd                                          " Display incomplete commands

set splitbelow                                       " New buffer below the current one
set hidden                                           " allow modified buffers to be hidden

set scrolloff=1                                      " Controls the number of
set sidescrolloff=5                                  " lines/chars to keep
set sidescroll=1                                     " visible before scrolling
set display+=lastline                                " show the last line that fits in window

set undofile                                         " keep an undo file (undo changes after closing)
set swapfile                                         " Write swap and backup files
set backup                                           " keep a backup file (restore to previous version)
set directory=$TMPDIR,~/tmp,~/.vim/tmp,/tmp,/var/tmp " Swap file location
set backupdir=$TMPDIR,~/tmp,~/.vim/tmp,/tmp,/var/tmp " backup file location

set tw=79                                            " width of document (used by gd)
set nowrap                                           " don't automatically wrap on load
set fo-=t                                            " don't automatically wrap text when typing

set list                                             " Show invisible characters
let &listchars  = "tab:>-,extends:>,"
let &listchars .= "precedes:<,nbsp:\u00b7"           " as these characters

syntax on                                            " Switch syntax highlighting on
au BufRead,BufNewFile *.zpt set filetype=html        " Template files (*.zpt) with html syntax

if exists('$TMUX')                                   " change the cursor shape depending on mode
  let &t_SI  = "\<Esc>Ptmux;\<Esc>\<Esc>]50;"        " see: vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
  let &t_SI .= "CursorShape=1\x7\<Esc>\\"
  let &t_EI  = "\<Esc>Ptmux;\<Esc>\<Esc>]50;"        " strings too long, used concatenation :) -red
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
nnoremap Y y$                                                       " make Y behave similarly to D and C
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'   " %% Gives directory of current file

nmap <C-h> <C-w>h                                                 " Navigate splits more easily
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <C-w>+ <C-w>+<SID>ws                   " Key repeat hack for resizing splits
nmap <C-w>- <C-w>-<SID>ws                   " <C-w>+++- vs <C-w>+<C-w>+<C-w>-
nmap <C-w>> <C-w>><SID>ws                   " see: http://www.vim.org/scripts/script.php?script_id=2223
nmap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nmap <SID>ws <Nop>

command! Q q " Bind :Q to :qi               " Allow for common typoes
command! W w " Bind :W to :w                " on quit/write
command! Qall qall

nmap <leader>w :w<CR>                       " write file
nmap <leader>q :bd<CR>                      " Delete buffer

nnoremap <F3> :noh<CR>                      " Clear search highlighting

function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
nnoremap <silent><F6> :call g:ToggleColorColumn()<CR>

inoremap <C-U> <C-G>u<C-U>                                      " CTRL-U in insert mode deletes a lot!
                                                                " Use CTRL-G u  to first break undo,
                                                                " so that you can undo CTRL-U
                                                                " after inserting a line break.


""""""""""""""""""""
" END Mappings
""""""""""""""""""""


""""""""""""""""""""
"  Plugin Manager
""""""""""""""""""""
call plug#begin('~/.vim/plugged')

    Plug 'vim-perl/vim-perl'                " Perl syntax
    Plug 'vim-perl/vim-perl6'               " Perl6 syntax
    Plug 'kien/ctrlp.vim'                   " CtrlP filesearch?
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

let g:ctrlp_working_path_mode = '/home/rd/'
""""""""""""""""""""
"  END Ctrl-p
""""""""""""""""""""


""""""""""""""""""""
"  NERDTree
""""""""""""""""""""

autocmd vimenter * NERDTreeToggle                   " Start NERDTree automatically
autocmd StdinReadPre * let s:std_in=1               " (even when no file is specified)
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * wincmd p                         " Go to previous window
" Close vim when last window is NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <Leader>n <plug>NERDTreeTabsToggle<CR>
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

""""""""""""""""""""
"  END NERDTree
""""""""""""""""""""


""""""""""""""""""""
"  Buffergator
""""""""""""""""""""

" autocmd vimenter * BuffergatorToggle            " Start Buffergator when vim starts
" autocmd VimEnter * wincmd p                     " Go to previous window
let g:buffergator_viewport_split_policy="b"
let g:buffergator_split_hsize=5
let g:buffergator_split_vsize=5
let g:buffergator_autoupdate=1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1          " we only use <leader>b so don't claim the others
nmap <leader>b :BuffergatorToggle<CR>
""""""""""""""""""""
"  END Buffergator
""""""""""""""""""""

""""""""""""""""""""
"  Startify
""""""""""""""""""""

autocmd StdinReadPre * let s:std_in=1       " Start when no file is specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif
map <C-n> :Startify<CR>               " Ctrl+n to start Startify

" autocmd winNew Startify
""""""""""""""""""""
"  END Startify
""""""""""""""""""""

