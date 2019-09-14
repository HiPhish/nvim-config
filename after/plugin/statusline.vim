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
set laststatus=2  " Always show the status line

" -----------------------------------------------------------------------------
hi StatusMode    guibg=#268bd2 guifg=#082d36


" -----------------------------------------------------------------------------
let s:activeLine=''
let s:activeLine.='%#StatusMode#\ %{statusline#mode()}\ '
let s:activeLine.='%#TabLine#\ '
let s:activeLine.='%{statusline#fugitive(\"\",\"\ │\ \")}'
let s:activeLine.='%{&modifiable?\"\":\"\ \"}'
let s:activeLine.='%t'
let s:activeLine.='%{&modified?\"+\":\"\ \"}'
let s:activeLine.='%#TablineFill#'
" right-hand side
let s:activeLine.='%='
let s:activeLine.='%{&fileformat.\"\ \"}'
let s:activeLine.='%{empty(&fileencoding)?\"\":\"\ │\ \".&fileencoding.\"\ \"}'
let s:activeLine.='%{empty(&filetype)?\"\":\"\ │\ \".&filetype}'
let s:activeLine.='\ '
let s:activeLine.='%#TabLine#'
let s:activeLine.='%3.p%%'
let s:activeLine.='\ %#StatusLine#\ '
let s:activeLine.='%3.l:%-3.c'

let s:passiveLine=''
let s:passiveLine.='%#TablineFill#'
let s:passiveLine.='%t'
let s:passiveLine.='%{&modified?\"+\":\"\"}'
let s:passiveLine.='%='
let s:passiveLine.='%3.p%%'
let s:passiveLine.='\ '
let s:passiveLine.='%#TabLine#\ '
let s:passiveLine.='%3.l:%-3.c'

" -----------------------------------------------------------------------------
set tabline=%!statusline#tabline()
exe 'set statusline='.s:activeLine

" -----------------------------------------------------------------------------
autocmd BufEnter * exe 'setlocal statusline='.s:activeLine
autocmd WinEnter * exe 'setlocal statusline='.s:activeLine
autocmd WinLeave * exe 'setlocal statusline='.s:passiveLine
