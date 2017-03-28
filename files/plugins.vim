"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/

" Plugin Loading {{{
" using dein.vim
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim
call dein#begin($HOME . '/.vim')
    call dein#add('Shougo/dein.vim')                " dein.vim manages itself

    call dein#add('airblade/vim-gitgutter')         " git diff symbols in gutter
    call dein#add('AlessandroYorba/Alduin')         " colorscheme
    call dein#add('ctrlpvim/ctrlp.vim')             " Fuzzy file, buffer, mru, tag, etc finder
    call dein#add('jiangmiao/auto-pairs')           " Insert or delete brackets/parens/etc in pairs
    call dein#add('justinmk/vim-sneak')             " The missing motion for Vim (f and t with two characters)
    call dein#add('mbbill/undotree')                " Undo tree history visualizer
    call dein#add('mhinz/vim-startify')             " The fancy start screen for vim
    call dein#add('ntpeters/vim-better-whitespace') " Better whitespace highlighting for vim
    call dein#add('tpope/vim-commentary')           " Comment stuff out
    call dein#add('tpope/vim-fugitive')             " A Git wrapper
    call dein#add('tpope/vim-repeat')               " Enable repeating supported plugin maps with '.'
    call dein#add('tpope/vim-surround')             " quoting/parenthesizing made simple
    call dein#add('tpope/vim-vinegar')              " combine with netrw to create a delicious salad dressing
    call dein#add('vim-airline/vim-airline')        " Lean & mean status/tabline for vim that's light as air
    call dein#add('vim-airline/vim-airline-themes') " A collection of themes for vim-airline
    call dein#add('kshenoy/vim-signature')          " Plugin to toggle, display and navigate marks
    " call dein#add('')
    " tyru/open-browser.vim
call dein#end()
filetype plugin indent on
syntax enable

" Install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
" }}}


" Colorscheme settings {{{
"    currently Alduin
let g:alduin_Shout_Become_Ethereal   = 0 " black background
let g:alduin_Contract_Vampirism      = 0 " gray to black @ 5pm
let g:alduin_Shout_Aura_Whisper      = 0 " underline matching parens
let g:alduin_Shout_Fire_Breath       = 0 " adds dark red color
let g:alduin_Shout_Animal_Allegiance = 1 " removes background from Strings
let g:alduin_Shout_Clear_Skies       = 0 " removes cursorline
colorscheme alduin                       " dark gray background
" }}}

" Airline Settings {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_detect_modified   = 1
let g:airline_detect_paste      = 1
let g:airline_inactive_collapse = 0
let g:airline_theme             = 'badwolf'
let g:airline_powerline_fonts   = 1
let g:airline_section_y         = 'BN: %{bufnr("%")}'
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
let g:airline_symbols.readonly  = ''
let g:airline_symbols.paste     = 'ρ'
"let g:airline_left_sep          = ''
"let g:airline_left_alt_sep      = ''
"let g:airline_right_sep         = ''
"let g:airline_right_alt_sep     = ''

let g:airline#extensions#ctrlp#color_template   = 'visual'
let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#buffers_label  = 'Buffers'
let g:airline#extensions#tabline#buffer_nr_show = 0
let airline#extensions#tabline#disable_refresh  = 0
let g:airline#extensions#whitespace#enabled     = 1
let g:airline#extensions#hunks#enabled          = 0
let g:airline#extensions#bufferline#enabled     = 0
let g:airline#extensions#capslock#enabled       = 0
let g:airline#extensions#csv#enabled            = 0
let g:airline#extensions#ctrlspace#enabled      = 0
let g:airline#extensions#eclim#enabled          = 0
let g:airline#extensions#nrrwrgn#enabled        = 0
let g:airline#extensions#promptline#enabled     = 0
let g:airline#extensions#syntastic#enabled      = 0
let g:airline#extensions#taboo#enabled          = 0
let g:airline#extensions#tagbar#enabled         = 0
let g:airline#extensions#virtualenv#enabled     = 0

" }}}

" Better Whitespace Settings {{{
" Strip trailing whitespaces when saving
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" CtrlP Settings {{{
" nnoremap <Leader>p :CtrlPBuffer<CR>
let g:ctrlp_by_filename         = 1         " <c-d> to toggle
let g:ctrlp_show_hidden         = 1
let g:ctrlp_open_multiple_files = '1vj'
let g:ctrlp_cache_dir = $HOME.'/.vim/repos/github.com/ctrlpvim/ctrlp.vim/.cache/'
" }}}

" Startify Settings {{{
noremap <Leader>n :Startify<CR>
noremap <Leader>N <C-w>v:Startify<CR>

let g:startify_list_order         = [
                                   \ ['    Most Recently Used Files.'], 'files',
                                   \ ['    Bookmarks'], 'bookmarks',
                                   \ ['    Sessions'], 'sessions']
let g:startify_bookmarks          = [
                                   \ {'r': '~/.vim/vimrc'},
                                   \ {'p': '~/.proverc'},
                                   \ {'c': '~/.bashrc'}, ]
let g:startify_files_number       = 15
let g:startify_update_oldfiles    = 1
let g:startify_change_to_dir      = 0
let g:startify_change_to_vcs_root = 1
let g:startify_padding_left       = 4
let g:startify_custom_indices     = ['a', 's', 'd', 'f', 'g', ]

autocmd! User Startified setlocal number
autocmd! User Startified setlocal relativenumber
autocmd! User Startified setlocal cursorline
" }}}

" Undotree Settings {{{
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout         = 4
let g:undotree_SetFocusWhenToggle   = 0
let g:undotree_RelativeTimestamp    = 1
let g:undotree_HighlightChangedText = 1

" navigate the undotree with k and j
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc
" }}}

" Vinegar Settings {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

" fugitive {{{
cnoremap <expr> gdiff 'Gdiff'
cnoremap <expr> gblame 'Gblame'
" }}}

" vim-signature Settings {{{
let g:SignatureMap = {
    \ 'Leader'             :  "m",
    \ 'PlaceNextMark'      :  "m,",
    \ 'ToggleMarkAtLine'   :  "m.",
    \ 'PurgeMarksAtLine'   :  "m-",
    \ 'DeleteMark'         :  "dm",
    \ 'PurgeMarks'         :  "m<Space>",
    \ 'PurgeMarkers'       :  "m<BS>",
    \ 'GotoNextLineAlpha'  :  "']",
    \ 'GotoPrevLineAlpha'  :  "'[",
    \ 'GotoNextSpotAlpha'  :  "`]",
    \ 'GotoPrevSpotAlpha'  :  "`[",
    \ 'GotoNextLineByPos'  :  "]'",
    \ 'GotoPrevLineByPos'  :  "['",
    \ 'GotoNextSpotByPos'  :  "]`",
    \ 'GotoPrevSpotByPos'  :  "[`",
    \ 'GotoNextMarker'     :  "]-",
    \ 'GotoPrevMarker'     :  "[-",
    \ 'GotoNextMarkerAny'  :  "]=",
    \ 'GotoPrevMarkerAny'  :  "[=",
    \ 'ListBufferMarks'    :  "m/",
    \ 'ListBufferMarkers'  :  "m?"
\ }

let g:SignatureIncludeMarkers    = '=!"#$%&/()'
let g:SignatureMarkTextHLDynamic = 1
" }}}
" }}}
