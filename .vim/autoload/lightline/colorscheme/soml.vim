let s:black     = [ '#111111', 0 ]
let s:red       = [ '#fa7779', 1 ]
let s:green     = [ '#00b681', 2 ]
let s:gold      = [ '#c99800', 3 ]
let s:blue      = [ '#56a2ff', 4 ]
let s:magenta   = [ '#e77ac3', 5 ]
let s:orange    = [ '#f67d52', 6 ]
let s:lt_gray   = [ '#eeeeee', 7 ]
let s:gray      = [ '#444444', 8 ]
let s:b_red     = [ '#ffa5a4', 9 ]
let s:b_green   = [ '#5bd2a2', 10 ]
let s:b_gold    = [ '#e3b752', 11 ]
let s:b_blue    = [ '#90c0ff', 12 ]
let s:b_magenta = [ '#fba0db', 13 ]
let s:b_orange  = [ '#ffa789', 14 ]
let s:white     = [ '#bbbbbb', 15 ]

let s:p = {'normal': {},
			\ 'inactive': {},
			\ 'insert': {},
			\ 'visual': {},
			\ 'replace': {},
			\ 'tabline': {}}

let s:p.normal.left = [ [ s:black, s:blue ],
			\ [ s:lt_gray, s:gray ],
			\ [ s:white, s:black ] ]
let s:p.normal.right = [ [ s:lt_gray, s:gray ],
			\ [ s:white, s:black ] ]
let s:p.normal.middle = [ [ s:white, s:black ] ]
let s:p.normal.error = [ [ s:black, s:b_red ] ]
let s:p.normal.warning = [ [ s:black, s:b_orange ] ]

let s:p.inactive.left = [ [ s:white, s:black ],
			\ [ s:white, s:black ],
			\ [ s:white, s:black ] ]
let s:p.inactive.right = [ [ s:white, s:black ] ]

let s:p.insert.left = [ [ s:black, s:green ],
			\ [ s:lt_gray, s:gray ],
			\ [ s:white, s:black ] ]

let s:p.visual.left = [ [ s:black, s:gold ],
			\ [ s:lt_gray, s:gray ],
			\ [ s:white, s:black ] ]

let s:p.replace.left = [ [ s:black, s:red ],
			\ [ s:lt_gray, s:gray ],
			\ [ s:white, s:black ] ]

let s:p.tabline.left = [ [ s:white, s:black ] ]
let s:p.tabline.right = [ [ s:white, s:black ] ]
let s:p.tabline.tabsel = [ [ s:lt_gray, s:gray ] ]

let g:lightline#colorscheme#soml#palette = lightline#colorscheme#flatten(s:p)
