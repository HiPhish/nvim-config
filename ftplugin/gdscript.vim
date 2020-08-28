"    __________  _____           _       __ 
"   / ____/ __ \/ ___/__________(_)___  / /_
"  / / __/ / / /\__ \/ ___/ ___/ / __ \/ __/  Godot game engine
" / /_/ / /_/ /___/ / /__/ /  / / /_/ / /_  
" \____/_____//____/\___/_/  /_/ .___/\__/  
"                             /_/           

if !has('nvim-0.5.0')
	finish
endif

" LSP key mappings
nnoremap <buffer> <silent> gd    :lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> <silent> gD    :lua vim.lsp.buf.declaration()<CR>
nnoremap <buffer> <silent> gO    :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <buffer> <silent> g?    :lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <buffer> <silent> <C-G> :lua vim.lsp.buf.references()<CR>
nnoremap <buffer> <silent> <F2>  :lua vim.lsp.buf.rename()<CR>
nnoremap <buffer> <silent> K     :lua vim.lsp.buf.hover()<CR>
nnoremap <buffer> <silent> <CR>  :lua require'jdtls'.code_action()<CR>
