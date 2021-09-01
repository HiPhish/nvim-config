"                                                   .:::::.
"                                                  :: ::::::
"  ____          _    _                            ````:::::
" |  _ \  _   _ | |_ | |__    ___   _ __     .:::::::::::::: iiii.
" | |_) || | | || __|| '_ \  / _ \ | '_ \   :::::::::::::::: iiiiii
" |  __/ | |_| || |_ | | | || (_) || | | |  :::::: ..........iiiiii
" |_|     \__, | \__||_| |_| \___/ |_| |_|   ':::: iiiiiiiiiiiiii'
"         |___/                                    iiiii....
"                                                  iiiiii ii
"                                                   'iiiii'
" License:  The MIT License (MIT) {{{
"    Copyright (c) 2018-2021 HiPhish
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

setlocal foldmethod=indent

" REPL support
nmap <leader>rs  <Plug>(ReplSend)
nmap <leader>rss <Plug>(ReplSendLine)
nmap <leader>rs_ <Plug>(ReplSendLine)

vmap <leader>rs  <Plug>(ReplSend)

try
	let s:settings = PycodestyleSettings()
	" Calling it a second time, workaround until pynvim gets fixed
	let s:settings = PycodestyleSettings()

	let &textwidth = get(s:settings, 'max-line-length', &textwidth)
	let &tabstop = get(s:settings, 'indent-size', &tabstop)
catch /\v.*/
	" Intentionally ignored
endtry
