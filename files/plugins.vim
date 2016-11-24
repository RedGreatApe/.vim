"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/

" Plugin Loading ---------------------- {{{
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
filetype plugin on
" }}}

" Colorscheme settings ---------------------- {{{
"    currently Alduin
let g:alduin_Shout_Become_Ethereal = 0   " black background
let g:alduin_Contract_Vampirism = 0      " gray to black @ 5pm
let g:alduin_Shout_Aura_Whisper = 0      " underline matching parens
let g:alduin_Shout_Fire_Breath = 0       " adds dark red color
let g:alduin_Shout_Animal_Allegiance = 0 " removes background from Strings
let g:alduin_Shout_Clear_Skies = 0       " removes cursorline
colorscheme alduin                       " dark gray background
" }}}

" Airline Settings ---------------------- {{{
let g:airline_detect_modified=1                     " Detects if file has been modified
let g:airline_detect_paste=1                        " Detects if set paste is enabled
let g:airline_inactive_collapse=0                   " Inactive windows dont show full path of file
let g:airline_theme='badwolf'                       " Airline theme
let g:airline_powerline_fonts = 1                   " Automatically populate g:airline_symbols
"
" let g:airline_section_c = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.paste = 'ρ'

let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'Buffers'
let g:airline#extensions#tabline#buffer_nr_show = 0
let airline#extensions#tabline#disable_refresh = 0
let g:airline#extensions#bufferline#enabled = 0
" need this one anyways
let g:bufferline_echo=0
" }}}

" Better Whitespace Settings ---------------------- {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" CtrlP Settings ---------------------- {{{
nnoremap <Leader>p :CtrlPBuffer<CR>
" }}}

" Startify Settings ---------------------- {{{
" New split (horizontal) with Startify in it
noremap <Leader>n :Startify<CR>
noremap <Leader>N <C-w>v:Startify<CR>

augroup startify
    autocmd!
    " Start when no file is specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif
augroup END
" }}}

" Undotree Settings {{{
nnoremap <silent> <F5> :UndotreeToggle<CR>
nnoremap <silent> <F6> :UndotreeFocus<CR>
let g:undotree_WindowLayout = 4
let g:undotree_SetFocusWhenToggle = 0
let g:undotree_RelativeTimestamp = 1
let g:undotree_HighlightChangedText = 1

function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeGoNextState
    nmap <buffer> j <plug>UndotreeGoPreviousState
endfunc
" }}}

" Vinegar Settings {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

" Matchit Settings {{{
" packadd! matchit
" let b:match_ignorecase = 1
" }}}
