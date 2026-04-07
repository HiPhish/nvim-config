"        __     ___           _ __  __  ___      __     
"   ____/ /__  / (_)___ ___  (_) /_/  |/  /___ _/ /____ 
"  / __  / _ \/ / / __ `__ \/ / __/ /|_/ / __ `/ __/ _ \
" / /_/ /  __/ / / / / / / / / /_/ /  / / /_/ / /_/  __/
" \__,_/\___/_/_/_/ /_/ /_/_/\__/_/  /_/\__,_/\__/\___/ 
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

scriptencoding utf-8

let g:delimitMate_expand_space         = 1
let g:delimitMate_expand_cr            = 1
let g:delimitMate_expand_inside_quotes = 1


augroup VimScript
	autocmd FileType vim let b:delimitMate_quotes = "'"
augroup END

augroup TeX-Family
	" This one is which you're most likely to use?
	autocmd FileType tex,latex,plaintex let b:delimitMate_quotes = '$ " ''' 
	autocmd FileType tex,latex,plaintex let b:delimitMate_matchpairs = '(:),[:],{:}'
augroup end

augroup Lua
	autocmd FileType lua let b:delimitMate_quotes = '" '''
augroup END

augroup SGML-Family
	autocmd FileType html,xml let b:delimitMate_matchpairs = '(:),[:],{:},<:>'
augroup END

augroup Jinja
	autocmd FileType jinja   let b:delimitMate_quotes = '" '''
	autocmd FileType jinja.* let b:delimitMate_quotes = '" '''

	autocmd FileType *.jinja
				\ if exists('b:delimitMate_quotes')
				\ | let b:delimitMate_quotes.='" '' # %'
				\ | else
				\ | let b:delimitMate_quotes='" '' # %'
				\ | endif
augroup END

augroup Django
	autocmd!
	autocmd FileType htmldjango let b:delimitMate_quotes = '" '' # %'
augroup END

augroup Lisp-Family
	autocmd FileType lisp,scheme,racket  let b:delimitMate_quotes = '"'
	autocmd FileType lisp,scheme,racket  let b:delimitMate_expand_cr = 1
	autocmd FileType lisp,scheme,racket  let b:delimitMate_matchpairs = '(:),[:]'
augroup END


augroup Info-Files
	autocmd FileType info let b:delimitMate_matchpairs = &matchpairs.',‘:’'
augroup END
