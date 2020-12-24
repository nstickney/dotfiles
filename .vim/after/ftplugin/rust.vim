let b:ale_fixers = ['rustfmt']
let g:ale_linters = {'rust': ['rustc', 'analyzer']}
let g:completor_racer_binary = 'racer'
let g:completor_filetype_map.rust = {'ft': 'lsp', 'cmd': 'rls'}
