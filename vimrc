"=================================================================
"   Settings:                                                    =
"=================================================================
" Cursor shape (bar when in insert mode)

set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
set cursorcolumn       " Highlight current column
set noshowmode         " Vim displays mode (if in Insert, or Visual, etc), disable this

set list               " Display invisible characters as:
set listchars=tab:▸-   " Tabs as ▸---
set listchars+=trail:● " Trailing space as ·
set matchpairs+=<:>
set matchpairs+=«:»
set matchpairs+=｢:｣

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

set updatetime=250

set noautoread         " together with :checktime (and set confirm), prompt to reload file
set confirm            " get a dialog when :q, :w, or :wq fails
set hidden             " able to hide modified buffers without saving
set nobackup           " no backup~ files.
set noswapfile         " Write swap and backup files
set undofile           " keep an undo file (undo changes after closing)

set foldlevelstart=99  " Don't start new buffers folded

set mouse=a

set keywordprg=ack
if !has('nvim')
    source ~/.vim/files/settings.vim
endif

"=================================================================
"   Autocommands:                                                =
"=================================================================
augroup vim_stuff
    autocmd!
    autocmd BufNewFile,BufRead  vimrc    setfiletype vim
    autocmd FileType vim setlocal foldmethod=marker
    autocmd BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
augroup END

augroup editor_stuff
    autocmd!
    autocmd FocusLost * :wa
    autocmd FocusLost   * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber

" Detect file modified elsewhere
" forgot where i got it from :(
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
    autocmd BufWritePost,BufReadPost,BufLeave *
            \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
    if !has("gui_running")
        autocmd BufEnter,CursorMoved,CursorMovedI       * checktime
        autocmd FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
    autocmd BufWritePre * call StripWhitespace( 0, line("$") )
augroup END

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

