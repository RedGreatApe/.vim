"              __  __                   _
"             |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"             | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"             | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"             |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                          |_|   |_|            |___/

" Toggle ColorColumn {{{
nnoremap <silent><Leader>cc :call ToggleColorColumn()<CR>
" }}}

" Resizing Splits {{{
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

" Save and quit {{{
nnoremap <silent><C-s> :update<CR>
imap <C-s> <Esc><C-s>
vmap <C-s> <Esc><C-s>
nnoremap <silent><C-q> :q<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> w!! 'w !sudo tee % > /dev/null'
" }}}

" Buffer, Window (splits) and Tab navigation {{{
nnoremap <silent> gb :bnext<CR>
" Do not skip wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap <silent><Leader>v :vsplit<CR>
nnoremap <silent><Leader>s :split<CR>

" use Alt keys and directionals {hklj} to change window,
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-h> <Esc><C-w>h
inoremap <A-l> <Esc><C-w>l
" }}}

" Command line History {{{
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}

" Editing {{{
nnoremap Y y$
nnoremap <silent><leader>ev :args ~/.vim/nvimrc ~/.vim/nfiles/*<cr>
nnoremap <silent><leader>sv :source $MYVIMRC<cr>
nnoremap <silent><leader>de :setlocal spell spelllang=de_de<cr>
nnoremap <silent><leader>file :e scp://rd@file.atikon.io:2222//srv/share/intern/Dokumentation/Protokolle/<cr>
" }}}

" Searching {{{
nnoremap <silent><Space> :<C-u>nohlsearch<CR><C-l>
" auto center {{{
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *<C-o>zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz
" }}}

" Buffer search
nnoremap <silent><leader>lb :buffers<CR>
nnoremap <silent><leader>lr :registers<CR>
" }}}

" Don't use register by x
nnoremap x "_x

" Del key now works inside neovim
map <F1> <del>
map! <F1> <del>


" System clipboard interaction.  Mostly from:
" https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "+y
noremap <silent><leader>p :set paste<CR>"+p<CR>:set nopaste<CR>
noremap <silent><leader>P :set paste<CR>"+P<CR>:set nopaste<CR>
vnoremap <leader>y "+ygv
" }}}
