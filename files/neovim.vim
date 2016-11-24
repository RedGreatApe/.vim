"
"          _   _         __     ___
"         | \ | | ___  __\ \   / (_)_ __ ___
"         |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \
"         | |\  |  __/ (_) \ V / | | | | | | |
"         |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"
"
"
"
"
"
"
" python (was mostly for Gundo, but I changed to Undotree
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog ='/usr/bin/python'

" esc to exit to normal mode in terminal emulator
tnoremap <Esc> <C-\><C-n>
" use Alt keys and directionals {hklj} to change window,
" works on terminal buffers and normal buffers insert, normal and terminal mode
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-h> <Esc><C-w>h
inoremap <A-l> <Esc><C-w>l
autocmd! BufEnter term://* startinsert

let g:terminal_scrollback_buffer_size = 100000
