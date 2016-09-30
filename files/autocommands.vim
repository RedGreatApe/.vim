"             _         _                                                      _
"            / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"           / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
"          / ___ \ |_| | || (_) | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"         /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
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
"   :    autocmd!                               " Clear previous group (for sourcing)
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
