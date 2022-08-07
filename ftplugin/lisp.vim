"    ______  ANSI                                   __    _          
"   / ____/___  ____ ___  ____ ___  ____  ____     / /   (_)________ 
"  / /   / __ \/ __ `__ \/ __ `__ \/ __ \/ __ \   / /   / / ___/ __ \
" / /___/ /_/ / / / / / / / / / / / /_/ / / / /  / /___/ (__  ) /_/ /
" \____/\____/_/ /_/ /_/_/ /_/ /_/\____/_/ /_/  /_____/_/____/ .___/ 
"                                                           /_/      
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

" Use spaces for everything
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Everything, except parentheses, pipe, semicolon, comma, single quote, double
" quote and space
setlocal iskeyword=33-126,^(,^),^124,^;,^,,^',^`,^34

" Repl settings
call repl#define_repl('lisp', {'bin': 'sbcl', 'args': ['--linedit']}, 'force')


" ===[ Vlime settings ]========================================================
" Enable interaction mode by default (this API function is not in master yet)
" silent call vlime#plugin#InteractionMode(v:true)
try
	silent call vlime#plugin#InteractionMode()

	nnoremap K  :call <SID>go_documentation()<CR>
	nnoremap gd :call <SID>go_definition()<CR>

	function! s:go_documentation()
		let l:connection = vlime#connection#Get(v:true)
		if type(l:connection) == type({}) && l:connection.IsConnected()
			call vlime#plugin#DocumentationSymbol(vlime#ui#CurAtom())
		endif
	endfunction

	function! s:go_definition()
		let l:connection = vlime#connection#Get(v:true)
		if type(l:connection) == type({}) && l:connection.IsConnected()
			call vlime#plugin#FindDefinition(vlime#ui#CurAtom())
		endif
	endfunction
catch
endtry
