setlocal softtabstop=4 shiftwidth=4 tabstop=4 expandtab

command! -buffer -range=% Pep8FMT let myview = winsaveview() |
			\ setlocal shellredir=> |
			\ execute <line1> . "," . <line2> . "!autopep8 -" |
			\ set shellredir< |
			\ call winrestview(myview)

augroup Pep8FMT
	autocmd!| " Remove all auto-commands from Pep8FMT
	autocmd BufWritePre *.py silent Pep8FMT
augroup END
