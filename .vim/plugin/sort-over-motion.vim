" https://sharats.me/posts/automating-the-vim-workplace/
" Sort lines, selected or over motion.
xnoremap <silent> gs :sort i<CR>
nnoremap <silent> gs :set opfunc=SortLines<CR>g@
fun! SortLines(type) abort
    '[,']sort i
endfun

" Reverse lines, selected or over motion.
nnoremap <silent> gr :set opfunc=ReverseLines<CR>g@
vnoremap <silent> gr :<C-u>call ReverseLines('vis')<CR>
fun! ReverseLines(type) abort
    let marks = a:type ==? 'vis' ? '<>' : '[]'
    let [_, l1, c1, _] = getpos("'" . marks[0])
    let [_, l2, c2, _] = getpos("'" . marks[1])
    if l1 == l2
        return
    endif
    for line in getline(l1, l2)
        call setline(l2, line)
        let l2 -= 1
    endfor
endfun
