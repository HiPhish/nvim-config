" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" This highlights matching braces in insert-mode
setlocal showmatch

" Use spaces for aligning braces
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Open a REPL with the current file entered into
nnoremap <leader>re :call <SID>enter_repl('')<CR>
nnoremap <leader>vre :call <SID>enter_repl('vert')<CR>
function! s:enter_repl(mode)
	execute a:mode . ' Repl - -i -e ''(enter! "' . expand('%') . '")'''
endfunction

set omnifunc=CompleteRacket

function! CompleteRacket(findstart, base)
	" These characters mark the end of an identifier
	if a:findstart
		let l:line = getline('.')
		let l:col = col('.') - 1
		echom l:line
		while l:col > 0
			if l:line[l:col - 1] =~? '\v\k'
				echom "decr"
				let l:col -= 1
			else
				echom "derp"
				break
			endif
		endwhile
		echom l:col
		return l:col
	endif

	" return ['herp', 'derp']
	return RacketCompletions(a:base)
endfunction
