function! ClangFormatOnSave() abort
	let l:formatdiff = 1
	pyf /usr/share/clang/clang-format.py
endfunction
augroup ClangFormat
	autocmd!| " Remove all auto-commands from ClangFormat
	autocmd BufWritePre *.h,*.cc,*.cpp call ClangFormatOnSave()
augroup END
