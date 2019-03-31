"  _____       __  __
" |_   _|      \ \/ /
"   | |  _____  \  /
"   | | | ____| /  \ 
"   |_| |  _|  /_/\_\
"       | |___ 
"       |_____|
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

" Disable the concealing feature entirely (does not swap commands for Unicode
" glyphs)
let g:tex_conceal =''

if exists('g:plugs["neomake"]')
	let g:neomake_tex_enabled_makers = ['chktex']
endif

augroup autochecking
	autocmd!
	autocmd! BufWritePost <buffer> Neomake
augroup END


" ===[ Auto-compilation ]======================================================

" Auto-compile if there is a makefile
let s:make_running = v:false  " There is a running make process
let s:make_pending = v:false  " Make needs to be run as soon as possible
let s:make_jobid = 0
let s:compile_errors = []

function! CompileLaTeX(target)
	" TODO: check if a makefile exists

	" If there is already a make process running keep track of the fact that
	" we need to re-run make as soon as possible
	if s:make_running
		let s:make_pending = v:true
		return
	endif

	" Start the compilation
	" echo 'Starting compilation'
	let s:make_running = v:true
	let s:make_pending = v:false
	let s:compile_errors = []
	let s:make_jobid   = jobstart(['make', a:target], {'on_exit': function('s:CompileDone')})
endfunction

" Callback when the make process terminates
function! s:CompileDone(job, data, event) dict
	" echo 'Compilation done'
	let s:make_running = v:false

	" If make exited unsuccessfully
	if a:data != 0
		echohl Error
		for msg in s:compile_errors
			echomsg msg
		endfor
		echohl None
	endif

	" If there is a compilation pending we need to re-compile
	if s:make_pending
		call CompileLaTeX()
	endif
endfunction

" Callback when the make process returns an error
function! s:CompileError(job, data, event)
	let s:compile_errors[-1] = a:data[0]
	call extend(s:compile_errors, a:data[1])
	return
endfunction

augroup autocompile
	autocmd!
	" this one is which you're most likely to use?
	autocmd BufWritePost *.tex call CompileLaTeX('pdf')
augroup end


" ===[ auto-detect language ]==================================================
let s:languages = {'german': 'de', 'ngerman': 'de', 'english': 'en'}
let s:curpos = getcurpos()
" Set language according to the Polyglossia package
let s:lang_line = search('\v\\setdefaultlanguage(\[.+\])?\{.+\}')
if s:lang_line
	let s:lang = matchstr(getline('.'), '\v\\setdefaultlanguage(\[.+\])?\{\zs.+\ze\}')
	let &spelllang = get(s:languages, s:lang, &spelllang)
endif
call setpos('.', s:curpos)
unlet s:curpos
