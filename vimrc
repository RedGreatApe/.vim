"=================================================================
"   Settings:                                                    =
"=================================================================

set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
set cursorcolumn       " Highlight current column
set noshowmode         " Vim displays mode (if in Insert, or Visual, etc), disable this

set list               " Display invisible characters as:
set listchars=tab:▸-   " Tabs as ▸---
set listchars+=trail:● " Trailing space as ● ·
set matchpairs+=<:>    " match < and >

set cmdheight=2        " Command line height
set showcmd            " show typed command in command line
set laststatus=2       " windows will always have a status bar
set showtabline=2      " Always show tab bar       (top)

set expandtab          " turn all tabs into spaces
set shiftwidth=4       " spaces for autoindents
set softtabstop=4      " number of spaces in tab when editing
set tabstop=4          " number of visual spaces per tab

set ignorecase         " case insensitive searching
set smartcase          " unless I use caps
set wildignorecase     " case insensitive wildmenu
set incsearch          " Highlight the next match while still typing the pattern
set pastetoggle=<F3>   " Toggle set paste

set splitbelow         " New split below the current one
set splitright         " New split to the right

set updatetime=250     " swap file related, thus, 'modified elsewhere' related
set noautoread         " together with :checktime (and set confirm), prompt to reload file
set confirm            " get a dialog when :q, :w, or :wq fails

set hidden             " able to hide modified buffers without saving
set nobackup           " no backup~ files.
set noswapfile         " Write swap and backup files
set undofile           " keep an undo file (undo changes after closing)
set directory^=~/.vim/.swapfiles/
set undodir^=~/.vim/.swapfiles/

set foldlevelstart=99  " Don't start new buffers folded
set mouse=a
set keywordprg=ack     " use ack with K, together with ack-vim

if !has('nvim') | source ~/.vim/files/settings.vim | endif

"=================================================================
"   Autocommands:                                                =
"=================================================================
augroup vim_stuff " filetypes to vimrc and help files. always open help to the most right
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter vimrc setfiletype vim
    autocmd FileType vim setlocal foldmethod=marker
    autocmd BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
augroup END

augroup filetype_missing " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.vim            setfiletype vim
    autocmd BufNewFile,BufRead,BufEnter *.js             setfiletype javascript
    autocmd BufNewFile,BufRead,BufEnter *.zpt            setfiletype html
    autocmd BufNewFile,BufRead,BufEnter *.css            setfiletype css
    autocmd BufNewFile,BufRead,BufEnter *.sql            setfiletype sql
    autocmd BufNewFile,BufRead,BufEnter *.lua            setfiletype lua
    autocmd BufNewFile,BufRead,BufEnter *.sh,sam,.bashrc setfiletype sh
    autocmd BufNewFile,BufRead,BufEnter *.t,*.pm,*.pl    setfiletype perl
augroup END

augroup editor_stuff
    autocmd!
    " autocmd FocusLost   * :wa
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
    autocmd BufWritePre * call StripWhitespace()
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
function! g:StripWhitespace()
    let l  = line(".")
    let c  = col(".")
    silent! execute ':' . 0 . ',' . line("$") . 's/' . g:eol_whitespace_pattern . '//e'
    call histdel('search', -1)
    call cursor(l, c)
endfunction

function! ToggleColorColumn()
    if &colorcolumn != '' | setlocal colorcolumn&
    else                  | setlocal colorcolumn=80,100
    endif
endfunction

"=================================================================
"   Mappings:                                                    =
"=================================================================
nnoremap <Leader>cc :call ToggleColorColumn()<CR>

nnoremap <C-s> :update<CR>
imap     <C-s> <Esc><C-s>
xmap     <C-s> <Esc><C-s>
nnoremap <C-q> :q<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>b :bprevious<CR>
nnoremap <Leader>n :bnext<CR>

nnoremap <Leader>ev :e ~/.vim/vimrc<cr>
nnoremap <Leader>rv :source $MYVIMRC<cr>
nnoremap <Leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <Leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
xnoremap <Leader>y "+y
xnoremap <Leader>p "+p
xnoremap <Leader>y "+ygv
nnoremap <Leader>Y "+y$
nnoremap Y y$

nnoremap <silent> <Space> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> * *<C-o>zz
nnoremap n nzz
nnoremap N Nzz

