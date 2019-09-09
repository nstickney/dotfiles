" Autoread
set autoread  " automatically reload files changed outside vim
if ! exists("g:CheckUpdateStarted")
	let g:CheckUpdateStarted=1
	call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
	silent! checktime
	call timer_start(1000,'CheckUpdate')
endfunction

