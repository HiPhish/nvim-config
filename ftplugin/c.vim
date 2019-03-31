"   ____ 
"  / ___|
" | |    
" | |___ 
"  \____|
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

" [ Compiler settings and plugins ] 
"
" Some plugins are based on clang and require project-specific compiler flags
" in order to work properly. In particular, if using a non-standard library we
" need access to the include paths for that library.
"
" clang_complete:
" --------------
"   This plugin provides code completion, but more importantly, it allows to
"   jump in code based on semantics. A project can have a '.clang_complete'
"   file which contains the compiler options, one option at a time. Example:
"
"     -DDEBUG
"     -include ../config.h
"     -I../common
"     -I/usr/include/c++/4.5.3/
"     -I/usr/include/c++/4.5.3/x86_64-slackware-linux/

setlocal cinkeys-=0# "don't indent preprocessor directives
setlocal foldmethod=syntax

" spell checking in comments
setlocal spell
setlocal spelllang=en
setlocal spellfile=~/.config/nvim/spell/en.utf-8.add
setlocal spellfile+=~/.config/nvim/spell/programmer-jargon.utf-8.add

if exists('g:plugs["clang_complete"]')
	let g:clang_library_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
	nnoremap <buffer> <silent> gd :call g:ClangGotoDeclaration()<CR>
	nnoremap <buffer> <silent> gp :call g:ClangGotoDeclarationPreview()<CR>
endif

" Chromatica - asynchronous clang-based syntax highlighting
if exists('g:plugs["chromatica.nvim"]')
	let g:chromatica#libclang_path='/usr/lib/llvm-6.0/lib/libclang.so.1'
	execute 'ChromaticaStart'
endif

augroup autochecking
	autocmd!
	autocmd! BufWritePost <buffer> Neomake
augroup END
