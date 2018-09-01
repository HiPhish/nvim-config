"     ____             __        __
"    / __ \____ ______/ /_____  / /_
"   / /_/ / __ `/ ___/ //_/ _ \/ __/
"  / _, _/ /_/ / /__/ ,< /  __/ /_
" /_/ |_|\__,_/\___/_/|_|\___/\__/
"
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


" This highlights matching braces in insert-mode
setlocal showmatch

" Use spaces for aligning braces
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

augroup autochecking
	autocmd!
	autocmd! BufWritePost <buffer> Neomake
augroup END


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
