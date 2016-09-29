"              __  __                   _
"             |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"             | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"             | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"             |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                          |_|   |_|            |___/

" Breaking bad habbits
" KONAMI code
" inoremap <up> <NOP>
" vnoremap <up> <NOP>
" inoremap <down> <NOP>
" vnoremap <down> <NOP>
" inoremap <left> <NOP>
" vnoremap <right> <NOP>
" inoremap <left> <NOP>
" vnoremap <right> <NOP>
" B A <Start>

nnoremap <esc> <NOP>

" Clear search highlighting
nnoremap <space> :noh<CR>

" Toggle set paste
function! g:ToggleSetPaste()
    if &paste
        set nopaste
    else
        set paste
    endif
endfunction
nnoremap <silent><Leader>sp :call g:ToggleSetPaste()<CR>

" Toggle colorcolumn
function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
nnoremap <silent><Leader>c :call g:ToggleColorColumn()<CR>

" Quickly surround current word in ()[]{}'"
" Could be vImproved with commands '< '> (last visual block)
" nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
" nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
" nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel

" go to next buffer
nnoremap gb :bn<CR>

" make Y behave similarly to D and C
nnoremap Y y$
" super H and super L (overwriting some stuff)
noremap H ^
noremap L $

" Useless left hand...
inoremap jk <Esc>

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
nnoremap <SID>ws <NOP>

" Allow for common typoes
" on quit/write
" Bind :Q to :qi
command! Q q
command! W w
command! Qa qa

" write file
nnoremap <C-s> :w<CR>
" save in insert mode
imap <C-s> <Esc><C-s>

" Tab remaps
nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>w :tabclose<CR>
" close current buffer
nnoremap <C-q> :q<CR>

" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk


nnoremap <leader>ev :args ~/.vimrc ~/.vim/files/*<cr>

nnoremap <leader>sv :source $MYVIMRC<cr>
