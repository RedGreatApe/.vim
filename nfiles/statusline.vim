"              ____  _        _             _     _
"             / ___|| |_ __ _| |_ _   _ ___| |   (_)_ __   ___
"             \___ \| __/ _` | __| | | / __| |   | | '_ \ / _ \
"              ___) | || (_| | |_| |_| \__ \ |___| | | | |  __/
"             |____/ \__\__,_|\__|\__,_|___/_____|_|_| |_|\___|

set laststatus=2                                " Enable the statusline
set statusline=                                 " Initialize it

" To get the mode with mode() we need a lookup table
let g:mode_lookup={
    \ 'n'  : 'NORMAL',
    \ 'i'  : 'INSERT',
    \ 'c'  : 'COMMAND',
    \ 'R'  : 'REPLACE',
    \ 'v'  : 'VISUAL', 'V'  : 'V·LINE', '' : 'V·BLOCK',
    \ 'Rv' : 'R', 's'  : 'S', 'S'  : 'S', '' : 'S', 'no' : 'N', '!'  : 'S',
    \ 'cv' : 'V', 'ce' : 'E', 'r'  : 'P', 'rm' : 'M', 'r?' : 'C', 't'  : 'T',
\}

set statusline+=%{ChangeModeColor()}          " Mode Color
set statusline+=%#StatusLineMode#             " Highlight group
set statusline+=\ %{g:mode_lookup[mode()]}\   " current mode
set statusline+=%{&paste?'ρ\ ':''}            " paste flag

if dein#tap('vim-fugitive')
    set statusline+=%#String#                 " Highlight group
    set statusline+=\ \ %{fugitive#head()}\  " Fugitive: get git branch
endif

set statusline+=%#Underlined#                 " Highlight group
set statusline+=\ %F\                         " File path of buffer
set statusline+=%#Number#                     " Highlight group
set statusline+=%h%m%r%w                      " status flags
set statusline+=%2*%{&spell?'[SPELL]':''}     " Spell flag
set statusline+=%#Underlined#                 " Highlight group

set statusline+=%=                            " Right align the rest

set statusline+=%#String#                     " Highlight group
set statusline+=\ %n\                         " Buffer number
set statusline+=%#Normal#                     " Highlight group

set statusline+=%#IncSearch#             " Highlight group
set statusline+=\ \ %p%%\ ☰\                  " File percentage
set statusline+=\ %l/%L\ \ \:%c\             " Line and column

function! ChangeModeColor()
    if (g:mode_lookup[mode()] ==# 'NORMAL')
        highlight! link StatusLineMode TabLineSel
    elseif (g:mode_lookup[mode()] =~# '\v(VISUAL|V·LINE|V·BLOCK)')
        highlight! link StatusLineMode DiffDelete
    elseif (g:mode_lookup[mode()] ==# 'INSERT')
        highlight! link StatusLineMode DiffAdd
    elseif (g:mode_lookup[mode()] =~# '\v(REPLACE)')
        highlight! link StatusLineMode DiffChange
    " elseif (g:mode_lookup[mode()] ==# 'COMMAND')
    else
        highlight! link StatusLineMode TabLineSel
    endif
    return ''
endfunction
