" SPDX-FileCopyrightText: © 2020 HiPhish
" SPDX-License-Identifier: 0BSD

setlocal tabstop=2 shiftwidth=0

" Updating the comment string after every cursor movement might be too costly,
" so I'm only using it for Vue for now.
augroup vue_settings
	autocmd!
	autocmd CursorMoved *.vue call <SID>update_commentstring()
augroup END

function! s:update_commentstring()
	if !luaeval('pcall(function() require("ts_context_commentstring") end)')
		return
	endif
	lua require('ts_context_commentstring.internal').update_commentstring()
endfunction
