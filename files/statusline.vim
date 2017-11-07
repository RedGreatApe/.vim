"=================================================================
"   StatusLine:                                                  =
"=================================================================
let g:look_up ={
        \ '__' : '-', 'n'  : 'N',
        \ 'i'  : 'I', 'R'  : 'R',
        \ 'v'  : 'V', 'V'  : 'V',
        \ 'c'  : 'C', '' : 'V',
        \ 's'  : 'S', 'S'  : 'S',
        \ '' : 'S', 't'  : 'T',
    \}

set statusline=
set statusline+=%(\ %{g:look_up[mode()]}%)
set statusline+=%(%{&paste?'\ p\ ':''}%)
set statusline+=%(\ \ %{fugitive#head()}%)
set statusline+=%(\ %<%F%)
set statusline+=\ %h%m%r%w
set statusline+=%=
set statusline+=%([%n]%<\ %p%%\ ☰\ \ %l/%L\ \ :%c\ %)
