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
"     _
"    | | __ ___   ____ _
" _  | |/ _` \ \ / / _` |
"| |_| | (_| |\ V / (_| |
" \___/ \__,_| \_/ \__,_|


" ---[ Build system detection ]------------------------------------------------
" Known build system specifications in decreasing order of relevance; a
" specifications is a list of three elements: the settings file, the name of
" the build system binary, and the wrapper file
let s:build_systems = [
	\ ['makefile', 'make', ''],
	\ ['Makefile', 'make', ''],
	\ ['build.gradle', 'gradle -q', 'gradlew -q'],
	\ ['pom.xml', 'mvn -q', 'mvnw -q'],
\ ]

for [s:settings, s:makeprg, s:wrapper] in s:build_systems
	if filereadable(s:settings)
		let &makeprg = executable(s:wrapper) ? './'..s:wrapper : s:makeprg
		break
	endif
endfor


" ---[ LanguageClient Neovim settings ]----------------------------------------
nnoremap <buffer> <silent> <CR>  :call LanguageClient_contextMenu()<CR>
nnoremap <buffer> <silent> gd    :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <silent> <C-S> :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <buffer> <silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer> <silent> K     :call LanguageClient#textDocument_hover()<CR>
