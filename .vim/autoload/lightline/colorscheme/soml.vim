" =============================================================================
" Filename: autoload/lightline/colorscheme/soml.vim
" Author: stick
" License: Mozilla Public License, v. 2.0
" Last Change: 2019/09/08 15:43
" =============================================================================

let s:black     = [ '#1a1a1a', 0 ]
let s:red       = [ '#c22436', 1 ]
let s:green     = [ '#a58440', 2 ]
let s:brown     = [ '#e64d00', 3 ]
let s:blue      = [ '#0077e6', 4 ]
let s:magenta   = [ '#ab3b85', 5 ]
let s:cyan      = [ '#35b181', 6 ]
let s:lt_gray   = [ '#e6e6e6', 7 ]
let s:gray      = [ '#333333', 8 ]
let s:b_red     = [ '#df5363', 9 ]
let s:b_green   = [ '#c6a86c', 10 ]
let s:yellow    = [ '#ff7733', 11 ]
let s:b_blue    = [ '#339cff', 12 ]
let s:b_magenta = [ '#cb67aa', 13 ]
let s:b_cyan    = [ '#6sd0a6', 14 ]
let s:white     = [ '#fff8e7', 15 ]

let s:p = {'normal': {},
			\ 'inactive': {},
			\ 'insert': {},
			\ 'visual': {},
			\ 'replace': {},
			\ 'tabline': {}}

let s:p.normal.left = [ [ s:white, s:blue ],
			\ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]
let s:p.normal.right = [ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]
let s:p.normal.middle = [ [ s:black, s:gray ] ]
let s:p.normal.error = [ [ s:black, s:b_red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let s:p.inactive.left = [ [ s:white, s:gray ],
			\ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]
let s:p.inactive.right = [ [ s:lt_gray, s:gray ] ]

let s:p.insert.left = [ [ s:white, s:cyan ],
			\ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]

let s:p.visual.left = [ [ s:white, s:green ],
			\ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]

let s:p.replace.left = [ [ s:white, s:red ],
			\ [ s:gray, s:lt_gray ],
			\ [ s:lt_gray, s:gray ] ]

let s:p.tabline.left = [ [ s:lt_gray, s:gray ] ]
let s:p.tabline.right = [ [ s:lt_gray, s:gray ] ]
let s:p.tabline.tabsel = [ [ s:gray, s:lt_gray ] ]

let g:lightline#colorscheme#soml#palette = lightline#colorscheme#flatten(s:p)
