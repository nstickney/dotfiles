" https://discourse.gohugo.io/t/vim-syntax-highlighting-for-hugo-html-templates/19398/8
function DetectGoHtmlTmpl()
    if expand('%:e') ==# 'html' && search('{{') != 0
        set filetype=gohtmltmpl
		let b:ale_fixers=[]
    endif
endfunction

if exists('did_load_filetypes')
  finish
endif
augroup filetypedetect
    autocmd! BufNewFile,BufRead *.ad setlocal filetype=asciidoc
    autocmd! BufNewFile,BufRead *.toml setlocal filetype=toml
	autocmd! BufNewFile,BufRead,BufWritePre *.html call DetectGoHtmlTmpl()
augroup END
