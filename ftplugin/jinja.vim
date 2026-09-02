" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use tabs for indentation, appear two spaces wide
setlocal noexpandtab copyindent preserveindent
setlocal softtabstop=0 shiftwidth=2 tabstop=2

" If the other language has Tree-sitter highlighting regular syntax
" highlighting will be disabled.  This autocommand forces it back on.
if !get(b:, 'jinja_syntax_autocmd_loaded', v:false)
	let s:ts_lang = luaeval('vim.treesitter.language.get_lang("jinja")')
	try
		" If there is no Tree-sitter Jinja parser this call will fail
		call luaeval('vim.treesitter.language.inspect(_A)', s:ts_lang)
	catch
		autocmd FileType <buffer> if !empty(&ft) | setlocal syntax=on | endif
	endtry
	let b:jinja_syntax_autocmd_loaded = v:true
endif
