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
set directory^=~/.vim/swapfiles/
set undodir^=~/.vim/swapfiles/

set foldlevelstart=99  " Don't start new buffers folded
set mouse=a
set keywordprg=ack     " use ack with K, together with ack-vim

if !has('nvim')
    source ~/.vim/files/settings.vim
endif

"=================================================================
"   Autocommands:                                                =
"=================================================================
augroup vim_stuff
    " filetypes to vimrc and help files. always open help to the most right
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter vimrc setfiletype vim
    autocmd FileType vim setlocal foldmethod=marker
    autocmd BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
augroup END

augroup filetype_missing " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.vim     setfiletype vim
    autocmd BufNewFile,BufRead,BufEnter *.js      setfiletype javascript
    autocmd BufNewFile,BufRead,BufEnter *.zpt     setfiletype html
    autocmd BufNewFile,BufRead,BufEnter *.css     setfiletype css
    autocmd BufNewFile,BufRead,BufEnter .bashrc   setfiletype sh
    autocmd BufNewFile,BufRead,BufEnter *.pm,*.pl setfiletype perl
augroup END

augroup editor_stuff
    autocmd!
    autocmd FocusLost   * :wa
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

function! ToggleColorColumn()
    if &colorcolumn != '' | setlocal colorcolumn&
    else                  | setlocal colorcolumn=81,101
    endif
endfunction

"=================================================================
"   Mappings:                                                    =
"=================================================================
nnoremap <silent><Leader>cc :call ToggleColorColumn()<CR>

nnoremap <silent><C-s> :update<CR>
imap     <silent><C-s> <Esc><C-s>
vmap     <silent><C-s> <Esc><C-s>
nnoremap <silent><C-q> :q<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <silent><Leader>v :vsplit<CR>
nnoremap <silent><Leader>s :split<CR>
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Home> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

nmap Y y$
nnoremap <silent><leader>ev :e ~/.vim/vimrc<cr>
nnoremap <silent><leader>rv :source $MYVIMRC<cr>
nnoremap <silent><leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <silent><leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>
noremap  <leader>y "+y
noremap  <leader>p "+p
vnoremap <leader>y "+ygv

nnoremap <silent><Space> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> * *<C-o>zz
nnoremap n nzz
nnoremap N Nzz

nnoremap <silent><leader>lb :buffers<CR>
nnoremap <silent><leader>lr :registers<CR>
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
    call dein#add('ctrlpvim/ctrlp.vim')            " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')          " Insert or delete brackets/parens/etc in pairs
    call dein#add('tpope/vim-commentary')          " Comment stuff out with text objects
    call dein#add('tpope/vim-fugitive')            " A Git wrapper, use git commands in vim
    call dein#add('tpope/vim-repeat')              " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')            " quoting/parenthesizing made simple with text objects
    call dein#add('tpope/vim-vinegar')             " combine with netrw to create a delicious salad dressing
    call dein#add('mileszs/ack.vim')               " run ack from vim, together with K and keywordprg
    call dein#add('w0rp/ale')                      " Linter engine, used for Perl and Javascript
    call dein#add('mbbill/undotree')               " Undo tree history visualizer (MARKED FOR DELETION)
    call dein#add('vimwiki/vimwiki')               " vimwiki (MARKED FOR DELETION)

    if has('nvim')
        call dein#add('Shougo/deoplete.nvim')      " Dark powered aasynchronouse completion framework for neovim
    endif

    " call dein#add('AlessandroYorba/Alduin')           " colorscheme (MARKED FOR DELETION)
    " call dein#add('AlessandroYorba/Sierra')           " colorscheme (MARKED FOR DELETION)
call dein#end()

if dein#check_install() | call dein#install() | endi " Install not installed plugins on startup

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
let g:airline_mode_map         = {
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

" Vinegar Settings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

if has('nvim')
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
nmap <C-h> <Plug>VimwikiGoBackLink

let g:vimwiki_folding      = 'list'
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }
let dnd                    = {}
let dnd.path               = '/run/media/rd/imageUSB/vimwiki'
let g:vimwiki_list         = [ mywiki , dnd ]

" ALE
nnoremap <leader><leader> :ALENextWrap<cr>zz
nnoremap <leader>N :ALEPreviousWrap<cr>zz

silent! helptags ALL
