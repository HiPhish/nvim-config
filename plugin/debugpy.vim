if !luaeval('pcall(require, "dap")') || get(g:, 'debugpy_loaded', v:false)
	finish
endif
let g:debugpy_loaded = v:true

command! -nargs=* -complete=customlist,s:complete Debugpy call s:debugpy(<f-args>)

" Shortcut, save the last invocation here so we can re-call it if no arguments
" are given to the main command.
let s:cmd  = ''
let s:args = []


" ---[ IMPLEMENTATIONS ]-------------------------------------------------------
function! s:module(args) abort
	let [l:module] = a:args
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_module(_A)', l:module)
endfunction

function! s:program(args) abort
	let [l:program; l:args] = len(a:args) == 0 ? ['${file}'] : a:args
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_program(_A[1], _A[2])', [l:program, l:args])
endfunction

function! s:remote(args)
	let [l:host, l:port] = args
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_remote(_A)', [l:host, l:port])
endfunction

function! s:test(args)
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_test()')
endfunction

function! s:class(args)
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_class()')
endfunction

function! s:select(args)
	call luaeval('require("hiphish.dap.configurations.debugpy").debug_selection()')
endfunction


" ---[ RULES ]-----------------------------------------------------------------
" Table which maps a sub-command to its specification. The specifications
" contains the function to dispatch to as well as the arity range of the
" sub-command.
let s:dispatch_table = {
	\ 'module' : {'func': function('s:module' ), 'minargs': 1, 'maxargs': 1},
	\ 'program': {'func': function('s:program'), 'minargs': 0,             },
	\ 'remote' : {'func': function('s:remote' ), 'minargs': 2, 'maxargs': 2},
	\ 'test'   : {'func': function('s:test'   ), 'minargs': 0, 'maxargs': 0},
	\ 'class'  : {'func': function('s:class'  ), 'minargs': 0, 'maxargs': 0},
	\ 'select' : {'func': function('s:select' ), 'minargs': 0, 'maxargs': 0},
\ }

" Ideas for the future:
"   - attach to running process (requires PID)
"   - load configuration from JSON file
"   - set base config options (might be too much work)


" ---[ BACKBONE ]--------------------------------------------------------------
function! s:debugpy(...) abort
	if a:0 == 0
		if empty(s:cmd)
			call s:err('Debugpy needs at least one argument')
			return
		endif
	else
		let s:cmd  = a:1
		let s:args = a:000[1:]
	endif

	let l:target = get(s:dispatch_table, s:cmd, {})
	if empty(l:target)
		call s:err(' Debugpy: invalid subcommand ' .. s:cmd)
		return
	endif

	let [l:Func, l:minargs] = [l:target.func, l:target.minargs]
	if len(s:args) < l:minargs
		call s:err(printf('Debugpy %s: not enough arguments, needs at least %d, got %d', s:cmd, l:minargs, len(s:args)))
		return
	elseif has_key(l:target, 'maxargs') && len(s:args) > l:target.maxargs
		let l:maxargs = l:target.maxargs
		call s:err(printf('Debugpy %s: too many arguments, needs at most %d, got %d', s:cmd, l:maxargs, len(s:args)))
		return
	endif

	call l:Func(s:args)
endfunction

function! s:err(msg)
	echohl ErrorMsg
	echo a:msg
	echohl None
endfunction

function! s:complete(arg_lead, cmd_line, cursor_pos)
	" Abort if the sub-command has been completed. Special case when the
	" command line ends with whitespace: second argument has been completed
	let l:nargs = len(split(a:cmd_line, '\v\s+'))
	if l:nargs > 2 || l:nargs == 2 && a:cmd_line[-1:] =~? '\v\s'
		return []
	endif
	let l:Test = {i,v -> match(v, '\v^' .. a:arg_lead) >= 0}
	return filter(keys(s:dispatch_table), l:Test)
endfunction
