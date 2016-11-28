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

" Toggle Relativenumber ----------------- {{{
nnoremap <Leader>rn :setlocal relativenumber!<cr>
" }}}

" Toggle ColorColumn ---------------------- {{{
function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction

nnoremap <silent><Leader>cc :call g:ToggleColorColumn()<CR>
" }}}

" Resizing Splits ---------------------- {{{
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

" Save and Quit ---------------------- {{{
command! Q q
command! W w
command! Qa qa
nnoremap <C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>
nnoremap <C-q> :q<CR>
" }}}

" Buffer, Window (splits) and Tab navigation {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>
nnoremap <silent> gb :bnext<CR>
nnoremap <silent> bg :bnext<CR>
nnoremap <silent> <Up> :tabprevious<CR>
nnoremap <silent> <Down> :tabnext<CR>
" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap <Leader>t :tabnew<CR>:Startify<CR>
nnoremap <Leader>w :tabclose<CR>

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> sudow 'w !sudo tee % > /dev/null'


" Command line History {{{
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}
" }}}

" Editing {{{
nnoremap Y y$
" commented since caps-lock-key is now ESC and Ctrl
" inoremap jk <Esc>
" inoremap kj <Esc>
" undo and carriage return
inoremap <cr> <C-g>u<cr>

nnoremap <leader>ev :args $MYVIMRC ~/.vim/files/*<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" Searching {{{
nnoremap <silent> <Space> :<C-u>nohlsearch<CR><C-l>

" Sane regex {{{                Incsearch.vim replaced these, will revise
" nnoremap / /\v
" nnoremap ? ?\v
" vnoremap / /\v
" vnoremap ? ?\v
" }}}

" auto center {{{
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz
" }}}

" Visual Star {{{
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
" }}}

" }}}

" Get a manpage and put it into current buffer
nnoremap <Leader>man :read !man<space>
" Format all the text (perfect for manpages)
nnoremap <Leader>fo gggqGgg

" Map <leader>g to do a grep of the WORD under cursor,
" :silent execute is to avoid vim output
" grep! to not jump to first result
" :copen opens result in quickfix
" <C-l> redraws window
" nnoremap <Leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<CR>:copen<CR><C-l>


" Repeat on every line {{{
" repeat last command for each line of a visual selection
vnoremap . :normal .<CR>
" replay @q macro for each line of a visual selection
vnoremap @q :normal @q<CR>
"}}}

" Don't use register by x
nnoremap x "_x

" del key now works inside vim
map <C-?> <del>
map! <C-?> <del>
