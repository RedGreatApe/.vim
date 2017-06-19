"=============================================================================
" Description: RedGreatApe's .virmc
" Author:      RedGreatApe
" Really:      René De Alvarado
" URL:         https://github.com/redgreatape/.vim
"=============================================================================

if &compatible | set nocompatible | endif
" let g:mapleader="\"

"=================================================================
"   Settings:                                                    =
"=================================================================
" Cursor shape (bar when in insert mode)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
set t_ut=              " fixes the drawing issue while using tmux (Most of the time)

set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
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
if !has('nvim')
    source ~/.vim/files/settings.vim
endif

"=================================================================
"   Autocommands:                                                =
"=================================================================
" fold Vimscript files {{{
" create one for vimwiki?
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=999
augroup END
" }}}

" Help window {{{
augroup help_window
    autocmd!
    autocmd BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
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

"=================================================================
"   Functions:                                                   =
"=================================================================
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
function! ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
" }}}

"=================================================================
"   TabLine:                                                     =
"=================================================================
function! TLInit() abort
    if tabpagenr('$') ==# 1
        let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
        let &showtabline = len(l:bufs) ># 1 ? 2 : &showtabline
        set tabline=%!MyBufLine()
    else
        set showtabline=2
        set tabline=%!MyTabLine()
    endif
endfunction

    "=================================================================
    "   Bufs:                                                        =
    "=================================================================
function! MyBufLine() abort
    let l:tabline = '%#Tabline#'
    let l:buffers = GetVisibleBuffers()

    for l:bufno in l:buffers
        let l:mod = (getbufvar(l:bufno, '&modified') ==# 1 ? ' +' : '')
        let l:name = GetBufName(l:bufno, l:mod)
        if l:bufno ==# bufnr('%')      " active buffer
            let l:tabline .= '%#TabLineSel# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:name
            let l:tabline .= ' %#TabLineFill# '
        else
            let l:tabline .= '%#TabLine# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:name
            let l:tabline .= ' %#TabLineFill# '
        endif
    endfor
    if has('tablineat')
        let l:tabline .= '%@Clickbuf@%X'
    endif

    let l:tabline .='%=%#TabLineSel# Buffers '

    return l:tabline
endfunction

    "=================================================================
    "   Tabs:                                                        =
    "=================================================================
function! MyTabLine() abort
    let l:tabline = ''
    for i in range(tabpagenr('$'))
        let l:tabno = i + 1
        let l:tabline .= (l:tabno ==# tabpagenr()) ? ' %#TabLineSel#' : ' %#TabLine#'
        let l:tabline .= '%' . l:tabno . 'T '
        let l:tabline .= tabpagenr('$') >=# 5
                        \? fnamemodify(gettabvar(l:tabno, 'cwd'), ':t')
                        \: pathshorten(fnamemodify(gettabvar(l:tabno, 'cwd'), ':~'))
        let l:tabline .= ' %#TabLineFill#'
    endfor
    let l:tabline .= '%='
    let l:tabline .= '%' . tabpagenr() . 'X ' . '%#TabLineFill# X %X'
    let l:tabline .= '%#TabLineSel# Tabs %T'
    return l:tabline
endfunction

    "=================================================================
    "   Visible Buffers:                                             =
    "=================================================================
function! GetVisibleBuffers()
    let l:buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:cur = bufnr('%')
    let total_width = 0
    let max_width = 0

    return l:buffers
endfunction

function! GetBufName(bufno, mod)
    let l:name = pathshorten(fnamemodify(bufname(a:bufno), ':.'))
    let l:tag = ( !empty(l:name) ? l:name . a:mod : '[No Name]' . a:mod)
    return l:tag
endfunction

    "=================================================================
    "   Clickable Buffers:                                           =
    "=================================================================
" From vim-airline
" https://github.com/vim-airline/vim-airline/commit/d8d08ada7b58876c6a5ea0f895e122a2ac60bd17
function! Clickbuf(minwid, clicks, button, modifiers) abort
    if a:minwid ==# 0
        silent execute 'vsplit'
        return ''
    endif
    if a:clicks == 1 && a:modifiers !~# '[^ ]'
        if a:button is# 'l'
            silent execute 'buffer' a:minwid
        elseif a:button is# 'm'
            silent execute 'bdelete!' a:minwid
        endif
    endif
endfunction

"=================================================================
"   Mappings:                                                    =
"=================================================================
" Toggle ColorColumn {{{
nnoremap <silent><Leader>cc :call ToggleColorColumn()<CR>
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
nnoremap <silent><C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>
nnoremap <silent><C-q> :q<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
" }}}

nnoremap <silent><Leader>v :vsplit<CR>
nnoremap <silent><Leader>s :split<CR>

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
nnoremap <silent><leader>ev :args ~/.vim/vimrc<cr>
nnoremap <silent><leader>rv :source $MYVIMRC<cr>
nnoremap <silent><leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <silent><leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>
" }}}

" Searching {{{
nnoremap <silent><Space> :<C-u>nohlsearch<CR><C-l>
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
nnoremap <silent><leader>lb :buffers<CR>
nnoremap <silent><leader>lr :registers<CR>
" }}}

" Don't use register by x
nnoremap x "_x

" Del key now works inside neovim
map <F1> <del>
map! <F1> <del>

"=================================================================
"   Plugins:                                                     =
"=================================================================
" Plugin Loading {{{
" using dein.vim
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . "/.vim")
    call dein#add('Shougo/dein.vim')                  " dein.vim manages itself

    call dein#add('airblade/vim-gitgutter')           " git diff symbols in gutter
    call dein#add('AlessandroYorba/Alduin')           " colorscheme
    call dein#add('ctrlpvim/ctrlp.vim')               " Fuzzy file, buffer, mru, tag, etc finder
    " call dein#add('jiangmiao/auto-pairs')             " Insert or delete brackets/parens/etc in pairs
    " call dein#add('justinmk/vim-sneak')               " The missing motion for Vim (f and t with two characters)
    call dein#add('mbbill/undotree')                  " Undo tree history visualizer
    " call dein#add('mhinz/vim-startify')               " The fancy start screen for vim
    if has('nvim')
        call dein#add('Shougo/deoplete.nvim')             " Dark powered aasynchronouse completion framework for neovim
    endif
    call dein#add('tpope/vim-commentary')             " Comment stuff out
    call dein#add('tpope/vim-fugitive')               " A Git wrapper
    call dein#add('tpope/vim-repeat')                 " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')               " quoting/parenthesizing made simple
    call dein#add('tpope/vim-vinegar')                " combine with netrw to create a delicious salad dressing
    " call dein#add('kshenoy/vim-signature')            " Plugin to toggle, display and navigate marks
    call dein#add('vimwiki/vimwiki')                  " vimwiki (needed for taskwiki)
    " call dein#add('')
call dein#end()
filetype plugin indent on
syntax enable

" Install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
" }}}

set background=dark
highlight! link CursorColumn CursorLine
colorscheme alduin
highlight! link Whitespace FoldColumn

" CtrlP Settings {{{
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
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0

" navigate the undotree with k and j
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc
" }}}

" Vinegar Settings {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

if has('nvim')
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
endif

" Vimwiki {{{
" on my station, <backspace> is registered as C-h
" only on ST but del is messed up too, using konsole right now
nmap <C-h> <Plug>VimwikiGoBackLink

let g:vimwiki_folding='list'

let mywiki = {}
let mywiki.path = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }

