local nvim_lsp = require 'nvim_lsp'

-- Load the server configuration into the global table as a side effect
require 'lsp_config/jdt_ls'

if vim.fn.has('nvim-0.5.0') == 0 then
	local ncm2 = require 'ncm2'
	-- Set up the servers in use
	nvim_lsp.jdt_ls.setup {
		on_init = ncm2.register_lsp_source
	}
else
	nvim_lsp.jdt_ls.setup {
		on_attach = require'completion'.on_attach
	}
end
