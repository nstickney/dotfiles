" Don't use prettier, it sucks for markdown (3 spaces indent?!!)
let b:ale_fixers = ['prettier']

" Format tables nicely
nnoremap <F12> :TableFormat<CR>
inoremap <F12> <C-o><F12>

" tpope/vim-markdown (Vim's included markdown plugin)
let g:markdown_syntax_conceal = 0

" plasticboy/vim-markdown (More markdown stuff)
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal = ''
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
