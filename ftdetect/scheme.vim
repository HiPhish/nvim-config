" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018-2019 HiPhish
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

autocmd! BufRead,BufNewFile *.scm set ft=scheme | call <SID>detect_implementation()

" Detect the implementation and append it to the file type.
function! s:detect_implementation()
	" Guile uses the shebang in the first line
	if getline(1) =~? '\v^#!.*[Gg]uile'
		let &filetype .= '.guile'
		return
	endif
	" Search for a module definition
	let l:save_cursor = getcurpos()
	call cursor(1, 1)
	if search('\v\(\s*(define-module|use-modules)\s*\(', 'c', 0, 1000)
		let &filetype .= '.guile'
	endif
	call setpos('.', l:save_cursor)
endfunction
