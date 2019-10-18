" @cur33's Line Numbers function
function LineNumberToggle()
if(&relativenumber != 1)
	set number!
endif
set relativenumber!
endfunc
nnoremap <C-n> :call LineNumberToggle()<CR>
call LineNumberToggle()
