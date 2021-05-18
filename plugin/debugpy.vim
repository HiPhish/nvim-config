if !luaeval('pcall(require, "dap")')
	finish
endif

command! -nargs=* Debugpy call s:debugpy(<f-args>)

let s:last_cmd  = ''
let s:last_args = []

function! s:debugpy(...) abort
	if a:0 == 0
		if empty(s:last_cmd)
			echoerr 'Debugpy needs at least one argument'
			return
		endif
	else
		let s:last_cmd  = a:1
		let s:last_args = a:000[1:]
	endif

	call s:dispatch(s:last_cmd, s:last_args)
endfunction

function! s:dispatch(cmd, args) abort
	if a:cmd == 'module'
		if len(a:args) == 1
			call s:module(a:args[0])
			return
		endif
	endif

	echoerr 'Wrong arguments for Debugpy ' .. a:cmd .. ': ' .. string(a:args)
endfunction


function! s:module(module) abort
	call luaeval('require("hiphish.dap.debugpy").debug_module(_A)', a:module)
endfunction
