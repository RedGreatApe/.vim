" Settings:
set laststatus=2 showtabline=2
set tabstop=4    softtabstop=4 shiftwidth=4
set expandtab    autoindent
set number       relativenumber
set list         listchars=tab:▸-,trail:●
set hidden       noswapfile
set undofile     undodir=~/.vim/undodir/
set wildmenu     wildignorecase
set hlsearch     incsearch
set ignorecase   smartcase
set splitbelow   splitright
set autoread
set backspace=indent,eol,start

" Mappings:
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
nnoremap <silent><leader>json :%!python -m json.tool<cr>
nnoremap <right> :bn<cr>
nnoremap <left> :bp<cr>
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'

" CCToggle:
command! CCToggle call CCToggle()
function! g:CCToggle()
    if &colorcolumn != '' | setlocal colorcolumn&
    else                  | setlocal colorcolumn=80,100
    endif
endfunction

" StripWhitespace:
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

" Autocmds:
augroup filetype_missing " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.js             setfiletype javascript
    autocmd BufNewFile,BufRead,BufEnter *.zpt            setfiletype html
    autocmd BufNewFile,BufRead,BufEnter *.css            setfiletype css
    autocmd BufNewFile,BufRead,BufEnter *.sql            setfiletype sql
    autocmd BufNewFile,BufRead,BufEnter *.sh,sam,.bashrc setfiletype sh
    autocmd BufNewFile,BufRead,BufEnter *.t,*.pm,*.pl    setfiletype perl
    autocmd BufNewFile,BufRead,BufEnter *.pm6,*.pl6,*.t6 setfiletype perl6
augroup END

" Plugins:
filetype plugin on
syntax on

source ~/.vim/files/eqalignsimple.vim

call plug#begin('~/.vim/plugged')
    Plug 'AlessandroYorba/Despacio'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf',       { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'mbbill/undotree',    { 'on': 'UndotreeToggle' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'vim-perl/vim-perl6', { 'for': 'perl6' }

    Plug 'tpope/vim-dadbod'
    Plug 'tpope/vim-tbone'
    Plug 'tpope/vim-eunuch'
call plug#end()

" Vimwiki
augroup back_previous " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter * call BackspaceNMap()
augroup END

function! BackspaceNMap() abort
    if &ft == 'vimwiki' | nnoremap <C-?> :VimwikiGoBackLink<CR>
    else                | nnoremap <C-?> <C-^>
    endif
endfunction

let mywiki         = {}
let mywiki.path    = '~/.vim/vimwiki'
let g:vimwiki_list = [ mywiki ]

" Undotree
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> j <plug>UndotreePreviousState
endfunc

colorscheme despacio
" colorscheme darkblue

" FZF
nnoremap \f :call fzf#run(fzf#wrap({'source': 'git ls-files'}))<cr>
nnoremap \b :Buffers<cr>

" DadBod
let g:time = 'postgres:///timemngt_rd'
nnoremap <leader>psql :DB g:time

" set background=dark
" set showcmd hidden noswapfile nobackup
" set nocompatible
" set ttimeoutlen=0
" set matchpairs+=<:>
" set cmdheight=1
" set backspace=indent,eol,start
" set cursorcolumn cursorline
" set mouse=a
" set showcmd
" set splitbelow splitright
" set noshowmode
" set viminfo+=n~/.vim/viminfo

" function! MyHighlights() abort
"     highlight! link Statusline TablineSel
"     highlight! Comment ctermfg=6
" endfunction

" augroup MyColors
"     autocmd!
"     autocmd ColorScheme,VimEnter,BufEnter * call MyHighlights()
" augroup END

" Statusline:
" let g:look_up = {
"     \ '__' : '-', 'n'  : 'Normal',
"     \ 'R'  : 'R', 'i'  : 'Insert',
"     \ '' : 'S', 'v'  : 'Visual',
"     \ 't'  : 'T', 'V'  : 'V-Line',
"     \ 'S'  : 'S', '' : 'V-Bloc',
"     \ 's'  : 'S', 'c'  : 'Command',
" \}

" set statusline=
" set statusline+=%(\ %{g:look_up[mode()]}\ %)
" set statusline+=%(%{&paste?'p\ ':''}%)\|
" set statusline+=%(\ %<%F\ %)
" set statusline+=%#warningmsg#
" set statusline+=%h%m%r%w
" set statusline+=%*
" set statusline+=%=%(%l,%c%V\ \ \ \ \ \ \ \ \ %=\ %P%)

