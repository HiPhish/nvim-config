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

augroup ManStatusLine
	autocmd!
	autocmd BufEnter <buffer> call s:setStl(s:activeStatus())
	autocmd WinEnter <buffer> call s:setStl(s:activeStatus())
	autocmd WinLeave <buffer> call s:setStl(s:passiveStatus())
augroup END

function! s:setStl(stl)
	call nvim_win_set_option(nvim_get_current_win(),'stl',a:stl)
endfunction

function! s:activeStatus()
	let l:name = nvim_buf_get_name(nvim_get_current_buf())

	let l:stl = ''
	let l:stl.= '%#StatusLine# man %#User5# '
	let l:stl.= '%#User3#'
	let l:stl.= fnamemodify(l:name, ':t:r').'%#User4#'
	let l:stl.= '%#TabLineFill#'
	let l:stl.= '%='
	let l:stl.= '%#User4#%#User3# %3.p%%'
	let l:stl.= ' %#User5#%#StatusLine#%3.l:%-3.c'
	return l:stl
endfunction

function! s:passiveStatus()
	let l:name = nvim_buf_get_name(nvim_get_current_buf())

	let l:stl = ''
	let l:stl.= '%#TabLineFill#'
	let l:stl.= fnamemodify(l:name, ':t:r').'  '
	let l:stl.= '%='
	let l:stl.= '%3.p%%'
	let l:stl.= ' %#User4#%#User3#%3.l:%-3.c'
	return l:stl
endfunction

