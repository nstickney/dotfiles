fun! StripTrailingWhitespace()
	" Only strip if the b:noStripeWhitespace variable isn't set
	if exists('b:noStripWhitespace')
		return
	endif
	let l:save = winsaveview()
	%s/\s\+$//e
	call winrestview(l:save)
endfun

augroup StripTrailingWhitespace
	autocmd BufWritePre * call StripTrailingWhitespace()
	autocmd FileType markdown let b:noStripWhitespace=1
augroup END
