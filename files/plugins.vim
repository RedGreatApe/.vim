"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/

" Plugin Loading ---------------------- {{{
call plug#begin('~/.vim/plugged')

    Plug 'flazz/vim-colorschemes'           " Vim colorschemes

    Plug 'vim-perl/vim-perl'                " Perl syntax
    Plug 'vim-perl/vim-perl6'               " Perl6 syntax
    Plug 'tpope/vim-fugitive'               " git stuff

    Plug 'ctrlpvim/ctrlp.vim'               " CtrlP filesearch?
    Plug 'mileszs/ack.vim'                  " Ack in vim!
    Plug 'scrooloose/nerdtree'              " Filesystem tree
    Plug 'Xuyuanp/nerdtree-git-plugin'      " NERDTree git plugin
    Plug 'jistr/vim-nerdtree-tabs'          " NERDTree with tabs!
    Plug 'vim-airline/vim-airline'          " Status bar
    Plug 'vim-airline/vim-airline-themes'   " themes for Status bar
    Plug 'jeetsukumaran/vim-buffergator'    " A buffer of buffers!
    Plug 'mhinz/vim-startify'               " Fancy start screen

    Plug 'ntpeters/vim-better-whitespace'   " Whitespace Highlighting.
    Plug 'tpope/vim-surround'               " Surroundings!
    Plug 'ervandew/supertab'                " tab completion with TAB key
    Plug 'tpope/vim-repeat'                 " Repeat plugin actions
    Plug 'duff/vim-scratch'                 " Scratch window, wont be saved
    Plug 'sjl/gundo.vim'                    " Undo tree viewer

    Plug 'wikitopian/hardmode'              " Bring it on!

    "Plug 'mattn/gist-vim'                   " create gists easy needs:
    "Plug 'mattn/webapi-vim'                 " Omterface tp WEB APIs

call plug#end()
" }}}

" Colorschemes settings ---------------------- {{{
colorscheme badwolf
" }}}

" Airline Settings ---------------------- {{{
let g:airline_detect_modified=1                     " Detects if file has been modified
let g:airline_detect_paste=1                        " Detects if set paste is enabled
let g:airline_inactive_collapse=1                   " Inactive windows dont show full path of file
let g:airline_theme='badwolf'
" let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_section_c = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

let g:airline#extensions#tabline#enabled = 1        " Smart tabline
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '◀'

let g:airline_left_sep = '▶'                        " Separator
let g:airline_right_sep = '◀'                       " Separator
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
" }}}

" Better Whitespace Settings ---------------------- {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" NERDTree Settings ---------------------- {{{
augroup nerdtree
    autocmd!
    " Start NERDTree automatically
    autocmd vimenter * NERDTreeToggle
    " (even when no file is specified)
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

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
" }}}

" Buffergator Settings ---------------------- {{{
augroup buffergator
    autocmd!
    " Start Buffergator when vim starts
    autocmd vimenter * BuffergatorToggle
    " Go to the window on the right
    autocmd VimEnter * wincmd l
augroup END

nnoremap <Leader>b <C-w>t:BuffergatorToggle<CR><C-w>l

let g:buffergator_viewport_split_policy="b"
let g:buffergator_split_hsize=5
let g:buffergator_split_vsize=5
let g:buffergator_autoupdate=1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
" }}}

" CtrlP Settings ---------------------- {{{
nnoremap <Leader>p :CtrlPBuffer<CR>
" }}}

" Startify Settings ---------------------- {{{
" New split (horizontal) with Startify in it
noremap <C-n> <C-w>v:Startify<CR>

augroup startify
    autocmd!
    " Start when no file is specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif
augroup END
" }}}

" Hard Mode Settings ---------------------- {{{
let g:HardMode_hardmodeMsg = "Bring it!"
let g:HardMode_easymodeMsg = "Wuss!"
nnoremap <Leader>h <Esc>:call ToggleHardMode()<CR>
" augroup hardmode
"     autocmd!
"     autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" augroup END
" }}}

" Scratch Settigns ------------------------ {{{
nnoremap <Leader>sc :Sscratch<CR><C-w>L
" }}}

" Gundo Settings -------------------------- {{{
nnoremap <F5> :GundoToggle<CR>
" }}}
