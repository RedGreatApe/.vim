"                 _         _                                                      _
"                / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"               / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"              / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"             /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
"
"
"      :autocmd BufNewFile * :write
"               ^          ^ ^
"               |          | |
"               |          | The command to run.
"               |          |
"               |          A "pattern" to filter the event.
"               |
"               The "event" to watch for.
"
"   :help autocmd-events
"
"
"   :augroup testgroup                          " Group autocmds and name them
"   :    autocmd!                               " Clear previous group (when re-sourcing)
"   :    autocmd BufWrite * :echom "Cats"       " The actual autocmds
"   :augroup END                                " Finish the group

" Syntax Settings ------------------------------ {{{
augroup syntax_helper                                   " Set syntax to FileTypes
    autocmd!
    autocmd BufRead,BufNewFile *.zpt setlocal filetype=html     " *.zpt files to html syntax
augroup END
" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker             " fold Vimscript files
augroup END
" }}}

" Help window ---------------------------------- {{{
augroup help_window
    autocmd!
    autocmd FileType help wincmd L                          " Open in most right vertical split
    autocmd FileType help set number                        " With number
    autocmd FileType help set relativenumber                " With relativenumber
augroup END
" }}}

" Only for the GUI version and a few console versions where this can be detected.
" Save on focus lost --------------------------- {{{
augroup focus_lost
    autocmd!
    "autocmd FocusLost * :wa
augroup END
" }}}

" Relativenumber ------------------ {{{
augroup rnu_focus_change
    autocmd!
"     autocmd FocusLost * :set norelativenumber
"     autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" Detect file modified elsewhere {{{
" forgot where i got it from :(
" augroup AutoSwap
"     autocmd!
"     autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
" augroup END

" function! AS_HandleSwapfile (filename, swapname)
"     " if swapfile is older than file itself, just get rid of it
"     if getftime(v:swapname) < getftime(a:filename)
"         call delete(v:swapname)
"         let v:swapchoice = 'e'
"     endif
" endfunction
" autocmd BufWritePost,BufReadPost,BufLeave *
"             \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

" augroup checktime
"     autocmd!
"     if !has("gui_running")
"         "silent! necessary otherwise throws errors when using command
"         "line window.
"         autocmd BufEnter,CursorMoved,CursorMovedI * checktime
"         autocmd FocusGained,BufEnter,FocusLost,WinLeave * checktime
"     endif
" augroup END
" }}}
