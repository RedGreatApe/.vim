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

"=================================================================
"   TabLine: (view %%functions.vim)                              =
"=================================================================

" From:
" https://github.com/KabbAmine/myVimFiles/blob/master/config/tabline.vim
" and the vim-airline tabline extension

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
        if l:bufno < 0
            continue
        endif
        let l:name = GetBufName(l:bufno)
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
" Not working as desired, but I don't use them
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

    "=================================================================
    "   Visible Buffers:                                             =
    "=================================================================
    " Not working as desired when there are too many buffers (I think)
function! GetVisibleBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let current = bufnr('%')

    " Get Total width of all buffer names, and width of longest buffern ame
    let total_width = 0
    let max_width   = 0
    for nr in buffers
        let width = len(GetBufName(nr)) + 4
        let total_width += width
        let max_width = max([max_width, width])
    endfor

    " Only show current and surrounding buffers (if too many buffers)
    let position = index(buffers, current)
    let vimwidth = &columns
    if total_width > vimwidth && position > -1
        let buf_count = len(buffers)

        " determine how many to show (one on the right and rest on left)
        let buf_max   = vimwidth / max_width
        let buf_right = 5
        let buf_left  = max([5, buf_max - buf_right])

        " change ammount of buffers left and right of the
        " current buffer
        if position < 6
            for inc in range(1, - (position - 5))
                let buf_right += 1
            endfor
        elseif position > (buf_count - 6)
            for inc in range(1, - (position - (buf_count + 5)))
                let buf_left += 1
            endfor
        endif

        " show buffers from 'start' to 'end'
        let start = max([0, position - buf_left])
        let end   = min([buf_count, position + buf_right])
        if end > buf_count - 1 - buf_right
            let start -= max([0, buf_right - (buf_count - 1 - position)])
        endif
        let buffers = eval('buffers[' . start . ':' . end . ']')
        if start > 0
            call insert(buffers, -1, 0)
        endif
        if end < buf_count - 1
            call add(buffers, -1)
        endif
    endif
    return buffers
endfunction

    "=================================================================
    "   GetBufName:                                                  =
    "=================================================================
function! GetBufName(bufno)
    let l:mod = (getbufvar(a:bufno, '&modified') ==# 1 ? ' +' : '')
    let l:name = pathshorten(fnamemodify(bufname(a:bufno), ':.'))
    let l:tag = ( !empty(l:name) ? l:name . l:mod : '[No Name]' . l:mod)
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
            silent execute 'bwipeout!' a:minwid
        endif
    endif
endfunction

augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,BufEnter * call TLInit()
    autocmd TabEnter,TabClosed,TabNew,TabLeave * call TLInit()
    autocmd VimEnter * call TLInit()
augroup END
call TLInit()
