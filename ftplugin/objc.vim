" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use the same settings as for C as a basis
runtime ftplugin/c.vim

" Folding
setlocal foldtext=ObjcFoldText()

function! ObjcFoldText()
	let l:indent_level = indent(v:foldstart)
	let l:indent = repeat(' ',l:indent_level)

	let l:line = getline(v:foldstart)
	" Remove leading whitespace (will be simulated by l:indent)
	let l:line = substitute(l:line, '\v^\s+', '', '')
	" Remove the leading '+-- 123 lines:'
	let l:line = substitute(l:line, '\v\+\-\-\s\d+\slines\:', '', '')
	" Remove the arguments from method signatures ':(SomeType) var'
	let l:line = substitute(l:line, '\v\:\(.{-1,}\)\w+\s', ':', 'g')
	" Remove opening brace from end of line
	let l:line = substitute(l:line, '\v\s*\{?\s*$', '', 'g')
	
	return l:indent . l:line
endfunction
