" Custom LSP commands

" The following applies to the built-in LSP client only
if !has('nvim-0.5')
	finish
endif

command! -nargs=+ -complete=custom,<SID>complete Lsp call s:lsp(<f-args>)


" ---[ Command implementations ]-----------------------------------------------
function! s:impl(vargs)
	lua vim.lsp.buf.implementation()
endfunction

function! s:definition(vargs)
	lua vim.lsp.buf.definition()
endfunction

function! s:declaration(vargs)
	lua vim.lsp.buf.declaration()
endfunction

function! s:references(vargs)
	lua vim.lsp.buf.references()
endfunction

function! s:rename(vargs)
	lua vim.lsp.buf.rename()
endfunction

function! s:symbols(vargs)
	lua vim.lsp.buf.document_symbol()
endfunction

function! s:actions(vargs)
	lua require'jdtls'.code_action()
endfunction

" Forcefully stop all clients, restart the current client
function! s:reset(vargs)
	lua vim.lsp.stop_client(vim.lsp.get_active_clients())
	edit
endfunction

" -----------------------------------------------------------------------------
function! s:lsp(cmd, ...) abort
	if luaeval('vim.tbl_count(vim.lsp.buf_get_clients())') < 1
		echoerr 'Current buffer not attached to any LSP server'
		return
	endif

	if !has_key(s:commands, a:cmd)
		echoerr 'LSP sub-command ' .. a:cmd .. ' not defined.'
		return
	endif

	call s:commands[a:cmd](a:000)
endfunction

let s:commands = { 
	\ 'implementation': function('s:impl'),
	\ 'definition': function('s:definition'),
	\ 'declaration': function('s:declaration'),
	\ 'references': function('s:references'),
	\ 'rename': function('s:rename'),
	\ 'actions': function('s:actions'),
	\ 'symbols': function('s:symbols'),
	\ 'reset': function('s:reset'),
\ }

" Put sub-command completion function here; the sub-command is the key
let s:completions = {
\ }

function! s:complete(arg_lead, cmd_line, cursor_pos)
	let l:words = split(a:cmd_line, '\v\s+', v:true)

	if len(l:words) < 3
		return join(keys(s:commands), "\n")
	else
		return join(get(s:completions, words[1], []))
	endif
endfunction
