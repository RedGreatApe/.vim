"=============================================================================
" Description: RedGreatApe's NeoVim's configuration
" Author:      RedGreatApe
" Really:      René De Alvarado
" URL:         https://github.com/redgreatape/.vim
"=============================================================================
"      _   _                 _            ____                                  _
"     | | | | ___ _ __ ___  | |__   ___  |  _ \ _ __ __ _  __ _  ___  _ __  ___| |
"     | |_| |/ _ \ '__/ _ \ | '_ \ / _ \ | | | | '__/ _` |/ _` |/ _ \| '_ \/ __| |
"     |  _  |  __/ | |  __/ | |_) |  __/ | |_| | | | (_| | (_| | (_) | | | \__ \_|
"     |_| |_|\___|_|  \___| |_.__/ \___| |____/|_|  \__,_|\__, |\___/|_| |_|___(_)
"                                                         |___/


"              ____       _   _   _
"             / ___|  ___| |_| |_(_)_ __   __ _ ___
"             \___ \ / _ \ __| __| | '_ \ / _` / __|
"              ___) |  __/ |_| |_| | | | | (_| \__ \
"             |____/ \___|\__|\__|_|_| |_|\__, |___/
"                                         |___/
" {{{
if &compatible | set nocompatible | endif
" let g:mapleader="\"


" Cursor shape (bar when in insert mode)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
set list               " Display invisible characters as:
set listchars=tab:▸-   " Tabs as ▸---
set listchars+=trail:· " Trailing space as ·
set noshowmode         " Vim displays mode (if in Insert, or Visual, etc), disable this

set cmdheight=2        " Command line height
set showcmd            " show typed command in status bar
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


" }}}
"                 _         _                                                      _
"                / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"               / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"              / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"             /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
" {{{

" Filetype Perl {{{
augroup filetypeperl
    autocmd!
    autocmd FileType perl :iabbrev <buffer> dp use Data::Printer;
augroup END
" }}}

" Syntax Settings {{{
" *.zpt files to html syntax
augroup syntax_helper
    autocmd!
    autocmd BufRead,BufNewFile *.zpt setlocal filetype=html
augroup END
" }}}

" Vimscript file settings {{{
" fold Vimscript files
" high foldlevel needed for  za  to work
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=999
augroup END
" }}}

" Help window {{{
" Open in most right vertical split With number, With relativenumber
" needs work, when undotree (plug) is on
augroup help_window
    autocmd!
    autocmd FileType help wincmd L
    autocmd FileType help setlocal number
    autocmd FileType help setlocal relativenumber
augroup END
" }}}

" Save on focus lost {{{
augroup focus_lost
    autocmd!
    autocmd FocusLost * :wa
augroup END
" }}}

" Relativenumber {{{
augroup rnu_focus_change
    autocmd!
    autocmd FocusLost * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" Detect file modified elsewhere {{{
" forgot where i got it from :(
augroup AutoSwap
    autocmd!
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

autocmd BufWritePost,BufReadPost,BufLeave *
            \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorMoved,CursorMovedI * checktime
        autocmd FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
" }}}

" remove trailing whitespaces {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * call StripWhitespace( 0, line("$") )
augroup END
" }}}
" }}}
"              __  __                   _
"             |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"             | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"             | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"             |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                          |_|   |_|            |___/
" {{{

" Toggle ColorColumn {{{
nnoremap <silent><Leader>cc :call g:ToggleColorColumn()<CR>
" }}}

" Resizing Splits {{{
nmap          <C-W>+     <C-W>+<SID>ws
nmap          <C-W>-     <C-W>-<SID>ws
nn <script>   <SID>ws+   <C-W>+<SID>ws
nn <script>   <SID>ws-   <C-W>-<SID>ws
nmap          <C-W>>     <C-W>><SID>ws
nmap          <C-W><     <C-W><<SID>ws
nn <script>   <SID>ws>   <C-W>><SID>ws
nn <script>   <SID>ws<   <C-W><<SID>ws
nmap          <SID>ws    <Nop>
" }}}

