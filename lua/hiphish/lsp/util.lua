--- Utility functions which are handy to have
local M = {}

--- Creates a new client capabilities table which overrides the defaults.
function M.capabilities(extra)
	local client_capabilities = vim.lsp.protocol.make_client_capabilities()
	return vim.tbl_extend('force', client_capabilities, extra)
end

--- Key mappings for buffers running an LSP client, grouped by mode
M.mappings = {
	--- Normal mode
	n = {
		['gd'   ] =  '<cmd>lua vim.lsp.buf.definition()<CR>',
		['gD'   ] =  '<cmd>lua vim.lsp.buf.declaration()<CR>',
		['gO'   ] =  '<cmd>lua vim.lsp.buf.document_symbol()<CR>',
		['<C-G>'] =  '<cmd>lua vim.lsp.buf.references()<CR>',
		['<F2>' ] =  '<cmd>lua vim.lsp.buf.rename()<CR>',
		['K'    ] =  '<cmd>lua vim.lsp.buf.hover()<CR>',
		['<CR>' ] =  '<cmd>lua vim.lsp.buf.code_action()<CR>',
	}
}

return M
