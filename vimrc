" Settings:
set laststatus=2 showtabline=2 ruler
set tabstop=4    softtabstop=4 shiftwidth=4
set expandtab    autoindent
set number       relativenumber
set list         listchars=tab:▸-,trail:• " ▸- ● • o x
set hidden       noswapfile
set undofile     undodir=~/.vim/undodir/
set wildmenu     wildignorecase
set hlsearch     incsearch
set ignorecase   smartcase
set splitbelow   splitright
set autoread
set backspace=indent,eol,start
set vb t_vb=
set mouse=
" set cursorcolumn cursorline
set cursorline
set showcmd
set nocompatible

" Mappings:
nnoremap Q gq
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
nnoremap <silent><leader>json :%!python -m json.tool<cr>
nnoremap <right> :bn<cr>
nnoremap <left> :bp<cr>
" nnoremap <right> <right>
" nnoremap <left> <left>
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
cnoremap gblame Git blame

nnoremap <leader>note :split ~/scratch<cr>
nnoremap <leader>dump /SUPER<cr>oskip_load_external=>1,overwrite_modifications=>1,<esc>ZZ

" CCToggle:

command! CCToggle call CCToggle()
nnoremap <leader>t :CCToggle<cr>

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
augroup END

" Plugins:
filetype plugin on
syntax on
syntax enable

source ~/.vim/files/eqalignsimple.vim

call plug#begin('~/.vim/plugged')

    Plug 'mbbill/undotree',    { 'on': 'UndotreeToggle' }

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-dadbod'
    Plug 'tpope/vim-tbone'
    Plug 'tpope/vim-eunuch'

    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf',       { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/vim-journal'

    Plug 'vimwiki/vimwiki'
    Plug 'vim-airline/vim-airline'

call plug#end()

" Vimwiki
augroup back_previous " missing filetypes to some file types
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter * call BackspaceNMap()
augroup END

augroup goyo_limelight
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
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

" goyo
" let g:goyo_linenr = 1
let g:goyo_width  = 100
nnoremap <leader>goyo :Goyo<cr>

colorscheme seoul256

" FZF
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({
    \   'options': ['--layout=reverse']
    \ }), <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
    \   'options': ['--layout=reverse']
    \ }), <bang>0)

command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({
    \   'options': ['--layout=reverse']
    \ }), <bang>0)

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>b :Buffers<cr>

" DadBod
let g:time = 'postgres:///timemngt_rd'
let g:mein = 'postgres:///meinatikon_rd'
let g:tool = 'postgres:///onlinetools_rd'
let g:zms  = 'postgres:///zms_rd'
nnoremap <leader>psql :DB g:time
nnoremap <leader>mein :DB g:mein
nnoremap <leader>tool :DB g:tool
nnoremap <leader>zms :DB g:zms set search_path = 'anifit.de';

" vim-airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

command! ClearRegisters for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>

function! DiffQF(...)
    let commit = a:0 == 0 ? '' : a:1

    let command = 'git diff --name-only ' . commit
    let flist = system(command)
    let flist = split(flist, '\n')

    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    call setqflist(list)
    call setqflist([], 'a', {'title' : command})
    copen
endfunction

function! CommitQF(...)
    let commit = a:0 == 0 ? '' : a:1

    let command = 'git diff-tree --no-commit-id --name-only -r ' . commit
    let flist = system(command)
    let flist = split(flist, '\n')

    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    call setqflist(list)
    call setqflist([], 'a', {'title' : command})
    copen
endfunction

command! -nargs=1 Diff call DiffQF(<f-args>)
command! DiffMaster call DiffQF('master')
command! -nargs=1 GShow call CommitQF(<f-args>)


" set background=dark
" set showcmd hidden noswapfile nobackup
" set ttimeoutlen=0
" set matchpairs+=<:>
" set cmdheight=1
" set backspace=indent,eol,start
" set mouse=a
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
"     \ '' : 'S', 'v'  : 'Visual',
"     \ 't'  : 'T', 'V'  : 'V-Line',
"     \ 'S'  : 'S', '' : 'V-Bloc',
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

