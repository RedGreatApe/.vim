" Despacio — matches AlessandroYorba/Despacio colorscheme

let g:airline#themes#despacio#palette = {}

let s:desp_a = ['#303030', '#af875f', 236, 137]
let s:desp_b = ['#eeeeee', '#262626', 255, 235]
let s:desp_c = ['#5f8787', '#303030', 66, 236]
let g:airline#themes#despacio#palette.normal = airline#themes#generate_color_map(s:desp_a, s:desp_b, s:desp_c)
let g:airline#themes#despacio#palette.normal_modified = {
      \ 'airline_c': ['#dfaf00', '#303030', 178, 236]}
let g:airline#themes#despacio#palette.normal_paste = {
      \ 'airline_a': ['#303030', '#dfaf00', 236, 178]}

let s:desp_a_insert = ['#303030', '#5f8787', 236, 66]
let g:airline#themes#despacio#palette.insert = airline#themes#generate_color_map(s:desp_a_insert, s:desp_b, s:desp_c)
let g:airline#themes#despacio#palette.insert_modified = g:airline#themes#despacio#palette.normal_modified
let g:airline#themes#despacio#palette.insert_paste = g:airline#themes#despacio#palette.normal_paste
let g:airline#themes#despacio#palette.terminal = g:airline#themes#despacio#palette.insert

let s:desp_a_visual = ['#303030', '#dfaf00', 236, 178]
let g:airline#themes#despacio#palette.visual = airline#themes#generate_color_map(s:desp_a_visual, s:desp_b, s:desp_c)
let g:airline#themes#despacio#palette.visual_modified = g:airline#themes#despacio#palette.normal_modified

let g:airline#themes#despacio#palette.replace = copy(g:airline#themes#despacio#palette.insert)
let g:airline#themes#despacio#palette.replace.airline_a = ['#303030', '#d75f5f', 236, 167]
let g:airline#themes#despacio#palette.replace_modified = g:airline#themes#despacio#palette.insert_modified

let s:desp_a_inactive = ['#767676', '#262626', 243, 235]
let s:desp_b_inactive = ['#767676', '#262626', 243, 235]
let s:desp_c_inactive = ['#767676', '#303030', 243, 236]
let g:airline#themes#despacio#palette.inactive = airline#themes#generate_color_map(s:desp_a_inactive, s:desp_b_inactive, s:desp_c_inactive)
let g:airline#themes#despacio#palette.inactive_modified = g:airline#themes#despacio#palette.normal_modified

let s:desp_a_cmd = ['#303030', '#af875f', 236, 137]
let g:airline#themes#despacio#palette.commandline = airline#themes#generate_color_map(s:desp_a_cmd, s:desp_b, s:desp_c)

let g:airline#themes#despacio#palette.accents = {
      \ 'red':    ['#d75f5f', '', 167, ''],
      \ 'orange': ['#ff875f', '', 209, ''],
      \ 'yellow': ['#dfaf00', '', 178, ''],
      \ 'green':  ['#5f8787', '', 66, '']}
