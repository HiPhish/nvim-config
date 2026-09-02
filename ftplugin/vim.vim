" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use <S-K> to look up the word under the cursor in Vim help instead of
" searching for the manpage
noremap <buffer> <S-K> :help <C-R><C-W><CR> 

setlocal foldmethod=marker
setlocal foldtext=MyVimFoldText()

function! MyVimFoldText()
	let l:line = getline(v:foldstart)
	" Remove the leading '+-- 123 lines:' head
	let l:line = substitute(l:line, '\v\+\-\-\s\d+\slines\:', '', '')
	" Remove the trailing fold marker
	let l:line = substitute(l:line, '\v\s*\{\{\{$', '', '')

	return l:line
endfunction
