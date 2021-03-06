let g:word_count='<unknown>'
function WordCount() abort
	return g:word_count
endfunction
function UpdateWordCount() abort
	let lnum = 1
	let n = 0
	while lnum <= line('$')
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	let g:word_count = n
endfunction
augroup WordCounter
	autocmd!| " Remove all auto-commands from WordCounter
	autocmd BufNewFile,BufRead,FilterReadPost,FileReadPost * call UpdateWordCount()
	autocmd BufWritePost,FileWritePost,FileAppendPost,FilterWritePost * call UpdateWordCount()
	autocmd WinEnter,TabEnter,InsertLeave,QuickFixCmdPost * call UpdateWordCount()
augroup END
