" License:  The MIT License (MIT) {{{
"    Copyright (c) 2024 HiPhish
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

" Add the target language of the PO file to the spelling languages if it is
" not yet part of the setting.  We assume that the PO file follows standard
" gettext file location rules.  This means it will be located under a path
" like 'foo/bar/baz/<locale>/LC_MESSAGES/derp.po'
let s:fname = expand('%')
if fnamemodify(s:fname, ':e') == 'po'  |" Skip POT files
	let s:spelllang = matchstr(fnamemodify(s:fname, ':h:h:t'), '\v^[[:lower:]]{2}\ze(_[[:upper:]]{2})?$')
	if indexof(split(&spelllang, ','), {_, v -> v == s:spelllang}) < 0
		let &l:spelllang = printf('%s,%s', &spelllang, s:spelllang)
	endif
endif
