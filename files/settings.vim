set nocompatible
set display+=lastline           " show the last line that fits in window
set showmatch                   " show matching bracket (briefly jump)
set matchtime=2                 " show matching bracket for 0.2 seconds
set ruler                       " show cursor position in status bar
set scrolloff=1                 " 2 lines above/below cursor when scrolling
set sidescroll=1                " Minimum number of columns to scroll horizontally
set sidescrolloff=5             " 5 characters before cursor when scrolling
set title                       " show file in titlebar
set visualbell                  " Visual alarm, instead of cpu beep
set wildignore+=*.o,*.obj,*.bak " Files matching these patterns
set wildignore+=*.exe,*.py[co]  " will be ignored when expanding wildcards
set wildignore+=*.swp,*~,*.pyc,.svn
set wildmenu                    " completion with menu
set wildmode=longest,full
set nofoldenable                " Do not fold by default
set esckeys                     " map missed escape sequences (enables keypad keys)
set formatoptions=qn1           " format options (I use them on <leader>fo ) (removed r, annyoing on comments)
set hlsearch                    " Highlight all matches in file when performing search
set wrap
set autoindent                  " Automatically indent every new line
set backspace=start,eol,indent  " Can backspace over everything (hard mode changes this)
set magic                       " change the way backslashes are used in search patterns
set smartindent                 " smart auto indenting
set smarttab                    " smart tab handling for indenting
set encoding=utf-8              " Self explanatory
set ttyfast                     " Fast terminal, redrawing

nnoremap <Leader>sshfile :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>

" Changes outside vim/nvim
" function! AS_HandleSwapfile (filename, swapname)
"     if getftime(v:swapname) < getftime(a:filename)
"         call delete(v:swapname)
"         let v:swapchoice = 'e'
"     endif
" endfunction


    " Detect file modified elsewhere, forgot where i got it from :(
    " autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
    " autocmd BufWritePost,BufReadPost,BufLeave *
    "         \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
    " if !has("gui_running")
    "     autocmd BufEnter,CursorMoved,CursorMovedI       * checktime
    "     autocmd FocusGained,BufEnter,FocusLost,WinLeave * checktime
    " endif

" augroup MyColors
"     autocmd!
"     autocmd ColorScheme * call MyHighlights()
" augroup END

" function! MyHighlights() abort
"     " Colors:
"     " https://vignette3.wikia.nocookie.net/vim/images/1/16/Xterm-color-table.png/revision/latest?cb=20110121055231

"     highlight! LineNr       ctermfg=242  ctermbg=232
"     highlight! CursorLineNR ctermfg=254  ctermbg=237 gui=NONE guifg=NONE
"     highlight! CursorLine   ctermfg=NONE ctermbg=235 cterm=NONE

"     highlight! Whitespace   ctermfg=239  ctermbg=232
"     highlight! Search       ctermfg=250  ctermbg=240

"     highlight! SpellBad     ctermfg=0    ctermbg=224

"     highlight DiffAdd    cterm=bold ctermfg=2    ctermbg=0  " Line was added
"     highlight DiffDelete cterm=bold ctermfg=1    ctermbg=0  " Line was removed
"     highlight DiffChange cterm=NONE ctermfg=NONE ctermbg=60 " Line was changed
"     highlight DiffText   cterm=bold ctermfg=3    ctermbg=60 " Exact part that was changed

"     highlight! link Visual Search
"     highlight! link CursorColumn CursorLine
"     highlight! link ColorColumn  CursorLine
"     highlight! link WildMenu Search
"     highlight! link MatchParen TermCursor
" endfunction
" call MyHighlights()

" Airline settings
" let g:airline_powerline_fonts = 1
" let g:airline_mode_map        = {
"     \ '__' : '-',   'n'  : ' N ', 'i'  : ' I ',
"     \ 'R'  : ' R ', 'c'  : ' C ', 'v'  : ' V ',
"     \ 'V'  : ' V ', '' : ' V ', 's'  : ' S ',
"     \ 'S'  : ' S ', '' : ' S ',
"     \ }

" if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
" let g:airline_symbols.readonly           = ''
" let g:airline_symbols.paste              = 'ρ'
" let g:airline_symbols.branch             = '⎇'
" let g:airline_section_y                  = '%n'
" let g:airlilne_section_z                 = '%p%% ☰ %l/%L  :%c '
" let g:airline_extensions                 = ['tabline', 'branch', 'quickfix', 'ale']
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#ale#enabled     = 1

