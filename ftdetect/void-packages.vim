" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

" Void package templates are actually shell scripts
autocmd BufRead,BufNewFile template call s:adjustFileType()

function! s:adjustFileType()
	" This assumes the repository has not been renamed and it is the current
	" working directory.
	if fnamemodify(getcwd(), ':t') != 'void-packages'
		return
	endif
	setfiletype sh
endfunction