nnoremap <Leader>lb :buffers<CR>
nnoremap <Leader>lr :registers<CR>
nnoremap x "_x

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" =================================================================
" Plugins:                                                        =
" =================================================================
" Plugin Loading using dein.vim
syntax on
filetype plugin indent on
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . '/.vim')
    call dein#add('Shougo/dein.vim')               " dein.vim manages itself

    call dein#add('vim-airline/vim-airline')       " statusline and tabline
    call dein#add('machakann/vim-highlightedyank') " styling, highlight yanked stuff
    call dein#add('josuegaleas/jay')               " colorscheme
    " Other colorschemes I like:
    " https://github.com/fcpg/vim-farout
    " https://github.com/AlessandroYorba/alduin
    call dein#add('ctrlpvim/ctrlp.vim')            " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')          " Insert or delete brackets/parens/etc in pairs
    call dein#add('tpope/vim-commentary')          " Comment stuff out with text objects
    call dein#add('tpope/vim-fugitive')            " A Git wrapper, use git commands in vim
    call dein#add('tpope/vim-repeat')              " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')            " quoting/parenthesizing made simple with text objects
    call dein#add('tpope/vim-eunuch')              " Vim sugar for the UNIX shell commands that need it the most.
    call dein#add('justinmk/vim-dirvish')          " Path navigator designed to work with Vim's built-in mechanisms
    call dein#add('justinmk/vim-syntax-extra')     " A collection of syntax definitions not yet shipped with stock vim.
    call dein#add('mileszs/ack.vim')               " run ack from vim, together with K and keywordprg
    call dein#add('w0rp/ale')                      " Linter engine, used for Perl and Javascript
    call dein#add('vimwiki/vimwiki')               " vimwiki (MARKED FOR DELETION)
    call dein#add('mbbill/undotree')               " Undo tree history visualizer (MARKED FOR DELETION)
    " call dein#add('junegunn/fzf', { 'rpt': './plugin', 'type' : 'raw' })
    call dein#add('junegunn/fzf.vim')
    " call dein#add('blueyed/vim-diminactive')          " dim inactive windows,
    " call dein#add('edkolev/tmuxline.vim')

    if has('nvim')
        call dein#add('Shougo/deoplete.nvim')      " Dark powered asynchronous completion framework for neovim
    endif

call dein#end()

if dein#check_install() | call dein#install() | endif " Install not installed plugins on startup

source ~/.vim/files/eqalignsimple.vim
source ~/.vim/files/foldsearches.vim

"=================================================================
"   Plugin Settings:                                             =
"=================================================================

" Ack vim
nnoremap <silent> K yiw:Ack! <C-r>0<cr>

set background=dark
colorscheme jay

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_mode_map        = {
    \ '__' : '-',   'n'  : ' N ', 'i'  : ' I ',
    \ 'R'  : ' R ', 'c'  : ' C ', 'v'  : ' V ',
    \ 'V'  : ' V ', '' : ' V ', 's'  : ' S ',
    \ 'S'  : ' S ', '' : ' S ',
    \ }

if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_symbols.readonly           = ''
let g:airline_symbols.paste              = 'ρ'
let g:airline_symbols.branch             = '⎇'
let g:airline_section_y                  = '%n'
let g:airlilne_section_z                 = '%p%% ☰ %l/%L  :%c '
let g:airline_extensions                 = ['tabline', 'branch', 'quickfix', 'ale']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled     = 1

" CtrlP Settings
let g:ctrlp_by_filename = 1         " <c-d> to toggle
let g:ctrlp_show_hidden = 1

" Undotree Settings
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc

" Dirvish Settings
let g:dirvish_mode = ':sort ,^.*[\/],'

if has('nvim')
    let g:deoplete#enable_at_startup = 1
    " use <Tab> to navigate the popup
    inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<tab>"
    inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<tab>"
endif

" Vimwiki
nmap <C-h> <Plug>VimwikiGoBackLink

let g:vimwiki_folding      = 'list'
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }
let dnd                    = {}
let dnd.path               = '/run/media/rd/imageUSB/vimwiki'
let g:vimwiki_list         = [ mywiki , dnd ]

" ALE
nnoremap <Leader><Leader> :ALENextWrap<cr>zz
nnoremap <Leader>N :ALEPreviousWrap<cr>zz

silent! helptags ALL
