" SETTINGS:
set nocompatible
set matchpairs+=<:>
set noshowmode laststatus=2 showtabline=2
set cmdheight=2
set tabstop=4 softtabstop=4 shiftwidth=4
set list listchars=tab:▸-,trail:●
set expandtab autoindent
set number relativenumber
set showcmd hidden noswapfile nobackup
set undofile undodir=~/.vim/.swapfiles/
set ignorecase smartcase
set wildmenu wildignorecase
set hlsearch incsearch
set splitbelow splitright
set backspace=indent,eol,start
set background=dark
set cursorcolumn cursorline

" STATUSLINE:
let g:look_up = {
    \ '__' : '-', 'n'  : 'Normal',
    \ 'R'  : 'R', 'i'  : 'Insert',
    \ '' : 'S', 'v'  : 'Visual',
    \ 't'  : 'T', 'V'  : 'V-Line',
    \ 'S'  : 'S', '' : 'V-Bloc',
    \ 's'  : 'S', 'c'  : 'Command',
\}

set statusline=
set statusline+=%(\ %{g:look_up[mode()]}\ %)
set statusline+=%(%{&paste?'p\ ':''}%)\|
set statusline+=%(\ %<%F\ %)
set statusline+=\ %h%m%r%w

nnoremap <silent> <Space> :<C-u>nohlsearch<CR><C-l>
command! CCToggle if &colorcolumn != '' | setlocal colorcolumn& | else | setlocal colorcolumn=80,100 | endif
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'

" WHITESPACE:
command! StripWhitespace call StripWhitespace()
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

augroup filetype_missing " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.js                  setfiletype javascript
    autocmd BufNewFile,BufRead,BufEnter *.zpt                 setfiletype html
    autocmd BufNewFile,BufRead,BufEnter *.css                 setfiletype css
    autocmd BufNewFile,BufRead,BufEnter *.sql                 setfiletype sql
    autocmd BufNewFile,BufRead,BufEnter *.lua                 setfiletype lua
    autocmd BufNewFile,BufRead,BufEnter *.sh,sam,.bashrc      setfiletype sh
    autocmd BufNewFile,BufRead,BufEnter *.t,*.pm,*.pl         setfiletype perl
    autocmd BufNewFile,BufRead,BufEnter *.t6,*.pm6,*.pl6,*.p6 setfiletype perl
augroup END

" PLUGINS:
filetype plugin on
syntax on

source ~/.vim/files/eqalignsimple.vim
call plug#begin('~/.vim/plugged')
    Plug 'vimwiki/vimwiki'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
call plug#end()

" Vimwiki
nmap <C-h> <Plug>VimwikiGoBackLink
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let lmop                   = {}
let lmop.path              = '~/lmop'
let g:vimwiki_list         = [ mywiki , lmop ]

" Undotree
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
colorscheme gruvbox
