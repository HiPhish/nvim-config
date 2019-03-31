"     ______  __ __          _   ______________     __  ___
"    / ____/_/ // /_        / | / / ____/_  __/    /  |/  /___  ____  ____
"   / /   /_  _  __/       /  |/ / __/   / /      / /|_/ / __ \/ __ \/ __ \
"  / /___/_  _  __/     _ / /|  / /___  / /      / /  / / /_/ / / / / /_/ /
"  \____/ /_//_/       (_)_/ |_/_____/ /_/      /_/  /_/\____/_/ /_/\____/
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

" ===[ Options ]==============================================================
" Foldmethod 'syntax' is too slow, use manually placed regions instead
setlocal foldmethod=marker
setlocal foldmarker=#region,#endregion

" This setting controls how long to wait (in ms) before fetching type / symbol
" information.
setlocal updatetime=500

" Remove 'Press Enter to continue' message when type information is longer
" than one line.
setlocal cmdheight=2

"Don't ask to save when changing buffers (i.e. when jumping to a type
"definition)
setlocal hidden


" ===[ Keymappings ]==========================================================
if exists('g:plugs["omnisharp-vim"]')
	nnoremap <silent> <buffer> gd :OmniSharpGotoDefinition<CR>
	nnoremap <silent> <buffer> <Leader>osrn :OmniSharpRename<CR>
	nnoremap <silent> <buffer> <leader>dc :OmniSharpDocumentation<cr>
endif


" ===[ Auto=completion ]======================================================
setlocal omnifunc=OmniSharp#Complete


" ===[ Omnisharp ]============================================================
" Set the type lookup function to use the preview window instead of the status
" line
let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 2

" Support snippets
let g:OmniSharp_want_snippet=1


" don't autoselect first item in omnicomplete, show if only one item (for
" preview) remove preview if you don't want to see any documentation
" whatsoever.
setlocal completeopt=longest,menuone,preview

" If you are using the omnisharp-roslyn backend, use the following
let g:syntastic_cs_checkers = ['code_checker']

augroup omnisharp_commands
	autocmd!
	autocmd BufWritePost *.cs SyntasticCheck
augroup END
