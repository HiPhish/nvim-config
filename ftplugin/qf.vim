"    ____          _        __    ____ _
"   / __ \ __  __ (_)_____ / /__ / __/(_)_  __
"  / / / // / / // // ___// //_// /_ / /| |/_/  Print errors
" / /_/ // /_/ // // /__ / ,<  / __// /_>  <    to a Vim buffer
" \___\_\\__,_//_/ \___//_/|_|/_/  /_//_/|_|
"                       (Also location list)
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

setlocal nospell
" We don't want any folds here
setlocal foldmethod=manual cursorline

" Use 'o' key to [o]pen the selected error.
nnoremap <buffer> o <CR>
nnoremap <buffer> <ESC> <CMD>quit<CR>

" Get the file type of the associated window
function! s:associated_ft() abort
	let l:win_ids = get(gettabinfo(tabpagenr())[0], 'windows', {})
	let l:loc_id = win_getid()
	let l:Predicate = {_,v -> get(getloclist(v, {'winid': 0}), 'winid', 0) ==# l:loc_id && v !=# l:loc_id }
	let l:win_id = get(filter(l:win_ids, l:Predicate), 0, 0)
	return getbufvar(winbufnr(l:win_id), '&filetype', '')
endfunction

" Automatically close the location list window for the following parent window
" file types.
let s:auto_close_fts = ['man', 'java', 'help']
if !empty(get(s:auto_close_fts, s:associated_ft(), ''))
	nnoremap <buffer><nowait><silent> <CR> <CR>:lclose<CR>
endif
