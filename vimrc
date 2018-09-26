" SETTINGS:
set nocompatible
set ttimeoutlen=0
set matchpairs+=<:>
set noshowmode laststatus=2 showtabline=2
set cmdheight=1
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
set mouse=a
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

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
nnoremap <space> <leader>
" nnoremap <C-?> <C-^>
nnoremap <silent><leader>json :%!python -m json.tool<cr>

cnoremap <expr> w!! 'w !sudo tee % > /dev/null'

" CCToggle
command! CCToggle call CCToggle()
function! g:CCToggle()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=80,100
    endif
endfunction

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
    autocmd BufNewFile,BufRead,BufEnter *.js             setfiletype javascript
    autocmd BufNewFile,BufRead,BufEnter *.zpt            setfiletype html
    autocmd BufNewFile,BufRead,BufEnter *.css            setfiletype css
    autocmd BufNewFile,BufRead,BufEnter *.sql            setfiletype sql
    autocmd BufNewFile,BufRead,BufEnter *.sh,sam,.bashrc setfiletype sh
    autocmd BufNewFile,BufRead,BufEnter *.t,*.pm,*.pl    setfiletype perl
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
    " Plug 'arcticicestudio/nord-vim'
    Plug 'AlessandroYorba/Despacio'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
call plug#end()

" Vimwiki
augroup back_previous " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter * call BackspaceNMap()
augroup END

function! BackspaceNMap() abort
    if &ft == 'vimwiki'
        nnoremap <C-h> :VimwikiGoBackLink<CR>
    else
        nnoremap <C-h> <C-^>
    endif
endfunction

let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let lmop                   = {}
let lmop.path              = '~/lmop'
let g:vimwiki_list         = [ mywiki , lmop ]

" Undotree
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
function! MyHighlights() abort
    highlight! link Statusline TablineSel
    highlight! Comment ctermfg=6
endfunction
augroup MyColors
    autocmd!
    autocmd ColorScheme,VimEnter,BufEnter * call MyHighlights()
augroup END
" colorscheme nord
colorscheme despacio

" FZF
nnoremap \f :call fzf#run(fzf#wrap({'source': 'git ls-files'}))<cr>

