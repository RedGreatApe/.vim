"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/


call plug#begin('~/.vim/plugged')

    Plug 'flazz/vim-colorschemes'           " Vim colorschemes

    Plug 'vim-perl/vim-perl'                " Perl syntax
    Plug 'vim-perl/vim-perl6'               " Perl6 syntax
    Plug 'tpope/vim-fugitive'               " git stuff

    Plug 'ctrlpvim/ctrlp.vim'               " CtrlP filesearch?
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

    Plug 'wikitopian/hardmode'              " Bring it on!

    "Plug 'mattn/gist-vim'                   " create gists easy needs:
    "Plug 'mattn/webapi-vim'                 " Omterface tp WEB APIs

call plug#end()

colorscheme badwolf


"""""""""""""""""""""
"  Airline
""""""""""""""""""""
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


"""""""""""""""""""
" vim-better-whitespace
""""""""""""""""""""
autocmd BufWritePre * StripWhitespace


""""""""""""""""""""
"  NERDTree
""""""""""""""""""""

" Start NERDTree automatically
autocmd vimenter * NERDTreeToggle
" (even when no file is specified)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

noremap <Leader>n :NERDTreeTabsToggle<CR>

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
"  Buffergator
""""""""""""""""""""
" Start Buffergator when vim starts
autocmd vimenter * BuffergatorToggle
" Go to the window on the right
autocmd VimEnter * wincmd l

nnoremap <leader>b <C-w>t:BuffergatorToggle<CR><C-w>l

let g:buffergator_viewport_split_policy="b"
let g:buffergator_split_hsize=5
let g:buffergator_split_vsize=5
let g:buffergator_autoupdate=1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1


""""""""""""""""""""
" CtrlP
""""""""""""""""""""
nnoremap <leader>p :CtrlPBuffer<CR>


""""""""""""""""""""
"  Startify
""""""""""""""""""""
" New split (horizontal) with Startify in it
noremap <C-n> <C-w>n:Startify<CR>

" Start when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif


""""""""""""""""""""
"  Hard Mode
""""""""""""""""""""
let g:HardMode_hardmodeMsg = "Bring it!"
let g:HardMode_easymodeMsg = "Wuss!"
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
