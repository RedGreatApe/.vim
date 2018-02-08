let g:look_up = {
    \ '__' : '-', 'n'  : 'Normal',
    \ 'R'  : 'R', 'i'  : 'Insert',
    \ '' : 'S', 'v'  : 'Visual',
    \ 't'  : 'T', 'V'  : 'V-Line',
    \ 'S'  : 'S', '' : 'V-Bloc',
    \ 's'  : 'S', 'c'  : 'Command',
\}

function! MyHighlights() abort
    highlight! StatusLine   ctermbg=237 ctermfg=254 term=NONE cterm=NONE
    highlight! StatusLineNC ctermbg=235 ctermfg=242 term=NONE cterm=NONE
    highlight! VertSplit    ctermbg=235 ctermfg=242 term=NONE cterm=NONE
    highlight! TablineFill  ctermbg=237 ctermfg=254 term=NONE cterm=NONE
    highlight! Tabline      ctermbg=237 ctermfg=254 term=NONE cterm=NONE
endfunction

augroup MyColors
    autocmd!
    autocmd VimEnter * call MyHighlights()
augroup END

set statusline=
set statusline+=%(\ %{g:look_up[mode()]}\ %)
set statusline+=%(%{&paste?'p\ ':''}%)\|
set statusline+=%(\ %<%F\ %)
set statusline+=\ %h%m%r%w
