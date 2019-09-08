" =============================================================================
" Filename: autoload/lightline/colorscheme/soml.vim
" Author: stick
" License: Mozilla Public License, v. 2.0
" Last Change: 2019/09/07 21:11
" =============================================================================

let s:black     = [ '#1b1b1b', 0 ]
let s:red       = [ '#d73753', 1 ]
let s:green     = [ '#907234', 2 ]
let s:brown     = [ '#c15522', 3 ]
let s:blue      = [ '#7a64e9', 4 ]
let s:magenta   = [ '#b25694', 5 ]
let s:cyan      = [ '#538160', 6 ]
let s:lt_gray   = [ '#c6c6c6', 7 ]
let s:gray      = [ '#474747', 8 ]
let s:b_red     = [ '#ff7384', 9 ]
let s:b_green   = [ '#c8a565', 10 ]
let s:yellow    = [ '#fe8a53', 11 ]
let s:b_blue    = [ '#b497ff', 12 ]
let s:b_magenta = [ '#ec8bca', 13 ]
let s:b_cyan    = [ '#86b693', 14 ]
let s:white     = [ '#e2e2e2', 15 ]

let s:p = {'normal': {},
			\ 'inactive': {},
			\ 'insert': {},
			\ 'replace': {},
			\ 'visual': {},
			\ 'tabline': {}}

let s:p.normal.left = [ [ s:white, s:blue ],
			\ [ s:black, s:lt_gray ],
			\ [ s:lt_gray, s:black ] ]
let s:p.normal.right = [ [ s:black, s:lt_gray ],
			\ [ s:lt_gray, s:black ] ]
let s:p.normal.middle = [ [ s:black, s:gray ] ]
let s:p.normal.error = [ [ s:black, s:b_red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let s:p.insert.left = [ [ s:white, s:cyan ],
			\ [ s:black, s:lt_gray ],
			\ [ s:lt_gray, s:black ] ]

let s:p.visual.left = [ [ s:white, s:green ],
			\ [ s:black, s:lt_gray ],
			\ [ s:lt_gray, s:black ] ]

let s:p.replace.left = [ [ s:white, s:red ],
			\ [ s:black, s:lt_gray ],
			\ [ s:lt_gray, s:black ] ]

let s:p.tabline.left = [ [ s:black, s:lt_gray ] ]
let s:p.tabline.right = [ [ s:black, s:lt_gray ] ]
let s:p.tabline.tabsel = [ [ s:lt_gray, s:brown ] ]

let g:lightline#colorscheme#soml#palette = lightline#colorscheme#flatten(s:p)
