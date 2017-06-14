"              _____                 _   _
"             |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
"             | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
"             |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
"             |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

" Changes outside vim/nvim {{{
function! AS_HandleSwapfile (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    endif
endfunction
" }}}

" Strip trailing whitespaces {{{
" Taken from https://github.com/ntpeters
let g:whitespace_group='[\u0009\u0020\u00a0\u1680\u180e\u2000-\u200b\u202f\u205f\u3000\ufeff]'
let g:eol_whitespace_pattern = g:whitespace_group . '\+$'
function! g:StripWhitespace( line1, line2 )
    " Save the current search and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Strip the whitespace
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/' . g:eol_whitespace_pattern . '//e'
    " Restore the saved search and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Toggle ColorColumn {{{
function! ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        setlocal colorcolumn=81,101
    endif
endfunction
" }}}
