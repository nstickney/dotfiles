" https://vi.stackexchange.com/a/9930
" https://vi.stackexchange.com/a/11731
command! -buffer -range=% ScalaFMT let myview = winsaveview() |
			\ setlocal shellredir=> |
			\ execute <line1> . "," . <line2> . "!scalafmt --stdin" |
			\ set shellredir< |
			\ call winrestview(myview)

augroup ScalaFMT
	autocmd BufWritePre *.scala silent ScalaFMT
augroup END
