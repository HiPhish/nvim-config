" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018 HiPhish
"
"    Permission is hereby granted, free of charge, to any person obtaining a
"    copy of this software and associated documentation files (the
"    "Software"), to deal in the Software without restriction, including
"    without limitation the rights to use, copy, modify, merge, publish,
"    distribute, sublicense, and/or sell copies of the Software, and to permit
"    persons to whom the Software is furnished to do so, subject to the
"    following conditions:
"
"    The above copyright notice and this permission notice shall be included
"    in all copies or substantial portions of the Software.
"
"    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
"    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
"    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
"    USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

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
