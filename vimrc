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

source ~/.vim/files/statusline.vim
if !has('nvim') | source ~/.vim/files/settings.vim | endif

"=================================================================
"   Autocommands:                                                =
"=================================================================
augroup vim_stuff " filetypes to vimrc and help files. always open help to the most right
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd BufRead,BufEnter */doc/* if &filetype=='help' | wincmd L | endif
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
    autocmd FocusLost   * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
    autocmd BufWritePre * call StripWhitespace()
augroup END

"=================================================================
"   Functions:                                                   =
"=================================================================
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
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>

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

nnoremap x "_x

if has('nvim') | tnoremap <Esc> <C-\><C-n> | endif

" =================================================================
" Plugins:                                                        =
" =================================================================
" Plugin Loading with vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'josuegaleas/jay'               " colorscheme
    Plug 'jiangmiao/auto-pairs'          " Insert or delete brackets/parens/etc in pairs
    Plug 'lifepillar/vim-mucomplete'     "  Chained completion that works the way you want!
    Plug 'tpope/vim-commentary'          " Comment stuff out with text objects
    Plug 'tpope/vim-fugitive'            " A Git wrapper, use git commands in vim
    Plug 'tpope/vim-repeat'              " Enable repeating supported plugin maps with '.'
    Plug 'tpope/vim-surround'            " quoting/parenthesizing made simple with text objects
    Plug 'tpope/vim-eunuch'              " Vim sugar for the UNIX shell commands that need it the most.
    Plug 'justinmk/vim-dirvish'          " Path navigator designed to work with Vim's built-in mechanisms
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'junegunn/fzf.vim'              " fzf ❤️ vim
    Plug 'mileszs/ack.vim'               " run ack from vim, together with K and keywordprg
    Plug 'w0rp/ale'                      " Linter engine, used for Perl and Javascript
    Plug 'vimwiki/vimwiki'               " vimwiki
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree history visualizer (hardly use it, but VERY handy)
call plug#end()

source ~/.vim/files/eqalignsimple.vim
source ~/.vim/files/foldsearches.vim

"=================================================================
"   Plugin Settings:                                             =
"=================================================================
set background=dark
colorscheme jay

" FZF settings
nnoremap <Leader>f :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>l :Lines<cr>
nnoremap <Leader>c :Commits<cr>
nnoremap <Leader>w :Windows<cr>
nnoremap <Leader>cbc :BCommits<cr>
nnoremap <Leader>cbl :Lines<cr>

" Mucomplete
let g:mucomplete#enable_auto_at_startup = 1
set completeopt=longest,menuone,preview,noinsert
inoremap <expr> <Esc> mucomplete#popup_exit("\<Esc>")
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
set shortmess+=c       " Shut off completion messages
set showcmd            " show typed command in command line
set noshowmode         " Vim displays mode (if in Insert, or Visual, etc), disable this

" Undotree Settings
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc

" Ack vim
nnoremap <silent> K yiw:Ack! <C-r>0<cr>

" Dirvish Settings
let g:dirvish_mode = ':sort ,^.*[\/],'

" ALE
nnoremap <Leader><Leader> :ALENextWrap<cr>zz

" Vimwiki
nmap <C-h> <Plug>VimwikiGoBackLink
let g:vimwiki_folding      = 'list'
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let mywiki.nested_syntaxes = { 'perl': 'perl' }
let dnd                    = {}
let dnd.path               = '/run/media/rd/imageUSB/vimwiki'
let g:vimwiki_list         = [ mywiki , dnd ]

silent! helptags ALL