" Save and quit {{{
nnoremap <C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>
nnoremap <C-q> :q<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
" }}}

" Buffer, Window (splits) and Tab navigation {{{
nnoremap <silent> gb :bnext<CR>
" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>


" use Alt keys and directionals {hklj} to change window,
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-h> <Esc><C-w>h
inoremap <A-l> <Esc><C-w>l
" }}}

" Command line History {{{
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}

" Editing {{{
nnoremap Y y$
nnoremap <leader>ev :args ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>
" }}}

" Searching {{{
nnoremap <silent> <Space> :<C-u>nohlsearch<CR><C-l>
" auto center {{{
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *<C-o>zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz
" }}}

" Buffer search
nnoremap <leader>lb :buffers<CR>
nnoremap <leader>lr :registers<CR>
" }}}

" Don't use register by x
nnoremap x "_x
" forget about ex mode >.>
nnoremap Q <NOP>

" Del key now works inside neovim
map <F1> <del>
map! <F1> <del>


" System clipboard interaction.  Mostly from:
" https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "+y
noremap <leader>p :set paste<CR>"+p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"+P<CR>:set nopaste<CR>
vnoremap <leader>y "+ygv
" }}}

"              _____                 _   _
"             |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
"             | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
"             |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
"             |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
" {{{

" Changes outside vim/nvim {{{
function! AS_HandleSwapfile (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    endif
endfunction
" }}}

" Strip trailing whitespaces {{{
" Taken from https://github.com/ntpeters
" Removes all extraneous whitespace in the file
let g:whitespace_group='[\u0009\u0020\u00a0\u1680\u180e\u2000-\u200b\u202f\u205f\u3000\ufeff]'
let g:eol_whitespace_pattern = g:whitespace_group . '\+$'
function! g:StripWhitespace( line1, line2 )
    " Save the current search and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")

    " Strip the whitespace
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/' . g:eol_whitespace_pattern . '//e'

    " Restore the saved search and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Toggle ColorColumn {{{
function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
" }}}

" }}}

"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/
" {{{
" Plugin Loading {{{
" using dein.vim
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . "/.vim")
    call dein#add('Shougo/dein.vim')                  " dein.vim manages itself

    call dein#add('airblade/vim-gitgutter')           " git diff symbols in gutter
    call dein#add('AlessandroYorba/Alduin')           " colorscheme
    call dein#add('ctrlpvim/ctrlp.vim')               " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')             " Insert or delete brackets/parens/etc in pairs
    call dein#add('justinmk/vim-sneak')               " The missing motion for Vim (f and t with two characters)
    call dein#add('mbbill/undotree')                  " Undo tree history visualizer
    call dein#add('mhinz/vim-startify')               " The fancy start screen for vim
    " call dein#add('ntpeters/vim-better-whitespace')   " Better whitespace highlighting for vim
    call dein#add('Shougo/deoplete.nvim')             " Dark powered aasynchronouse completion framework for neovim
    call dein#add('tpope/vim-commentary')             " Comment stuff out
    call dein#add('tpope/vim-fugitive')               " A Git wrapper
    call dein#add('tpope/vim-repeat')                 " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')               " quoting/parenthesizing made simple
    call dein#add('tpope/vim-vinegar')                " combine with netrw to create a delicious salad dressing
    call dein#add('vim-airline/vim-airline')          " Lean & mean status/tabline for vim that's light as air
    call dein#add('vim-airline/vim-airline-themes')   " A collection of themes for vim-airline
    call dein#add('kshenoy/vim-signature')            " Plugin to toggle, display and navigate marks
    call dein#add('vimwiki/vimwiki')                  " vimwiki (needed for taskwiki)
    " call dein#add('')
    " tyru/open-browser.vim
call dein#end()
filetype plugin indent on
syntax enable

" Install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
" }}}

" Colorscheme settings {{{
colorscheme alduin                       " dark gray background
" }}}

