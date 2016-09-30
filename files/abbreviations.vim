"                 _    _     _                    _       _   _
"                / \  | |__ | |__  _ __ _____   _(_) __ _| |_(_) ___  _ __  ___
"               / _ \ | '_ \| '_ \| '__/ _ \ \ / / |/ _` | __| |/ _ \| '_ \/ __|
"              / ___ \| |_) | |_) | | |  __/\ V /| | (_| | |_| | (_) | | | \__ \
"             /_/   \_\_.__/|_.__/|_|  \___| \_/ |_|\__,_|\__|_|\___/|_| |_|___/


" Autocommands and abbreviations could be combined
" to create some file specific abbreviations


" Filetype Perl ----------------------- {{{
augroup filetypeperl
    autocmd!
    autocmd FileType perl :iabbrev <buffer> dp use Data::Printer; p
augroup END
" }}}


" Filetype Perl6 ---------------------- {{{
" }}}
