" https://vi.stackexchange.com/a/9930
" https://vi.stackexchange.com/a/11731
" https://clang.llvm.org/docs/ClangFormat.html
command! -buffer -range=% ClangFMT let myview = winsaveview() |
			\ setlocal shellredir=> |
			\ execute <line1> . "," . <line2> . "!clang-format" |
			\ set shellredir< |
			\ call winrestview(myview)

augroup ClangFMT
	autocmd!| " Remove all auto-commands from ClangFMT
	autocmd BufWritePre *.c silent ClangFMT
	autocmd BufWritePre *.cc silent ClangFMT
	autocmd BufWritePre *.cpp silent ClangFMT
	autocmd BufWritePre *.h silent ClangFMT
augroup END
