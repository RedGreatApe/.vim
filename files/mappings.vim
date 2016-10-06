"              __  __                   _
"             |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"             | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"             | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"             |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                          |_|   |_|            |___/

" KONAMI Code ---------------------- {{{
inoremap <up> <NOP>
vnoremap <up> <NOP>
inoremap <down> <NOP>
vnoremap <down> <NOP>
inoremap <left> <NOP>
vnoremap <right> <NOP>
inoremap <left> <NOP>
vnoremap <right> <NOP>
" B A <Start>

nnoremap <up> <NOP>
nnoremap <down> <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>
" }}}

" Who needs a help key ------------------ {{{
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" }}}

" Toggle Set Paste ---------------------- {{{
function! g:ToggleSetPaste()
    if &paste
        set nopaste
    else
        set paste
    endif
endfunction
" }}}
nnoremap <silent><Leader>sp :call g:ToggleSetPaste()<CR>

" Toggle ColorColumn ---------------------- {{{
function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
" }}}
nnoremap <silent><Leader>cc :call g:ToggleColorColumn()<CR>

" Split Navigation ---------------------- {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Resizing Splits ---------------------- {{{
" <C-w>+++- vs <C-w>+<C-w>+<C-w>-
" see: http://www.vim.org/scripts/script.php?script_id=2223
" Does not seem to work for a while now
" nnoremap <C-w>+ <C-w>+<SID>ws
" nnoremap <C-w>- <C-w>-<SID>ws
" nnoremap <C-w>> <C-w>><SID>ws
" nnoremap <C-w>< <C-w><<SID>ws
" nnoremap <script> <SID>ws+ <C-w>+<SID>ws
" nnoremap <script> <SID>ws- <C-w>-<SID>ws
" nnoremap <script> <SID>ws> <C-w>><SID>ws
" nnoremap <script> <SID>ws< <C-w><<SID>ws
" nnoremap <SID>ws <NOP>
" }}}

" Command Typos ---------------------- {{{
" on quit/write
" Bind :Q to :qi
command! Q q
command! W w
command! Qa qa
" }}}

" Clear search highlighting
nnoremap <space> :noh<CR>
" go to next buffer
nnoremap gb :bn<CR>
" make Y behave similarly to D and C
nnoremap Y y$
" super H and super L (overwriting some stuff)
" noremap H ^
" noremap L $
" Useless left hand...
inoremap jk <Esc>
" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk
" write file
nnoremap <C-s> :w<CR>
" save in insert mode
imap <C-s> <Esc><C-s>
" close current buffer
nnoremap <C-q> :q<CR>
" use tab key to match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Format all the text (perfect for manpages)
nnoremap <Leader>fo gggqGgg
" Get a manpage and put it into current buffer
nnoremap <Leader>man :read !man<space>

" Tab Remaps ---------------------- {{{
nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>w :tabclose<CR>
" }}}

" VIMRC editing/sourcing ---------------------- {{{
nnoremap <leader>ev :args ~/.vimrc ~/.vim/files/*<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
