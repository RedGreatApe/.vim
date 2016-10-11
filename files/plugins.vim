"              ____  _             _
"             |  _ \| |_   _  __ _(_)_ __  ___
"             | |_) | | | | |/ _` | | '_ \/ __|
"             |  __/| | |_| | (_| | | | | \__ \
"             |_|   |_|\__,_|\__, |_|_| |_|___/
"                            |___/

" Plugin Loading ---------------------- {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Loaded plugins:  :read !ls ~/.vim/bundle
" ack.vim                   Ack in vim!
" badwolf                   Badwolf theme
" ctrlp.vim                 File/Buffer/MRU search
" gist-vim                  Make gists easy (codesharing)
" gundo.vim                 Undo tree viewer
" hardmode                  Bring it!
" nerdtree                  Filesystem tree
" nerdtree-git-plugin       NERDTree git plugin
" supertab                  Tab completion with tab key (lol)
" vim-airline               Status bar
" vim-airline-themes        Themes for vim-airline
" vim-better-whitespace     Whitespace Highlighting and Stripping
" vim-buffergator           Buffer of buffers!
" vim-fugitive              Git stuff
" vim-nerdtree-tabs         NERDTree with tabs!
" vim-pathogen              Plugin manageer
" vim-perl                  Perl syntax
" vim-perl6                 Perl6 syntax
" vim-repeat                Repeat plugin actions
" vim-scratch               Scratch window
" vim-startify              Fancy start screen
" vim-surround              Surroundings (brackets)
" webapi-vim                Interface to WEB APIs
" }}}

" Badwolf settings ---------------------- {{{
colorscheme badwolf
let g:badwolf_darkgutter = 1          " Make the gutters darker than the background.
let g:badwolf_css_props_highlight = 1 " Turn on CSS properties highlighting
" }}}

" Airline Settings ---------------------- {{{
set noshowmode                                      " Vim displays mode (if in Insert, or Visual, etc), disable this
let g:airline_detect_modified=1                     " Detects if file has been modified
let g:airline_detect_paste=1                        " Detects if set paste is enabled
let g:airline_inactive_collapse=1                   " Inactive windows dont show full path of file
let g:airline_theme='badwolf'
" let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_section_c = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

let g:airline#extensions#tabline#enabled = 1        " Smart tabline
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '◀'

let g:airline_left_sep = '▶'                        " Separator
let g:airline_right_sep = '◀'                       " Separator
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
" }}}

" Better Whitespace Settings ---------------------- {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * StripWhitespace
augroup END
" }}}

" NERDTree Settings ---------------------- {{{
" augroup nerdtree
"     autocmd!
"     " Start NERDTree automatically
"     autocmd vimenter * NERDTreeToggle
"     " (even when no file is specified)
"     autocmd StdinReadPre * let s:std_in=1
"     autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"     " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>N :NERDTreeTabsToggle<CR>


" let g:nerdtree_tabs_open_on_console_startup = 1
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
" augroup buffergator
"     autocmd!
"     " Start Buffergator when vim starts
"     autocmd vimenter * BuffergatorToggle
"     " Go to the window on the right
"     autocmd VimEnter * wincmd l
" augroup END

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
" augroup hardmode
"     autocmd!
"     autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" augroup END
" }}}

" Scratch Settigns ------------------------ {{{
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
" case insensitive :P
cabbrev gist Gist
let g:gist_clip_command = 'xclip -selection clipboard'  " -c option puts it on clipboard
let g:gist_detect_filetype = 1                          " Detect filetype from filename
let g:gist_open_browser_after_post = 1                  " open browser after post
let g:gist_show_privates = 1                            " :Gist -l shows private gists
let g:gist_post_private = 1                             " gists are private by default
" }}}
