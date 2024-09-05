"        _ _         _      
"       (_|_)___    (_)___ _
"      / / / __ \  / / __ `/  An HTML template engine
"     / / / / / / / / /_/ / 
"  __/ /_/_/ /_/_/ /\__,_/  
" /___/       /___/         
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


" Use tabs for indentation, appear two spaces wide
setlocal noexpandtab copyindent preserveindent
setlocal softtabstop=0 shiftwidth=2 tabstop=2

" If the other language has Tree-sitter highlighting regular syntax
" highlighting will be disabled.  This autocommand forces it back on.
if !exists('b:jinja_syntax_autocmd_loaded')
	let b:jinja_syntax_autocmd_loaded = v:true
	" TODO: test if there really is no Tree-sitter support for Jinja
	autocmd FileType <buffer> setlocal syntax=on
endif
