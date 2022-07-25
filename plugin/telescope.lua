local success, telescope = pcall(require, 'telescope')
if not success then return end
local builtin = require 'telescope.builtin'

telescope.setup {
	defaults = {
		winblend = 30,
		border = true,
		file_ignore_patterns = {
			'%.zip$', '%.tar$', '%.tar.gz$',
			'%.so$', '%.a$', '%.fasl$', '%.pyc$', '%.whl$',
			'%.bin$', '%.db$', 'node_modules'
		},
		mappings = {
			i = {
			},
			n = {
			}
		}
	},
	pickers = {
	},
	extensions = {
	}
}

vim.keymap.set('n', '<C-P>', builtin.find_files)
vim.keymap.set('n', '<C-N>', builtin.buffers)


---[ LSP handlers ]------------------------------------------------------------
vim.lsp.handlers['textDocument/references'] = builtin.lsp_references
vim.lsp.handlers['textDocument/documentSymbol'] = builtin.lsp_document_symbols
