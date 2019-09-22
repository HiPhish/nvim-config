" License:  The MIT License (MIT) {{{
"    Copyright (c) 2019 HiPhish
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


let g:lightline = exists('g:lightline') ? g:lightline : {}

" ===[ Appearance ]============================================================
augroup lightline-events
	autocmd!
	autocmd ColorScheme * call s:onColorSchemeChange(expand('<amatch>'))
augroup END

let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}


" ===[ Components ]============================================================
let g:lightline.component = {
	\ 'readonly': '%{&ro ? " " : ""}',
	\ 'modified': '%{&ro ? "" : (&mod ? "+" : "")}',
	\ 'clock': '%{strftime("%H:%M")}',
	\ 'date': '%{strftime("%F %a")}',
	\ 'gitbranch': '%{exists("*fugitive#head") ? " ".fugitive#head() : ""}',
\ }

let g:lightline.component_raw = {
	\ 'readonly': v:true,
	\ 'modified': v:true,
\ }

" Never show the separator for components with visibility 'v:false'
let g:lightline.component_visible_condition = {
	\ 'readonly': 'v:false',
	\ 'modified': 'v:false',
	\ 'gitbranch': 'exists("*fugitive#head") && !empty(fugitive#head())'
\ }


" ===[ Status lines ]==========================================================
let g:lightline.tabline = {'right': [['clock', 'date'], ['gitbranch']]}
let g:lightline.inactive = {'left': [['filename', 'modified']]}


" ===[ Other stuff ]===========================================================
" Switching colours on the fly: if ':colorscheme' has been executed the
" following callback function will be called.
let s:colour_scheme_map = {'NeoSolarized': 'solarized'}
function! s:onColorSchemeChange(scheme)
	" Try a scheme provided already; this will fail if the auto-loaded file
	" has not been sourced yet
	execute 'runtime autoload/lightline/colorscheme/'.a:scheme.'.vim'
	if exists('g:lightline#colorscheme#{a:scheme}#palette')
		let g:lightline.colorscheme = a:scheme
	else  " Try falling back to a known colour scheme
		let l:colors_name = get(s:colour_scheme_map, a:scheme, '')
		if empty(l:colors_name)
			return
		else
			let g:lightline.colorscheme = l:colors_name
		endif
	endif
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

" Perform an initial automatic colour setting
call s:onColorSchemeChange(g:colors_name)