"=================================================================
"   Functions:                                                   =
"=================================================================
" Changes outside vim/nvim
function! AS_HandleSwapfile (filename, swapname)
    if getftime(v:swapname) < getftime(a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    endif
endfunction

" Strip trailing whitespaces
" Taken from https://github.com/ntpeters
let g:whitespace_group='[\u0009\u0020\u00a0\u1680\u180e\u2000-\u200b\u202f\u205f\u3000\ufeff]'
let g:eol_whitespace_pattern = g:whitespace_group . '\+$'
function! g:StripWhitespace( line1, line2 )
    let _s = @/
    let l  = line(".")
    let c  = col(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/' . g:eol_whitespace_pattern . '//e'
    let @/=_s
    call cursor(l, c)
endfunction

" Toggle ColorColumn
function! ToggleColorColumn()
    if &colorcolumn != '' | setlocal colorcolumn&
    else                  | setlocal colorcolumn=81,101
    endif
endfunction

function! MyHighlights() abort
    highlight! LineNr       ctermfg=242  ctermbg=232
    highlight! CursorLineNR ctermfg=254  ctermbg=237 gui=NONE guifg=NONE

    highlight! CursorLine   ctermfg=NONE ctermbg=235 cterm=NONE

    highlight! Whitespace   ctermfg=239  ctermbg=232
    highlight! Search       ctermfg=250  ctermbg=240

    " highlight! Folded

    highlight! link Visual Search
    highlight! link CursorColumn CursorLine
    highlight! link ColorColumn  CursorLine
    highlight! link WildMenu Search
    highlight! link MatchParen TermCursor
endfunction
call MyHighlights()

"=================================================================
"   Mappings:                                                    =
"=================================================================
" Toggle ColorColumn
nnoremap <silent><Leader>cc :call ToggleColorColumn()<CR>

" Save and quit
nnoremap <silent><C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>
nnoremap <silent><C-q> :q<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'

nnoremap <silent><Leader>v :vsplit<CR>
nnoremap <silent><Leader>s :split<CR>

" Command line History
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Editing
nnoremap Y y$
nnoremap <silent><leader>ev :args ~/.vim/vimrc<cr>
nnoremap <silent><leader>rv :source $MYVIMRC<cr>
nnoremap <silent><leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <silent><leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>

" Searching
nnoremap <silent><Space> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> * *<C-o>

nnoremap <silent><leader>lb :buffers<CR>
nnoremap <silent><leader>lr :registers<CR>

nnoremap x "_x

" clipboard yank
noremap <leader>y "+y
vnoremap <leader>y "+ygv

" buffer navigation
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Home> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

"=================================================================
"   Plugins:                                                     =
"=================================================================
" Plugin Loading
" using dein.vim
syntax off
filetype plugin indent on
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . "/.vim")
    call dein#add('Shougo/dein.vim')          " dein.vim manages itself

    call dein#add('vim-airline/vim-airline')
    call dein#add('ctrlpvim/ctrlp.vim')       " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')     " Insert or delete brackets/parens/etc in pairs
    call dein#add('mbbill/undotree')          " Undo tree history visualizer
    if has('nvim')
        call dein#add('Shougo/deoplete.nvim') " Dark powered aasynchronouse completion framework for neovim
    endif
    call dein#add('tpope/vim-commentary')     " Comment stuff out
    call dein#add('tpope/vim-fugitive')       " A Git wrapper
    call dein#add('tpope/vim-repeat')         " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')       " quoting/parenthesizing made simple
    call dein#add('tpope/vim-vinegar')        " combine with netrw to create a delicious salad dressing
    call dein#add('vimwiki/vimwiki')          " vimwiki (needed for taskwiki)
    call dein#add('mileszs/ack.vim')          " run ack from vim

    " call dein#add('AlessandroYorba/Alduin')           " colorscheme
    " call dein#add('AlessandroYorba/Sierra')           " colorscheme
call dein#end()

" Install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

source ~/.vim/files/eqalignsimple.vim
source ~/.vim/files/foldsearches.vim
source ~/.vim/files/yankmatches.vim

"=================================================================
"   Plugin Settings:                                             =
"=================================================================

nnoremap <silent> K yiw:Ack! <C-r>0<cr>

" Search Folding
nmap <silent> <expr>  <leader>zz  FS_ToggleFoldAroundSearch({'context':1})
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  <leader>zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  <leader>za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc,vimrc nmap <silent> <expr>  <leader>zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc,vimrc nmap <silent> <expr>  <leader>za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr> zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" colorscheme sierra

" Airline settings
let g:airline_theme            = 'minimalist'

let g:airline_mode_map         = {
    \ '__' : '-',   'n'  : ' N ', 'i'  : ' I ',
    \ 'R'  : ' R ', 'c'  : ' C ', 'v'  : ' V ',
    \ 'V'  : ' V ', '' : ' V ', 's'  : ' S ',
    \ 'S'  : ' S ', '' : ' S ',
    \ }

if !exists('g:airline_symbols')
    let g:airline_symbols      = {}
endif
" let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.paste    = 'ρ'
let g:airline_symbols.branch   = '⎇'
let g:airline_section_x        = ''
let g:airline_section_y        = '[%n]'
let g:airlilne_section_z       = '%p%% ☰ %l/%L  :%c '
let g:airline_extensions       = ['tabline', 'branch', 'quickfix']

let g:airline#extensions#tabline#enabled = 1

" CtrlP Settings
let g:ctrlp_by_filename = 1         " <c-d> to toggle
let g:ctrlp_show_hidden = 1

" Undotree Settings
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0

" navigate the undotree with k and j
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc


" Vinegar Settings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
"

if has('nvim')
    " deoplete
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
    "
endif

" Vimwiki
" on my station, <backspace> is registered as C-h
" only on ST but del is messed up too, using konsole right now
nmap <C-h> <Plug>VimwikiGoBackLink

let g:vimwiki_folding='list'

let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }

let dnd      = {}
let dnd.path = '/run/media/rd/imageUSB/vimwiki'

let g:vimwiki_list = [ mywiki , dnd ]
