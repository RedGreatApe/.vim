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

" Toggle Relativenumber ----------------- {{{
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <Leader>rn :call NumberToggle()<cr>



" Toggle Set Paste ---------------------- {{{
" function! g:ToggleSetPaste()
"     if &paste
"         set nopaste
"     else
"         set paste
"     endif
" endfunction
" }}}
" nnoremap <silent><Leader>sp :call g:ToggleSetPaste()<CR>

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

nmap          <C-W>+     <C-W>+<SID>ws
nmap          <C-W>-     <C-W>-<SID>ws
nn <script>   <SID>ws+   <C-W>+<SID>ws
nn <script>   <SID>ws-   <C-W>-<SID>ws
nmap          <C-W>>     <C-W>><SID>ws
nmap          <C-W><     <C-W><<SID>ws
nn <script>   <SID>ws>   <C-W>><SID>ws
nn <script>   <SID>ws<   <C-W><<SID>ws

nmap          <SID>ws    <Nop>


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

" Buffer navigation
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>

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

" Save with Ctrl+s
nnoremap <C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>

" close current buffer
nnoremap <C-q> :q<CR>

" use tab key to match bracket pairs
" <tab> is the same as CTRL+i  which is used for jumps
" nnoremap <tab> %
" vnoremap <tab> %

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

" in command line, %% means filepath (without filename)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" in command line, :sudow changes to (sudo write)
cnoremap <expr> sudow 'w !sudo tee % > /dev/null'
nnoremap / /\v

" Add mappings for <Tab> and Shift+<Tab> for indenting?
" Maybe?
