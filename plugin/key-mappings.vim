"   _  __                __  __                   _
"  | |/ /___ _   _      |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
"  | ' // _ \ | | |_____| |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|  Various
"  | . \  __/ |_| |_____| |  | | (_| | |_) | |_) | | | | | (_| \__ \  minor
"  |_|\_\___|\__, |     |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/  mappings
"            |___/                   |_|   |_|            |___/     
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


" Make space the leader and local leader
let g:mapleader = ' '
let g:maplocalleader = ' '

" Swap ':' and ';'
nnoremap : ;
nnoremap ; :

" Quickly exit insert- and command mode by pressing kj in succession (supports
" Latin, Cyrillic and Greek)
noremap! kj <esc>
noremap! кј <esc>
noremap! κξ <esc>

" Map keys for scrolling though command line history
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Shortcut to rapidly toggle 'set list'
nnoremap <silent> <leader>l :set list!<CR>

" Turn off search highlights using <CR>
nnoremap <silent> <leader>hl :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