let g:vimwiki_list = [ mywiki ]
" }}}

"=================================================================
"   StatusLine:                                                  =
"=================================================================

let g:look_up ={
        \ '__' : '-', 'n'  : 'N',
        \ 'i'  : 'I', 'R'  : 'R',
        \ 'v'  : 'V', 'V'  : 'V',
        \ 'c'  : 'C', '' : 'V',
        \ 's'  : 'S', 'S'  : 'S',
        \ '' : 'S', 't'  : 'T',
    \}
set statusline=
set statusline+=%(\ %{g:look_up[mode()]}%)
set statusline+=%(%{&paste?'\ p\ ':''}%)
if dein#tap('vim-fugitive')
    set statusline+=%(\ \ %{fugitive#head()}%)
endif
set statusline+=%(\ [%n]\ %<%F%)
set statusline+=\ %h%m%r%w
set statusline+=%=
set statusline+=%(\ %<\ \ %p%%\ ☰\ \ \ %l/%L\ \ :%c\ %)

"=================================================================
"   TabLine: (view %%functions.vim)                              =
"=================================================================

" From:
" https://github.com/KabbAmine/myVimFiles/blob/master/config/tabline.vim

" TODO
"   center (or scroll) buffer-tab so that the current buffer is displayed
"       If there are a lot of open buffers/tabs
"       and the current tab is one of the first
"       the selected tab will not be displayed

set showtabline=2
set tabline=

augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,BufEnter * call TLInit()
    autocmd TabEnter,TabClosed,TabNew,TabLeave * call TLInit()
    autocmd VimEnter * call TLInit()
augroup END
call TLInit()
