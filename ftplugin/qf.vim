" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

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
