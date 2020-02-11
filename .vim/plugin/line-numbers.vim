" @cur33's Line Numbers function
function LineNumberToggle() abort
	if(&relativenumber != 1)
		set number!
	endif
	set relativenumber!
endfunction
nnoremap <C-n> :call LineNumberToggle()<CR>
call LineNumberToggle()
