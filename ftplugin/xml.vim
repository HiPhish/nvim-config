" SPDX-FileCopyrightText: © 2018 HiPhish
" SPDX-License-Identifier: 0BSD

" Use tabs for indentation, appear two spaces wide
setlocal noexpandtab copyindent preserveindent
setlocal softtabstop=0 shiftwidth=2 tabstop=2

" Use Tree-sitter for folding when available
try
	" This will throw an error if the XML parser is not installed
	call v:lua.vim.treesitter.language.inspect('xml')
	setlocal foldmethod=expr foldexpr=v:lua.vim.treesitter.foldexpr()
catch /E5108/
	" See :h xml-folding
	let g:xml_syntax_folding=v:true
	setlocal foldmethod=syntax
endtry
