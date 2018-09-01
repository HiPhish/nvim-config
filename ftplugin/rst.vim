"           ____  _                   _           _ _____         _
"  _ __ ___/ ___|| |_ _ __ _   _  ___| |_ ___  __| |_   _|____  _| |_
" | '__/ _ \___ \| __| '__| | | |/ __| __/ _ \/ _` | | |/ _ \ \/ / __|
" | | |  __/___) | |_| |  | |_| | (__| ||  __/ (_| | | |  __/>  <| |_
" |_|  \___|____/ \__|_|   \__,_|\___|\__\___|\__,_| |_|\___/_/\_\\__|
"                                      Like Markdown, except better :)
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

setlocal textwidth=79

" In a role there will be three characters before the name of the role (.. )
setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab

" Relative line numbers are too slow for reST and Riv (plugin)
setlocal norelativenumber

" Start out with unfolded documents
setlocal foldlevel=3

if exists('g:plugs["riv"]')
	"let g:riv_highlight_code .= ',c'
	let g:riv_highlight_code='lua,python,c,cpp,cs,javascript,vim,sh,racket,scheme,lisp'
endif

augroup autochecking
	autocmd!
	autocmd! BufWritePost <buffer> Neomake
augroup END
