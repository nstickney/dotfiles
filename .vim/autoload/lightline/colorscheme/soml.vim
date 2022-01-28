let s:black     = [ '#1a1a1a', 0 ]
let s:red       = [ '#df5363', 1 ]
let s:green     = [ '#9e7e3d', 2 ]
let s:brown     = [ '#eb4e00', 3 ]
let s:blue      = [ '#0081fa', 4 ]
let s:magenta   = [ '#c75ca3', 5 ]
let s:cyan      = [ '#2d956d', 6 ]
let s:lt_gray   = [ '#c7c7c7', 7 ]
let s:gray      = [ '#363636', 8 ]
let s:b_red     = [ '#ea8b96', 9 ]
let s:b_green   = [ '#c2a161', 10 ]
let s:yellow    = [ '#ff8142', 11 ]
let s:b_blue    = [ '#52abff', 12 ]
let s:b_magenta = [ '#d88dbf', 13 ]
let s:b_cyan    = [ '#37b897', 14 ]
let s:white     = [ '#e6e6e6', 15 ]

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
