" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: Unlicense

setlocal foldmethod=indent

" REPL support
nmap <leader>rs  <Plug>(ReplSend)
nmap <leader>rss <Plug>(ReplSendLine)
nmap <leader>rs_ <Plug>(ReplSendLine)

vmap <leader>rs  <Plug>(ReplSend)

try
	let s:settings = PycodestyleSettings()
	" Calling it a second time, workaround until pynvim gets fixed
	let s:settings = PycodestyleSettings()

	let &textwidth = get(s:settings, 'max-line-length', &textwidth)
	let &tabstop = get(s:settings, 'indent-size', &tabstop)
catch /\v.*/
	" Intentionally ignored
endtry
