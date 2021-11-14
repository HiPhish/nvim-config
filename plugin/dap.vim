function! s:dapui_eval()
	let s:expr = input('DAP expression: ')
	if empty(s:expr)
		return
	endif

	call luaeval('require("dapui").eval(_A)', s:expr)
endfunction

nnoremap <M-k> <Cmd>call <SID>dapui_eval()<CR>
vnoremap <M-k> <Cmd>lua require('dapui').eval()<CR>
