" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Easier node navigation, only for generated documents
if &buftype =~? 'nofile'
	nmap <buffer> gu <Plug>(InfoUp)
	nmap <buffer> gn <Plug>(InfoNext)
	nmap <buffer> gp <Plug>(InfoPrev)
	nmap <buffer> gm <Plug>(InfoMenu)
	nmap <buffer> gf <Plug>(InfoFollow)
	nmap <buffer> go <Plug>(InfoGoto)

	nnoremap <buffer> i :echo b:info<cr>
endif
