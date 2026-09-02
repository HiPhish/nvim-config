" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" An alternative terminal command, opens the terminal in a new window
command! -bang -nargs=? -complete=shellcmd Terminal call <SID>term(<q-bang>, <q-mods>, <q-args>)

function! s:term(bang, mods, args)
	if empty(a:bang)
		execute a:mods 'new'
	endif
	execute 'terminal' a:args
	normal! G$a
endfunction

autocmd TermOpen * setlocal nospell
