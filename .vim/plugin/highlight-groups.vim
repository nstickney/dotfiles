" https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/

"" List highlight groups applied under the cursor
nnoremap <F6> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . 
			\ '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . 
			\ "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . 
			\ ">"<CR>
"" See ALL highlight groups under cursor
nnoremap <F7> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"" See ALL highlight groups in Vim
nnoremap <F8> :so $VIMRUNTIME/syntax/hitest.vim<CR>
