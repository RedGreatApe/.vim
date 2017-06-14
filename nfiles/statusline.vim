"              ____  _        _             _     _
"             / ___|| |_ __ _| |_ _   _ ___| |   (_)_ __   ___
"             \___ \| __/ _` | __| | | / __| |   | | '_ \ / _ \
"              ___) | || (_| | |_| |_| \__ \ |___| | | | |  __/
"             |____/ \__\__,_|\__|\__,_|___/_____|_|_| |_|\___|

" function! SLInit()
"     if winnr('$') ># 1      " more than one window
"         let l:cwin = winnr()
"         for l:win in range(1, winnr('$'))
"             if l:win ==# l:cwin
"                 silent execute l:cwin . 'wincmd w'
"                 setlocal statusline=%!ActiveStatusLine()
"             else
"                 silent execute l:win . 'wincmd w'
"                 setlocal statusline=%!InactiveStatusLine()
"                 silent execute l:cwin . 'wincmd w'
"             endif
"         endfor
"     else
"         setlocal statusline=%!ActiveStatusLine()
"     endif
" endfunction

" "=================================================================
" "   Active StatusLine:                                           =
" "=================================================================

" function! ActiveStatusLine()
"     let l:mode = GetMode()
"     let l:statusline = ''
"     let l:statusline .= '%2*'
"     let l:statusline .= ' ' . l:mode . ' '
"     let l:statusline .= '%1*'
"     if &paste
"         let l:statusline .= 'ρ '
"     endif

"     let l:statusline .= '%3*'
"     let l:statusline .= GetBranch()
"     let l:statusline .= '%#StatusLine#'

"     let l:statusline .='%{SLChanged(&mod)}%6*'
"     let l:statusline .= ' [%n] %<%F '
"     let l:statusline .= GetFlags()

"     let l:statusline .= '%='

"     let l:statusline .= '%#StatusLine#'
"     let l:statusline .= '%4*'
"     let l:statusline .= GetCursorInfo()

"     return l:statusline
" endfunction

" "=================================================================
" "   Inactive StatusLine:                                         =
" "=================================================================

" function! InactiveStatusLine()
"     let l:statusline = ''

"     let l:statusline .= ' - '
"     if &paste
"         let l:statusline .= '- '
"     endif
"     let l:statusline .= GetBranch()
"     let l:statusline .= ' [%n] %t '
"     let l:statusline .= GetFlags()
"     let l:statusline .= '%#StatusLineNC#'
"     let l:statusline .= '%='
"     let l:statusline .= GetCursorInfo()

"     return l:statusline
" endfunction

" "=================================================================
" "   Helper Functions:                                            =
" "=================================================================

" function! GetBranch()
"     let l:statusline = ''
"     if dein#tap('vim-fugitive') " && len(fugitive#head()) ># 0
"         let l:statusline .= '  %{fugitive#head()} '
"     endif
"     return l:statusline
" endfunction

" function! GetFlags()
"     let l:statusline = ''
"     let l:statusline .= '%5*'
"     let l:statusline .= '%h%m%r%w'
"     if &spell
"         let l:statusline .= '[SPELL]'
"     endif
"     return l:statusline
" endfunction

" function! GetCursorInfo()
"     let l:statusline = ''
"     let l:statusline .= ' %<'
"     let l:statusline .= ' %p%% ☰ '
"     let l:statusline .= ' %l/%L  :%c  '
"     return l:statusline
" endfunction

" function! GetMode()
"     return {
"         \ '__' : '-', 'n'  : 'N',
"         \ 'i'  : 'I', 'R'  : 'R',
"         \ 'v'  : 'V', 'V'  : 'V',
"         \ 'c'  : 'C', '' : 'V',
"         \ 's'  : 'S', 'S'  : 'S',
"         \ '' : 'S', 't'  : 'T',
"     \}[mode()]
" endfunction

" augroup StatusLine
"     autocmd!
"     autocmd BufAdd,BufDelete,BufEnter,BufLeave * call SLInit()
"     autocmd WinEnter * call SLInit()
"     autocmd VimEnter * call SLInit()
" augroup END
" call SLInit()

" "=================================================================
" "   Highlight Groups:                                            =
" "=================================================================

" highlight! User1 ctermfg=234 ctermbg=66   guibg=#5f8787  guifg=#1c1c1c  gui=NONE     cterm=NONE
" highlight! User2 ctermfg=234 ctermbg=66   guibg=#5f8787  guifg=#1c1c1c  gui=bold     cterm=bold
" highlight! User3 ctermfg=109 ctermbg=236  guibg=#45413b
" highlight! User4 ctermfg=109 ctermbg=233
" highlight! User5 ctermfg=130 ctermbg=234

" function! SLChanged(modified)
"     if a:modified
"         highlight! User6 ctermfg=109 guibg=#121212 gui=NONE ctermbg=234 cterm=NONE
"     else
"         highlight! User6 guifg=#5f8787 guibg=#121212 gui=NONE ctermfg=66 ctermbg=234 cterm=NONE
"     endif
"     return ''
" endfunction

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
if dein#tap('vim-fugitive') " && len(fugitive#head()) ># 0
    " if len(fugitive#head()) ># 1
        set statusline+=%(\ \ %{fugitive#head()}%)
    " endif
endif
set statusline+=%(\ [%n]\ %<%F%)
set statusline+=%=
set statusline+=%(\ %<\ \ %p%%\ ☰\ \ \ %l/%L\ \ :%c\ %)
