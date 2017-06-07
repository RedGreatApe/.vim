"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/
" Plugin Loading {{{
" using dein.vim
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . "/.vim")
    call dein#add('Shougo/dein.vim')                  " dein.vim manages itself

    call dein#add('airblade/vim-gitgutter')           " git diff symbols in gutter
    call dein#add('AlessandroYorba/Alduin')           " colorscheme
    call dein#add('ctrlpvim/ctrlp.vim')               " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')             " Insert or delete brackets/parens/etc in pairs
    call dein#add('justinmk/vim-sneak')               " The missing motion for Vim (f and t with two characters)
    call dein#add('mbbill/undotree')                  " Undo tree history visualizer
    call dein#add('mhinz/vim-startify')               " The fancy start screen for vim
    call dein#add('Shougo/deoplete.nvim')             " Dark powered aasynchronouse completion framework for neovim
    call dein#add('tpope/vim-commentary')             " Comment stuff out
    call dein#add('tpope/vim-fugitive')               " A Git wrapper
    call dein#add('tpope/vim-repeat')                 " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')               " quoting/parenthesizing made simple
    call dein#add('tpope/vim-vinegar')                " combine with netrw to create a delicious salad dressing
    call dein#add('kshenoy/vim-signature')            " Plugin to toggle, display and navigate marks
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

colorscheme alduin

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
let g:undotree_WindowLayout         = 4
" let g:undotree_RelativeTimestamp    = 1

" navigate the undotree with k and j
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc
" }}}

" Vinegar Settings {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

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

" fugitive {{{
cnoremap <expr> gdiff 'Gdiff'
cnoremap <expr> gblame 'Gblame'
" }}}

" vim-signature Settings {{{
" SignatureIncludeMarkers controls marks created by 0-9
let g:SignatureIncludeMarkers    = '=!"#$%&/()'
let g:SignatureMarkTextHLDynamic = 1
" }}}

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
