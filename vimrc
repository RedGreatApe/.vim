"===============================================================================
"   Settings:                                                                  =
"===============================================================================
set number             " show line numbers
set relativenumber     " show line number relative to current line
set cursorline         " Highlight current line
set cursorcolumn       " Highlight current column

set list               " Display invisible characters as:
set listchars=tab:▸-   " Tabs as ▸---
set listchars+=trail:● " Trailing space as ● ·
set matchpairs+=<:>    " match < and >

set cmdheight=2        " Command line height
set showcmd            " show typed command in command line
set laststatus=2       " windows will always have a status bar
set noshowmode         " Vim displays current mode, disable this
set showtabline=2      " Always show tab bar       (top)

set expandtab          " turn all tabs into spaces
set shiftwidth=4       " spaces for autoindents
set softtabstop=4      " number of spaces in tab when editing
set tabstop=4          " number of visual spaces per tab
set autoindent         " Automatically indent every new line
set smartindent        " smart auto indenting
set smarttab           " smart tab handling for indenting

set ignorecase         " case insensitive searching
set smartcase          " unless I use caps
set wildignorecase     " case insensitive wildmenu
set wildmenu           " completion with menu
set wildcharm=<C-z>

set hlsearch           " Highlight all matches in file when performing search
set incsearch          " Highlight the next match while still typing the pattern
set keywordprg=ack     " use ack with K, together with ack-vim

set noautoread         " together with :checktime, prompt to reload file
set confirm            " get a dialog when :q, :w, or :wq fails
set hidden             " able to hide modified buffers without saving
set splitbelow         " New split below the current one
set splitright         " New split to the right

set nobackup           " no backup~ files.
set noswapfile         " Write swap and backup files
set undofile           " keep an undo file (undo changes after closing)
set directory^=~/.vim/.swapfiles/
set undodir^=~/.vim/.swapfiles/

set backspace=indent,eol,start
set pastetoggle=<F3>   " Toggle set paste
set updatetime=2000    " swap file related, thus, 'modified elsewhere' related

source ~/.vim/files/statusline.vim

"===============================================================================
"   Autocommands:                                                              =
"===============================================================================
augroup vim_stuff " filetypes to vimrc. always open help to the most right
    autocmd!
    autocmd BufRead,BufEnter */doc/* wincmd L
    autocmd BufNewFile,BufRead,BufEnter *.vim,vimrc      setfiletype vim
augroup END

augroup filetype_missing " missing filetypes to some file types
    autocmd!
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
    " autocmd FocusLost   * :set norelativenumber
    " autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
    autocmd BufWritePre * call StripWhitespace()
augroup END

augroup MyColors
    autocmd!
    autocmd ColorScheme,VimEnter,BufEnter * call MyHighlights()
augroup END

"===============================================================================
"   Functions:       =
"===============================================================================
" Strip trailing whitespaces
" Taken from https://github.com/ntpeters
function! g:StripWhitespace()
    let whitespaces  = '[\u0009\u0020\u00a0\u1680\u180e\u2000-'
    let whitespaces .= '\u200b\u202f\u205f\u3000\ufeff]'
    let pattern      = whitespaces . '\+$'
    let line         = line(".")
    let column       = col(".")
    silent! execute ':0,' . line("$") . 's/' . pattern . '//e'
    call histdel('search', -1)
    call cursor(line, column)
endfunction

function! ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=80,100
    endif
endfunction

" used for copy/pasting dndbeyond
function! FixQuotes() abort
    let line = line(".")
    let col  = col(".")
    global!/\(===\)\|\(\[\[\)/s/’/'/g
    call histdel('search', -1)
    %s/”/"/ge
    call histdel('search', -1)
    %s/“/"/ge
    call histdel('search', -1)
    call cursor(line, col)
endfunction

function! MyHighlights() abort
    " a bit stronger than background   (234)
    " a bit stronger than cursorcolumn (235)
    highlight! IndentGuidesEven ctermbg=236
    highlight! IndentGuidesOdd  ctermbg=236
endfunction

"===============================================================================
"   Mappings:                                                                  =
"===============================================================================
nnoremap <Leader>cc :call ToggleColorColumn()<CR>
nnoremap <Leader>FQ :call FixQuotes()<CR>

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

nnoremap <Leader>b :ls<CR>:b *
nnoremap <Left> :bprevious<CR>
nnoremap <Right> :bnext<CR>

nnoremap <Leader>ev :e ~/.vim/vimrc<cr>
nnoremap <Leader>rv :source $MYVIMRC<cr>

nnoremap <Leader>y "+y
xnoremap <Leader>y "+y
xnoremap <Leader>y "+ygv
nnoremap <Leader>Y "+y$
nnoremap Y y$

nnoremap <silent> <Space> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> * *<C-o>zz
nnoremap n nzz
nnoremap N Nzz
cnoremap <expr> <Tab>   getcmdtype() == "/" ? "<C-g>" : getcmdtype() == "?" ? "<C-t>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" ? "<C-t>" : getcmdtype() == "?" ? "<C-g>" : "<S-Tab>"

nnoremap x "_x

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

"===============================================================================
" Plugins: =
"===============================================================================
syntax on
filetype plugin indent on
" Plugin Loading with vim-plug
call plug#begin('~/.vim/plugged')
    " Plug 'josuegaleas/jay'           " colorscheme
    Plug 'morhetz/gruvbox'                 " colorscheme
    Plug 'jiangmiao/auto-pairs'            " automatic parenthesizing in pairs
    Plug 'lifepillar/vim-mucomplete'       " completion
    Plug 'tpope/vim-commentary'            " Comment lines with text objects
    Plug 'tpope/vim-fugitive'              " use git commands in vim
    Plug 'tpope/vim-repeat'                " use '.' in supported plugin maps
    Plug 'tpope/vim-surround'              " quoting with text objects
    Plug 'mileszs/ack.vim'                 " run ack from vim
    Plug 'w0rp/ale'                        " Linter engine
    Plug 'vimwiki/vimwiki'                 " vimwiki
    Plug 'nathanaelkane/vim-indent-guides' " visually display indent levels
    Plug 'junegunn/fzf.vim'                " fzf ❤️ vim
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
call plug#end()

source ~/.vim/files/eqalignsimple.vim

"===============================================================================
"   Plugin Settings:                                                           =
"===============================================================================
" FZF settings
nnoremap <Leader>f :FZF<cr>
" nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>c :BCommits<cr>
nnoremap <Leader>l :BLines<cr>

" Mucomplete
let g:mucomplete#enable_auto_at_startup = 1
" set completeopt=longest,menuone,preview,noinsert
inoremap <expr> <Esc> mucomplete#popup_exit("\<Esc>")
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
set shortmess+=c       " Shut off completion messages
set showcmd            " show typed command in command line
set noshowmode         " Vim displays mode, disable this

" Undotree Settings
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc

" Vimwiki
nmap <C-h> <Plug>VimwikiGoBackLink
nmap <Leader><CR> <Plug>VimwikiVSplitLink
let g:vimwiki_folding      = 'list'
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }
let lmop                   = {}
let lmop.path              = '~/lmop'
let g:vimwiki_list         = [ mywiki , lmop ]

" vim indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level           = 1
let g:indent_guides_guide_size            = 1
let g:indent_guides_auto_colors           = 0

" colorscheme
set background=dark
colorscheme gruvbox

" Ack vim
nnoremap <silent> K yiw:Ack! <C-r>0<cr>

" ALE
nnoremap <Leader><Leader> :ALENextWrap<cr>zz
