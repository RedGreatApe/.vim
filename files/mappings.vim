"              __  __                   _
"             |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"             | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"             | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"             |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                          |_|   |_|            |___/


" paste toggle
set pastetoggle=<F10>
imap <F10> <Esc><F10>a
" Clear search highlighting
nnoremap <F3> :noh<CR>

function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
nnoremap <silent><F6> :call g:ToggleColorColumn()<CR>

" go to next buffer
nnoremap gb :bn<CR>
" use Enter in insert mode to enter an undo friendly new line still doesnt seem to work
imap <CR> <Esc>o
" save in insert mode
" make Y behave similarly to D and C
nnoremap Y y$
" Navigate splits more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Key repeat hack for resizing splits
" <C-w>+++- vs <C-w>+<C-w>+<C-w>-
" see: http://www.vim.org/scripts/script.php?script_id=2223
" Does not seem to work for a while now
nnoremap <C-w>+ <C-w>+<SID>ws
nnoremap <C-w>- <C-w>-<SID>ws
nnoremap <C-w>> <C-w>><SID>ws
nnoremap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nnoremap <SID>ws <Nop>

" Allow for common typoes
" on quit/write
" Bind :Q to :qi
command! Q q
command! W w
command! Qa qa

" write file
nnoremap <C-s> :w<CR>
imap <C-s> <Esc><C-s>

" Tab remaps
nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>w :tabclose<CR>
" close current buffer
nnoremap <C-q> :q<CR>

" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk
