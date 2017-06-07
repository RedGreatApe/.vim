"              _____     _     _     _
"             |_   _|_ _| |__ | |   (_)_ __   ___
"               | |/ _` | '_ \| |   | | '_ \ / _ \
"               | | (_| | |_) | |___| | | | |  __/
"               |_|\__,_|_.__/|_____|_|_| |_|\___|

set showtabline=2      " Always show tab bar       (top)
set tabline=

" From
" https://github.com/KabbAmine/myVimFiles/blob/master/config/tabline.vim

" Renderer
function! TLInit() abort
    set tabline=
    set showtabline=2
    if tabpagenr('$') ==# 1         " only one tab
        let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
        let &showtabline = len(l:bufs) ># 1 ? 2 : &showtabline
        set tabline=%!MyBufLine()
    else
        set showtabline=2
        set tabline=%!MyTabLine()
    endif
endfunction

function! MyBufLine() abort
    let l:tabline = '%#Tabline#'
    let l:buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')

    for l:bufno in l:buffers
        let l:mod = (getbufvar(l:bufno, '&modified') ==# 1 ? ' +' : '')
        let l:name = pathshorten(fnamemodify(bufname(l:bufno), ':.'))
        let l:tag = ( !empty(l:name) ? l:name . l:mod : '[No Name]' . l:mod)
        if l:bufno ==# bufnr('%')      " active buffer
            let l:tabline .= '%#TabLineSel# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:tag
            let l:tabline .= ' %#TabLineFill# '
        else
            let l:tabline .= '%#TabLine# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:tag
            let l:tabline .= ' %#TabLineFill# '
        endif
    endfor
    if has('tablineat')
        let l:tabline .= '%@Clickbuf@'
    endif

"     let l:getCwd = fnamemodify(getcwd(), ':~')
"     let l:cwd = len(l:getCwd) >=# 15 ? pathshorten(l:getCwd) : l:getCwd
"     let l:tabline .= '%=%#IncSearch# ' . l:cwd . ' '
    let l:tabline .='%=%#IncSearch# Buffers '
    if has('tablineat')
        " let l:tabline .= '%#TabLineFill# ' . '%' . bufnr('%') . '@Closebuf@' . 'X '
    endif

    return l:tabline
endfunction

function! MyTabLine() abort
    let l:tabline = ''
    for i in range(tabpagenr('$'))
        let l:tabno = i + 1
        let l:tabline .= (l:tabno ==# tabpagenr()) ? ' %#TabLineSel#' : ' %#TabLine#'
        let l:tabline .= '%' . l:tabno . 'T '
        " if !empty(gettabvar(l:tabno, 'cwd'))
            let l:tabline .= tabpagenr('$') >=# 5 ?
                        \ fnamemodify(gettabvar(l:tabno, 'cwd'), ':t') :
                        \ pathshorten(fnamemodify(gettabvar(l:tabno, 'cwd'), ':~'))
        " else
            " let l:tabline .= tabpagenr('$') >=# 5 ?
                        " \ fnamemodify(getcwd(), ':t') :
                        " \ pathshorten(fnamemodify(getcwd(), ':~'))
        " endif
        let l:tabline .= ' %#TabLineFill#'
    endfor
    let l:tabline .= '%=%#IncSearch# Tabs %T'
    let l:tabline .= '%' . tabpagenr() . 'X ' . '%#TabLineFill# X '
    return l:tabline
endfunction

" Redrawer
augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,BufEnter,TabEnter,TabClosed,TabNew,TabLeave,VimEnter * call TLInit()
augroup END
call TLInit()

" Replace the default <F5> mapping
" nnoremap <silent> <F5> :tabonly\|call TLInit()<CR>

" From vim-airline
" https://github.com/vim-airline/vim-airline/commit/d8d08ada7b58876c6a5ea0f895e122a2ac60bd17
function! Clickbuf(minwid, clicks, button, modifiers) abort
    if a:minwid ==# 0
        silent execute 'vsplit'
        return ''
    endif
    if a:clicks == 1 && a:modifiers !~# '[^ ]'
      if a:button is# 'l'
        silent execute 'buffer' a:minwid
      endif
      if a:button is# 'm'
        silent execute 'bdelete' a:minwid
      endif
    endif
endfunction
