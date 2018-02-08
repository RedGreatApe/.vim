filetype plugin on
syntax on

call plug#begin('~/.vim/plugged')
    Plug 'vimwiki/vimwiki'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
    Plug 'wsdjeg/FlyGrep.vim'
    Plug 'morhetz/gruvbox'                 
    Plug 'tpope/vim-commentary'            " Comment lines with text objects
    Plug 'tpope/vim-fugitive'              " use git commands in vim
    Plug 'tpope/vim-repeat'                " use '.' in supported plugin maps
    Plug 'tpope/vim-surround'              " quoting with text objects
call plug#end()

" Vimwiki
nmap <C-h> <Plug>VimwikiGoBackLink
let mywiki                 = {}
let mywiki.path            = '~/.vim/vimwiki'
let lmop                   = {}
let lmop.path              = '~/lmop'
let g:vimwiki_list         = [ mywiki , lmop ]
" Undotree
let g:undotree_WindowLayout         = 2
let g:undotree_HighlightChangedText = 0
colorscheme gruvbox
