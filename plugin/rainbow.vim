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

" Settings used by the plugin luochen1990/rainbow
let g:rainbow_active = 1

let s:jinja_statements = 'if|for|raw|block|macro|call|filter|trans|with|autoescape'

" Colours
" Green, cyan, yellow, orange, blue, red, br-cyan, magenta, br-yellow, violet,
" br-blue

" This is the default example, change it
let g:rainbow_conf = {
\	'guifgs': ['#859901', '#2aa198', '#b58901', '#cb4b16', '#268bd2', '#dc322f', '#93a1a1', '#d33682', '#657b83', '#6c6ec6', '#839496'],
\	'ctermfgs': ['2', '4', '3', '9', '4', '1', '14', '5', '11', '13', '12'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': 0,
\		'lisp': {
\			'parentheses': ['start=/\m[''`,#@]*(/ end=/\m)/'], 'operators': ''
\		},
\		'racket': {
\			'parentheses': ['start=/\m[''`,#@]*(/ end=/\m)/', 'start=/\v[''`,#@]*\[/ end=/\v\]/'], 'operators': ''
\		},
\		'scheme': {
\			'parentheses': ['start=/\m[''`,#@]*(/ end=/\m)/', 'start=/\v[''`,#@]*\[/ end=/\v\]/'], 'operators': ''
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'jinja': {
\			'parentheses': [
\				'start=/\v\{\%\-?\+?\s*\z('.s:jinja_statements.').*\s*\-?\+?\%\}/ step=/\v\{\%\-?\+?\s*else\s*\-?\+?\%\}/ end=/\v\{\%\-?\+?\s*end\z1(\s+\w+)?\s*\-?\+?\%\}/']
\		},
\		'html.jinja': {
\			'parentheses': [
\				'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold',
\				'start=/\v\{\%\-?\+?\s*\z('.s:jinja_statements.').*\s*\-?\+?\%\}/ step=/\v\{\%\-?\+?\s*else\s*\-?\+?\%\}/ end=/\v\{\%\-?\+?\s*end\z1(\s+\w+)?\s*\-?\+?\%\}/']
\		},
\		'css': 0,
\	},
\}


" Some Jinja statements also have in-between elements:
"   - if     elif, else
"   - for    else, continue, break
"   - trans  pluralize
