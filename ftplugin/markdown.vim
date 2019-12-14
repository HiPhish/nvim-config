"    The shitty markup everyone is using
"  __  __            _       _                          __  __   __
" |  \/  | __ _ _ __| | ____| | _____      ___ __      |  \/  |  ||
" | |\/| |/ _` | '__| |/ / _` |/ _ \ \ /\ / / '_ \     | |\/| | _||_
" | |  | | (_| | |  |   < (_| | (_) \ V  V /| | | |    | |  | | \  /
" |_|  |_|\__,_|_|  |_|\_\__,_|\___/ \_/\_/ |_| |_|    |_|  |_|  \/
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

scriptencoding utf-8

setlocal textwidth=79
" Use spaces instead of tabs
setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab
" Do not hide any characters
setlocal conceallevel=0

" Disable some features for special Markdown buffers. These buffers are usually
" created by Vim to be read by a person, not to be edited. For such buffers
" the following features are more distracting than they are useful.
if &buftype =~ 'nofile'
	setlocal nospell
	setlocal conceallevel=2
	setlocal concealcursor=nc
endif
