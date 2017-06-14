"              _____     _     _     _
"             |_   _|_ _| |__ | |   (_)_ __   ___
"               | |/ _` | '_ \| |   | | '_ \ / _ \
"               | | (_| | |_) | |___| | | | |  __/
"               |_|\__,_|_.__/|_____|_|_| |_|\___|
" From:
" https://github.com/KabbAmine/myVimFiles/blob/master/config/tabline.vim

" TODO
"   center (or scroll) buffer-tab so that the current buffer is displayed
"       If there are a lot of open buffers/tabs
"       and the current tab is one of the first
"       the selected tab will not be displayed

set showtabline=2
set tabline=

function! TLInit() abort
    if tabpagenr('$') ==# 1
        let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
        let &showtabline = len(l:bufs) ># 1 ? 2 : &showtabline
        set tabline=%!MyBufLine()
    else
        set showtabline=2
        set tabline=%!MyTabLine()
    endif
endfunction

"=================================================================
"   Bufs:                                                        =
"=================================================================
function! MyBufLine() abort
    let l:tabline = '%#Tabline#'
    let l:buffers = GetVisibleBuffers()

    for l:bufno in l:buffers
        let l:mod = (getbufvar(l:bufno, '&modified') ==# 1 ? ' +' : '')
        let l:name = GetBufName(l:bufno, l:mod)
        if l:bufno ==# bufnr('%')      " active buffer
            let l:tabline .= '%#TabLineSel# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:name
            let l:tabline .= ' %#TabLineFill# '
        else
            let l:tabline .= '%#TabLine# '
            if has('tablineat')
                let l:tabline .= '%' . l:bufno . '@Clickbuf@'
            endif
            let l:tabline .= l:name
            let l:tabline .= ' %#TabLineFill# '
        endif
    endfor
    if has('tablineat')
        let l:tabline .= '%@Clickbuf@%X'
    endif

    let l:tabline .='%=%#TabLineSel# Buffers '

    return l:tabline
endfunction

"=================================================================
"   Tabs:                                                        =
"=================================================================
function! MyTabLine() abort
    let l:tabline = ''
    for i in range(tabpagenr('$'))
        let l:tabno = i + 1
        let l:tabline .= (l:tabno ==# tabpagenr()) ? ' %#TabLineSel#' : ' %#TabLine#'
        let l:tabline .= '%' . l:tabno . 'T '
        let l:tabline .= tabpagenr('$') >=# 5
                        \? fnamemodify(gettabvar(l:tabno, 'cwd'), ':t')
                        \: pathshorten(fnamemodify(gettabvar(l:tabno, 'cwd'), ':~'))
        let l:tabline .= ' %#TabLineFill#'
    endfor
    let l:tabline .= '%='
    let l:tabline .= '%' . tabpagenr() . 'X ' . '%#TabLineFill# X %X'
    let l:tabline .= '%#TabLineSel# Tabs %T'
    return l:tabline
endfunction

augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,BufEnter * call TLInit()
    autocmd TabEnter,TabClosed,TabNew,TabLeave * call TLInit()
    autocmd VimEnter * call TLInit()
augroup END
call TLInit()

"=================================================================
"   Visible Buffers:                                             =
"=================================================================
function! GetVisibleBuffers()
    let l:buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:cur = bufnr('%')
    let total_width = 0
    let max_width = 0

    return l:buffers
endfunction

function! GetBufName(bufno, mod)
    let l:name = pathshorten(fnamemodify(bufname(a:bufno), ':.'))
    let l:tag = ( !empty(l:name) ? l:name . a:mod : '[No Name]' . a:mod)
    return l:tag
endfunction

"=================================================================
"   Clickable Buffers:                                           =
"=================================================================
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
        elseif a:button is# 'm'
            silent execute 'bdelete!' a:minwid
        endif
    endif
endfunction
