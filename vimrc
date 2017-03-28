"=============================================================================
" Description: RedGreatApe's vimrc
" Author: RedGreatApe
" Really: René De Alvarado
" URL: https://github.com/redgreatape/.vim
"=============================================================================
"                              _
"                       __   _(_)_ __ ___  _ __ ___
"                       \ \ / / | '_ ` _ \| '__/ __|
"                        \ V /| | | | | | | | | (__
"                       (_)_/ |_|_| |_| |_|_|  \___|
"
"      _   _                 _            ____                                  _
"     | | | | ___ _ __ ___  | |__   ___  |  _ \ _ __ __ _  __ _  ___  _ __  ___| |
"     | |_| |/ _ \ '__/ _ \ | '_ \ / _ \ | | | | '__/ _` |/ _` |/ _ \| '_ \/ __| |
"     |  _  |  __/ | |  __/ | |_) |  __/ | |_| | | | (_| | (_| | (_) | | | \__ \_|
"     |_| |_|\___|_|  \___| |_.__/ \___| |____/|_|  \__,_|\__, |\___/|_| |_|___(_)
"                                                         |___/


if &compatible | set nocompatible | endif
" let g:mapleader="ß"           " Leader mapping

" Sources ------------------------------- {{{
source ~/.vim/files/settings.vim
source ~/.vim/files/abbreviations.vim
source ~/.vim/files/autocommands.vim
source ~/.vim/files/mappings.vim
if has("nvim")
    source ~/.vim/files/neovim.vim
endif
source ~/.vim/files/plugins.vim
" }}}

"              _ _ _____ ___  ____   ___
"             ( | )_   _/ _ \|  _ \ / _ \
"              V V  | || | | | | | | | | |
"                   | || |_| | |_| | |_| |
"                   |_| \___/|____/ \___/
"
"       source ~/.vim/files/functions.vim       ?
