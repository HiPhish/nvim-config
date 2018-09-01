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

" Snippet settings
let g:UltiSnipsEditSplit = 'context'


" Deoplete settings
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif

" We want the preview window to split below the current window
autocmd WinEnter * if &previewwindow | wincmd J | endif

" Close the previews window (displays e.g. documentation) automatically
autocmd InsertLeave,CompleteDone * if !pumvisible() | silent! pclose | endif

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'ultisnips']


let s:libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
let s:incclang_path = '/usr/include/clang/6.0/include/'

" Deoplete-Clang settings
let g:deoplete#sources#clang#libclang_path = s:libclang_path
let g:deoplete#sources#clang#clang_header  = s:incclang_path

