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


let g:lightline = {}

" ===[ Appearance ]============================================================
augroup lightline-colorscheme-overrides
	autocmd!
	autocmd ColorScheme * call s:onColorChange()
augroup END

let g:lightline.colorscheme = 'gruvbox'
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


" =============================================================================
let s:colour_map = {'NeoSolarized': 'solarized', 'gruvbox': 'gruvbox'}
function! s:onColorChange()
	" If we cannot get the name of the colour scheme all bets are off
	if !exists('g:colors_name')
		echom "No colours name"
		return
	endif
	" Try a scheme provided already
	if exists('lightline#colorscheme#{g:colors_name}#palette')
		let g:lightline.colorscheme = g:colors_name
	else
		" Last resort: try falling back to a known colour scheme
		let l:colors_name = get(s:colour_map, g:colors_name, '')
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
