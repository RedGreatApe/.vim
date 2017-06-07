
"              _____                   _             _
"             |_   _|__ _ __ _ __ ___ (_)_ __   __ _| |
"               | |/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
"               | |  __/ |  | | | | | | | | | | (_| | |
"               |_|\___|_|  |_| |_| |_|_|_| |_|\__,_|_|

" {{{
augroup terminal_settings
    autocmd!
    autocmd BufEnter term://* startinsert
    autocmd BufEnter term://* setlocal nonumber
    autocmd BufEnter term://* setlocal norelativenumber
    autocmd FileType terminal setlocal nonumber
    autocmd FileType terminal setlocal norelativenumber
augroup END

let g:terminal_scrollback_buffer_size = 100000
" esc to exit to normal mode in terminal emulator
tnoremap <Esc> <C-\><C-n>

tnoremap <F1> <del>
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-l> <C-\><C-n><C-w>l
" }}}
