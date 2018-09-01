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

function! statusline#mode()
	" Text, background, foreground
	let l:modeString = {
		\ 'n'  : ['NORMAL'             , '#268bd2', '#082d36'],
		\ 'no' : ['N·OPERATOR PENDING' , '#268bd2', '#082d36'],
		\ 'v'  : ['VISUAL'             , '#d33682', '#082d36'],
		\ 'V'  : ['V·LINE'             , '#d33682', '#082d36'],
		\ '' : ['V·BLOCK'            , '#d33682', '#082d36'],
		\ 's'  : ['SELECT'             , '#268bd2', '#082d36'],
		\ 'S'  : ['S·LINE'             , '#268bd2', '#082d36'],
		\ '' : ['S·BLOCK'            , '#268bd2', '#082d36'],
		\ 'i'  : ['INSERT'             , '#859900', '#082d36'],
		\ 'R'  : ['REPLACE'            , '#dc322f', '#082d36'],
		\ 'Rv' : ['V·REPLACE'          , '#dc322f', '#082d36'],
		\ 'c'  : ['COMMAND'            , '#268bd2', '#082d36'],
		\ 'cv' : ['VIM EX'             , '#268bd2', '#082d36'],
		\ 'ce' : ['EX'                 , '#268bd2', '#082d36'],
		\ 'r'  : ['PROMPT'             , '#268bd2', '#082d36'],
		\ 'rm' : ['MORE'               , '#268bd2', '#082d36'],
		\ 'r?' : ['CONFIRM'            , '#268bd2', '#082d36'],
		\ '!'  : ['SHELL'              , '#268bd2', '#082d36'],
		\ 't'  : ['TERMINAL'           , '#859900', '#082d36']
	\ }
	let [l:modeString, l:bg, l:fg] = get(l:modeString, mode(), [mode(), '268bd2', '082d36'])

	exe 'hi StatusMode    guibg='.l:bg.' guifg='.l:fg
	exe 'hi StatusModeSep guibg=#657b83  guifg='.l:bg

	return l:modeString
endfunction

function! statusline#fugitive(lsep, rsep)
	if exists('*fugitive#head')
		let l:head = fugitive#head()
		return strlen(l:head) ? a:lsep.' '.l:head.''.a:rsep.'' : ''
	endif
	return ''
endfunction

function! statusline#tabline()
	let l:line=''

	" Loop over the individual tabs
	for l:tab in range(1, tabpagenr('$'))
		" TODO: If the file name is a directory then display the last element
		" of the path
		let l:fname=fnamemodify(bufname(tabpagebuflist(l:tab)[tabpagewinnr(l:tab) - 1]), ':t')
		if empty(l:fname)
			let l:fname = '[No name]'
		endif

		" Different highlighting for active and passive tabs
		if s:isActiveTab(l:tab)
			let l:line .= '%#TabLineSel#'
		else
			let l:line .= '%#TabLine#'
		endif

		" [tab-number] [file-name] 
		let l:line .= '%'.l:tab.'T '.l:tab.' '.l:fname.' %T'

		" Separator and highlighting, a PITA due to the triangles
		if s:isActiveTab(l:tab) && s:isLastTab(l:tab)
			let l:line .= '%#TabSepActiveLast#'
		elseif s:isActiveTab(l:tab)
			let l:line .= '%#TabSepActivePassive#'
		elseif s:isLastTab(l:tab)
			let l:line .= '%#TabSepPassiveLast#'
		elseif s:isActiveTab(l:tab+1)
			let l:line .= '%#TabSepPassiveActive#'
		else
			let l:line .= ''
		endif
	endfor

	" Git branch if applicable
	let l:line.= '%#TabLineFill#%=%{statusline#fugitive(" "," ")}'
	" Clock and calendar
	let l:line.='%=%#User6#%#StatusLine#'
	let l:line.=' %{strftime("%H:%M")}'
	let l:line.='  %{strftime("%F %a")} '

	return l:line
endfunction

function! s:isActiveTab(tab)
	return a:tab == tabpagenr()
endfunction

function! s:isLastTab(tab)
	return a:tab == tabpagenr('$')
endfunction