" Airline Settings {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme             = 'badwolf'
let g:airline_section_y         = 'BN: %{bufnr("%")}'
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
let g:airline_symbols.readonly  = ''
let g:airline_symbols.paste     = 'ρ'
"let g:airline_left_sep          = ''
"let g:airline_left_alt_sep      = ''
"let g:airline_right_sep         = ''
"let g:airline_right_alt_sep     = ''

let g:airline#extensions#ctrlp#color_template   = 'visual'
let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#buffers_label  = 'Buffers'
" }}}

" CtrlP Settings {{{
" nnoremap <Leader>p :CtrlPBuffer<CR>
let g:ctrlp_by_filename         = 1         " <c-d> to toggle
let g:ctrlp_show_hidden         = 1
" }}}

" Startify Settings {{{
noremap <Leader>n :Startify<CR>

let g:startify_list_order         = [
                                   \ ['    Most Recently Used Files.'], 'files',
                                   \ ['    Bookmarks'], 'bookmarks',
                                   \ ['    Sessions'], 'sessions']
let g:startify_bookmarks          = [
                                   \ {'w': '~/.vim/vimwiki/index.wiki'},
                                   \ {'W': '~/.vim/vimwiki/diary/diary.wiki'},
                                   \ {'P': '~/Documents/work/Protokoll/'},
                                   \ {'n': '~/.vim/nvimrc'},
                                   \ {'t': '~/.vim/tmux.conf.local'},
                                   \ {'T': '~/Repositories/Atikon/Test.pm'},
                                   \ {'p': '~/.proverc'},
                                   \ {'c': '~/.bashrc'}, ]
                                   " \ {'r': '~/Stuff/daily_routine'},
let g:startify_update_oldfiles    = 1
let g:startify_change_to_dir      = 0
let g:startify_change_to_vcs_root = 1
let g:startify_custom_indices     = ['a', 's', 'd', 'f', 'g', ]
" }}}

" Undotree Settings {{{
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 4
" let g:undotree_RelativeTimestamp    = 1

" navigate the undotree with k and j
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc
" }}}

" Vinegar Settings {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
" use <Tab> to navigate the popup
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" <BS>: close popup and delete backword char, and reopen popup
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
" <Esc>: close popup and exit insert mode
inoremap <expr> deoplete#close_popup()."\<Esc>"
inoremap <expr><Esc> deoplete#close_popup()."\<Esc>"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><CR> deoplete#close_popup()."\<CR>"

function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
" }}}

" fugitive {{{
cnoremap <expr> gdiff 'Gdiff'
cnoremap <expr> gblame 'Gblame'
" }}}

" vim-signature Settings {{{
" SignatureIncludeMarkers controls marks created by 0-9
let g:SignatureIncludeMarkers    = '=!"#$%&/()'
let g:SignatureMarkTextHLDynamic = 1
" }}}

" Vimwiki {{{
" on my station, <backspace> is registered as C-h
" only on ST but del is messed up too, using konsole right now
nmap <C-h> <Plug>VimwikiGoBackLink

let g:vimwiki_folding='list'

let mywiki = {}
let mywiki.path = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }
" let mywiki.html_template = '~/public_html/template.tpl'

let g:vimwiki_list = [ mywiki ]
" }}}
" }}}
"

"              _____                   _             _
"             |_   _|__ _ __ _ __ ___ (_)_ __   __ _| |
"               | |/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
"               | |  __/ |  | | | | | | | | | | (_| | |
"               |_|\___|_|  |_| |_| |_|_|_| |_|\__,_|_|

" {{{
augroup terminal_settings
    autocmd!
    autocmd BufEnter term://* startinsert
    autocmd BufEnter term://* setlocal nonumber
    autocmd BufEnter term://* setlocal norelativenumber
    autocmd FileType terminal setlocal nonumber
    autocmd FileType terminal setlocal norelativenumber
augroup END

let g:terminal_scrollback_buffer_size = 100000
" esc to exit to normal mode in terminal emulator
tnoremap <Esc> <C-\><C-n>

tnoremap <F1> <del>
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-l> <C-\><C-n><C-w>l
" }}}
