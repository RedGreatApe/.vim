"                 _         _                                                      _
"                / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"               / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"              / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"             /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/

" Filetype Perl {{{
augroup filetypeperl
    autocmd!
    autocmd FileType perl :iabbrev <buffer> dp use Data::Printer;
augroup END
" }}}

" Syntax Settings {{{
" *.zpt files to html syntax
augroup syntax_helper
    autocmd!
    autocmd BufRead,BufNewFile *.zpt setlocal filetype=html
augroup END
" }}}

" Vimscript file settings {{{
" fold Vimscript files
" high foldlevel needed for  za  to work
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=999
augroup END
" }}}

" Help window {{{
" Open in most right vertical split With number, With relativenumber
augroup help_window
    autocmd!
    autocmd FileType help wincmd L
augroup END
" }}}

" Save on focus lost {{{
augroup focus_lost
    autocmd!
    autocmd FocusLost * :wa
augroup END
" }}}

" Relativenumber {{{
augroup rnu_focus_change
    autocmd!
    autocmd FocusLost * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" Detect file modified elsewhere {{{
" forgot where i got it from :(
augroup AutoSwap
    autocmd!
    autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

autocmd BufWritePost,BufReadPost,BufLeave *
            \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorMoved,CursorMovedI * checktime
        autocmd FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
" }}}

" remove trailing whitespaces {{{
augroup betterwhitespace
    autocmd!
    autocmd BufWritePre * call StripWhitespace( 0, line("$") )
augroup END
" }}}
" }}}
