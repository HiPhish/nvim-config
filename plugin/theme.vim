"   ________                           ___
"  /_  __/ /_  ___  ____ ___  ___     ( _ )
"   / / / __ \/ _ \/ __ `__ \/ _ \   / __ \/|
"  / / / / / /  __/ / / / / /  __/  / /_/  <
" /_/ /_/ /_/\___/_/ /_/ /_/\___/   \____/\/   Visual appearance
"     ___                                      and theme settings
"    /   |  ____  ____  ___  ____ __________ _____  ________
"   / /| | / __ \/ __ \/ _ \/ __ `/ ___/ __ `/ __ \/ ___/ _ \
"  / ___ |/ /_/ / /_/ /  __/ /_/ / /  / /_/ / / / / /__/  __/
" /_/  |_/ .___/ .___/\___/\__,_/_/   \__,_/_/ /_/\___/\___/
"       /_/   /_/
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


" Alternate cursor shape in insert mode
if has('nvim')
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
elseif $TERM_PROGRAM =~? 'iTerm'
	" iTerm2 only
	let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
	let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

if has('nvim')
	set termguicolors   " Use GUI colours in the terminal
endif


" Colour theme
set background=dark
let g:neosolarized_italic = 1
highlight link MsgSeparator VertSplit
