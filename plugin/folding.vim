" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

function! MyFoldtext()
	let l:line = substitute(getline(v:foldstart), "\t", repeat(' ', &ts), 'g')
	let l:nlines = v:foldend - v:foldstart
	let l:fillcount = winwidth('%') - len(l:line) - len(l:nlines) - 14

	return printf('%s %s (%d L) ', l:line, repeat(' ', l:fillcount), l:nlines)
endfunction

set foldcolumn=auto:2
set foldtext=MyFoldtext()
