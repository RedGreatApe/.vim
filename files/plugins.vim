"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/

" Plugin Loading ---------------------- {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" }}}

" Badwolf settings ---------------------- {{{
colorscheme badwolf
let g:badwolf_darkgutter = 1          " Make the gutters darker than the background.
let g:badwolf_css_props_highlight = 1 " Turn on CSS properties highlighting
" }}}

" Bufferline Settings ---------------------- {{{
let g:bufferline_echo=0
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
" }}}

" Better Whitespace Settings ---------------------- {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" NERDTree Settings ---------------------- {{{
noremap <Leader>N :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup = 0

let g:NERDTreeWinSize = 25
let g:NERDTreeMouseMode = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" }}}

" Buffergator Settings ---------------------- {{{
nnoremap <Leader>b <C-w>t:BuffergatorToggle<CR><C-w>l

let g:buffergator_viewport_split_policy="b"
let g:buffergator_split_hsize=5
let g:buffergator_split_vsize=5
let g:buffergator_autoupdate=1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
" }}}

" CtrlP Settings ---------------------- {{{
nnoremap <Leader>p :CtrlPBuffer<CR>
" }}}

" Startify Settings ---------------------- {{{
" New split (horizontal) with Startify in it
noremap <C-n> <C-w>v:Startify<CR>

augroup startify
    autocmd!
    " Start when no file is specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") ) | Startify | endif
augroup END
" }}}

" Hard Mode Settings ---------------------- {{{
let g:HardMode_hardmodeMsg = "Bring it!"
let g:HardMode_easymodeMsg = "Wuss!"
nnoremap <Leader>h <Esc>:call ToggleHardMode()<CR>
" }}}

" Scratch Settigns ------------------------ {{{
let g:scratch_height = 0.2
let g:scratch_persistence_file = '~/Stuff/vimtmp/scratch.vim'
let g:scratch_insert_autohide = 0

nnoremap <Leader>sc :Scratch<CR>
" }}}

" Gundo Settings -------------------------- {{{
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 30
let g:gundo_preview_height = 20
let g:gundo_right = 1
let g:gundo_preview_bottom = 1
" }}}

" Gist vim Settings ------------------------{{{
cabbrev gist Gist
let g:gist_clip_command = 'xclip -selection clipboard'  " -c option puts it on clipboard
let g:gist_detect_filetype = 1                          " Detect filetype from filename
let g:gist_open_browser_after_post = 1                  " open browser after post
let g:gist_show_privates = 1                            " :Gist -l shows private gists
let g:gist_post_private = 1                             " gists are private by default
" }}}

" Incsearch.vim {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1

map n  <Plug>(incsearch-nohl-n) zz :set hlsearch<CR>
map N  <Plug>(incsearch-nohl-N) zz :set hlsearch<CR>
map *  <Plug>(incsearch-nohl-*) zz :set hlsearch<CR>
map #  <Plug>(incsearch-nohl-#) zz :set hlsearch<CR>
map g* <Plug>(incsearch-nohl-g*) zz :set hlsearch<CR>
map g# <Plug>(incsearch-nohl-g#) zz :set hlsearch<CR>
" }}}
